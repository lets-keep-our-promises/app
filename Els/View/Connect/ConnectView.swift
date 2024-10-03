//
//  ConnectView.swift
//  Els
//
//  Created by 박성민 on 9/25/24.
//
import SwiftUI

struct ConnectView: View {
    @StateObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        VStack{
            Image("AirPodsClose")
                .resizable()
                .scaledToFit()
                .frame(width: 225)
            
            Spacer()
                .frame(height: 20)
            
            Text("이제 AirPods를 연결해봅시다")
                .font(.system(size: 15,weight: .bold))
            
       
            Spacer()
                .frame(height: 50)
            ScrollView {
                VStack{
                    ForEach(bluetoothViewModel.devices, id: \.peripheral.identifier) { device in
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
        .padding(.top, 100)
        .onAppear {
            bluetoothViewModel.startScanning()
        }
        
    }
}

#Preview {
    ConnectView()
        .frame(minWidth: 750, minHeight: 500)
}
