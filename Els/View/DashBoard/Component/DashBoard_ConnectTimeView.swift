//
//  DashBoard_ConnectTimeView.swift
//  Els
//
//  Created by 박성민 on 10/10/24.
//

import SwiftUI

struct DashBoard_ConnectTimeView: View {
    @EnvironmentObject var motionManager: DashBoardViewModel

    var body: some View {
        if motionManager.isPaused {
            AirPodsConnectNoView()
        } else {
            AirPodsConnectOkView()
        }
    }
}

fileprivate struct AirPodsConnectNoView: View {
    var customRed = Color(red:255/255, green:240/255, blue:240/255)
    var customRed1 = Color(red:255/255, green:230/255, blue:230/255)
    var body: some View{
        ZStack{
            customRed
            
            HStack{
                ZStack{
                    Circle()
                        .stroke(customRed1,lineWidth: 10)
                        .frame(width: 50)
                    
                    Image("AirPodsSmall")
                }
                Spacer()
                    .frame(width: 30)
                VStack{
                    Text("Connection")
                        .font(.system(size: 12,weight:.semibold))
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("연결 끊어짐")
                        .font(.system(size:10,weight: .semibold))
                }
            }
        }
    }
}

fileprivate struct AirPodsConnectOkView : View {
    @EnvironmentObject var motionManager: DashBoardViewModel
    var customGreen = Color(red:243/255, green: 255/255, blue: 238/255)
    var customGreen1 = Color(red:211/255, green:255/255,blue: 200/255)
    var body: some View{
        ZStack{
            customGreen
            
            HStack{
                ZStack{
                    Circle()
                        .stroke(customGreen1,lineWidth: 10)
                        .frame(width: 50)
                    
                    Image("AirPodsSmall")
                }
                Spacer()
                    .frame(width: 30)
                VStack{
                    Text("Connection")
                        .font(.system(size: 12,weight:.semibold))
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text(motionManager.formattedConnectTime)
                        .font(.system(size: 20,weight: .bold))
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("동안 연결됨")
                }
            }
        }
    }
}

#Preview {
    DashBoard_ConnectTimeView()
        .frame(width: 210,height: 140)
        .environmentObject(DashBoardViewModel())
}
