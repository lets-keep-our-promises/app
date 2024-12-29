//
//  DashBoardIctView.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import SwiftUI

struct DashBoardIctView: View {
    @StateObject var motionManager = DashBoardViewModel()
    var body: some View {
        ZStack{
            Color(.gray).opacity(0.1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack{
                VStack{
                    HStack{
                        DashBoard_CharacterView()
                            .frame(width: 210,height: 140)
                            .background(Color.white)
                            .cornerRadius(30)
                        
                        DashBoard_CheckingView()
                            .frame(width: 210,height: 140)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                    
                    HStack{
                        DashBoard_ConnectTimeView()
                            .frame(width: 210,height: 140)
                            .background(Color.yellow)
                            .cornerRadius(30)
                        
                        DashBoardIctLogo()
                            .frame(width: 210,height: 140)
                            .cornerRadius(30)
                            .shadow(color:.black.opacity(0.1),radius:5)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    DashBoard_DailyView()
                        .frame(width: 430,height: 140)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                Spacer()
                    .frame(width: 10)
                VStack{
                    DashBoardIctProfil()
                        .frame(width: 240,height: 90)
                        .background()
                        .cornerRadius(30)
                    
                    DashBoard_Live()
                        .frame(width: 240,height: 340)
                        .background(Color.white)
                        .cornerRadius(30)
                }
            }
        }
        .environmentObject(motionManager)
    }
}

#Preview {
    DashBoardIctView()
        .environmentObject(DashBoardViewModel())
        .frame(width: 750, height: 500)
}
