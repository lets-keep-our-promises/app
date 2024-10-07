//
//  DashBoard_Live.swift
//  Els
//
//  Created by 박성민 on 10/7/24.
//

import SwiftUI

struct DashBoard_Live: View {
    @ObservedObject var motionManager: DashBoardViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Live")
                
                Spacer()
            }.padding(.leading,30)
            HStack{
                Text("움직임을 실시간으로 확인해요")
            }
            ZStack{
                Circle()
                    .stroke(Color.red, lineWidth: 3)
                    .frame(width: 100, height: 120)
                    .shadow(
                        color: .red ,
                        radius: 3,
                        x: 1, y: 1)
                Circle()
                    .foregroundStyle(.red)
                    .frame(width: 20,height: 300)
                    .offset(
                        x: CGFloat((motionManager.referenceYaw  - motionManager.yaw) * 50),
                        y: CGFloat((motionManager.referencePitch - motionManager.pitch) * 50)
                    )
                
            }
            .frame(height:150)
            Button(
                action:{                motionManager.setReferenceAttitude()
                },
                label: {
                    Text("초기화")
                }
            )
        }
    }
}

#Preview {
    DashBoard_Live(motionManager: DashBoardViewModel())
        .frame(width: 150,height: 500)
}
