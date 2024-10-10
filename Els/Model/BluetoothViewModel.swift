import SwiftUI
import CoreBluetooth
import IOBluetooth

struct BluetoothDevice {
    var peripheral: CBPeripheral
    var rssi: Int
    var isAirPodsPro: Bool
}

class BluetoothViewModel: NSObject, ObservableObject {
    @Published var devices: [BluetoothDevice] = []
    @Published var isAirPodsConnected = false
    
    private var centralManager: CBCentralManager?
    private var timer: Timer?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        checkForConnectedAirPods()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkForConnectedAirPods()
        }
    }
    
    func startScanning() {
        centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    private func isAirPodsPro(name: String?) -> Bool {
        if let name = name, name.contains("AirPods Pro") {
            return true
        }
        return false
    }
    
    private func checkForConnectedAirPods() {
        guard let pairedDevices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] else {
            return
        }
        
        for device in pairedDevices {
            if device.isConnected(), let name = device.name {
                if name.contains("AirPods Pro") {
                    print("에어팟 프로가 연결되어 있습니다")
                    isAirPodsConnected = true
                    stopAllActivities()
                    return
                }
            }
        }
        
        print("연결된 에어팟 프로가 없습니다.")
    }
    
    private func stopAllActivities() {
        timer?.invalidate()
        timer = nil
            
        centralManager?.stopScan()
        print("모든 작업이 종료시킴.")
    }
    
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.startScanning()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let isAirPodsPro = isAirPodsPro(name: peripheral.name)
        
        DispatchQueue.main.async {
            if peripheral.name != nil {
                if let index = self.devices.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
                    self.devices[index] = BluetoothDevice(peripheral: peripheral, rssi: RSSI.intValue, isAirPodsPro: isAirPodsPro)
                } else {
                    self.devices.append(BluetoothDevice(peripheral: peripheral, rssi: RSSI.intValue, isAirPodsPro: isAirPodsPro))
                }
            }
        }
    }
}
