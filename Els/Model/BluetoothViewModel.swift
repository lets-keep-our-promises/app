import SwiftUI
import CoreBluetooth

struct BluetoothDevice {
    var peripheral: CBPeripheral
    var rssi: Int
    var isAirPodsPro: Bool
}

class BluetoothViewModel: NSObject, ObservableObject {
    @Published var devices: [BluetoothDevice] = []
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
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
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("제대로됨")
            self.startScanning()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let isAirPodsPro = isAirPodsPro(name: peripheral.name)
        
        DispatchQueue.main.async {
            if let name = peripheral.name {
                if let index = self.devices.firstIndex(where: { $0.peripheral.identifier == peripheral.identifier }) {
                    self.devices[index] = BluetoothDevice(peripheral: peripheral, rssi: RSSI.intValue, isAirPodsPro: isAirPodsPro)
                } else {
                    self.devices.append(BluetoothDevice(peripheral: peripheral, rssi: RSSI.intValue, isAirPodsPro: isAirPodsPro))
                }
            }
        }
    }
}
