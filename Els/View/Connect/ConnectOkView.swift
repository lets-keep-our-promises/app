//
//  ConnectOkView.swift
//  Els
//
//  Created by 박성민 on 10/3/24.
//

import SwiftUI

struct ConnectOkView: View {
    var body: some View {
        VStack{
            Text("에어팟 연결이 완료 되었어요!")
                .font(.system(size: 20,weight: .bold))
            
            Spacer()
                .frame(height: 30)
            
            Image("AirPodsOpen")
                .resizable()
                .scaledToFit()
                .frame(width:225)
            
            Spacer()
                .frame(height: 50)
            NavigationLink(destination: DashBoardIctView()){
                CustomText(title: "확인")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    ConnectOkView()
        .frame(width: 750, height: 500)
}
