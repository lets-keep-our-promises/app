//
//  DashBoard_Live.swift
//  Els
//
//  Created by 박성민 on 10/7/24.
//

import SwiftUI

struct DashBoard_Live: View {
    @EnvironmentObject var motionManager: DashBoardViewModel
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                Text("Live")
                    .font(.title)
                    .fontWeight(.bold)
                Text("움직임을 실시간으로 확인해요")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
            }
            .padding(.trailing,40)
            ZStack{
                Circle()
                    .stroke(Color(red: 130/255, green: 134/255, blue: 255/255), lineWidth: 10)
                    .frame(width: 100, height: 120)
//                    .shadow(
//                        color: .red ,
//                        radius: 3,
//                        x: 1, y: 1)
                Circle()
                    .foregroundStyle(Color(red: 130/255, green: 134/255, blue: 255/255))
                    .frame(width: 50)
                    .offset(
                        x: CGFloat((motionManager.referenceRoll  - motionManager.roll) * 60),
                        y: CGFloat((motionManager.referencePitch - motionManager.pitch) * 60)
                    )
                
            }
            .frame(height:150)
            Button(
                action:{
                    motionManager.setReferenceAttitude()
                },
                label: {
                    Text("초기화")
                        .padding()
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 40)
                        .background(Color(red: 130/255, green: 134/255, blue: 255/255))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            )
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    DashBoard_Live()
        .frame(width: 240,height: 340)
        .environmentObject(DashBoardViewModel())
}
