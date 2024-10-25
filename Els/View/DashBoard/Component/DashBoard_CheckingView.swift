//
//  DachBoard_CheckingView.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashBoard_CheckingView: View {
    @EnvironmentObject var motionManager: DashBoardViewModel
    var body: some View {
        if motionManager.posture{
            DashBoardCheckOK()
        } else {
            DashBoardCheckNo()
        }
    }
}

fileprivate struct DashBoardCheckOK: View {
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text("Status")
                    .fontWeight(.semibold)
                
                Spacer()
                    .frame(height: 20)
                
                Text("지금은")
                    .fontWeight(.semibold)

                Text("올바른자세")
                    .font(.system(size: 17,weight: .bold))
                HStack{
                    Spacer()
                        .frame(width: 47)
                    
                    Text("예요.")
                        .fontWeight(.semibold)
                }
            }
            AnimatedImage(url:URL(string:"https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Slightly%20Smiling%20Face.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
        }
    }
}

fileprivate struct DashBoardCheckNo: View {
    var body: some View{
        HStack{
            VStack(alignment:.leading){
                Text("Status")
                    .fontWeight(.semibold)
                
                Spacer()
                    .frame(height: 20)
                
                Text("지금은")
                    .fontWeight(.semibold)

                Text("올바른자세")
                    .font(.system(size: 17,weight: .bold))
                HStack{
                    Spacer()
                        .frame(width:10)
                    
                    Text("가 아니에요.")
                        .fontWeight(.semibold)
                }
            }
            AnimatedImage(url:URL(string:"https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Smilies/Pensive%20Face.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
        }
    }
}

#Preview {
    DashBoard_CheckingView()
        .environmentObject(DashBoardViewModel())
        .frame(width: 210,height: 140)
}
