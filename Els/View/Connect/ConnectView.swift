//
//  ConnectView.swift
//  Els
//
//  Created by 박성민 on 9/25/24.
//
import SwiftUI

struct ConnectView: View {
    @StateObject private var bluetoothViewModel = BluetoothViewModel()
    
    @State private var isAnimating = false
    var body: some View {
        VStack{
            if bluetoothViewModel.isAirPodsConnected {
                ConnectOkView()
            }else {
                ConnectSettingView(bluetoothViewModel: bluetoothViewModel)
            }
        }
    }
}

fileprivate struct ConnectSettingView: View {
    @ObservedObject var bluetoothViewModel: BluetoothViewModel
    fileprivate var body: some View{
        VStack{
            VStack{
                Image("AirPodsClose")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 225)
                
                Spacer()
                    .frame(height: 20)
                
                Text("애어팟 기기를 연결해주세요.")
                    .font(.system(size: 15,weight: .bold))
                
                AirPodsSearchingView(devices: bluetoothViewModel.devices)
            }
            .padding(.top, 100)
        }
    }
}

fileprivate struct AirPodsSearchingView : View {
    let devices: [BluetoothDevice]
    fileprivate var body: some View{
        ScrollView {
            VStack{
                ForEach(devices, id: \.peripheral.identifier) { device in
                    if device.isAirPodsPro {
                        HStack(alignment: .center){
                            Image("AirPodsSmall")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                            
                            Text(device.peripheral.name ?? "")
                                    .font(.headline)
                            
                            Spacer()
                        }
                        .padding(.leading,10)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(10)
                    }
                }
            }
            .frame(width: 400, height: 150, alignment: .top)
            .padding(.leading, 16)
        }
        .frame(width: 400,height: 150, alignment: .top)
        .scrollIndicators(.never)
    }
}

#Preview {
    ConnectView()
        .frame(minWidth: 750, minHeight: 500)
}
    
