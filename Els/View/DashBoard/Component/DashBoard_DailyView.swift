//
//  DashBoard_DailyView.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import SwiftUI

struct DashBoard_DailyView: View {
    @EnvironmentObject var motionManager: DashBoardViewModel
    var body: some View {
        VStack{
            HStack{
                Spacer()
                    .frame(width: 15)
                Text("Daily")
                    .font(.system(size: 10))
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 5)
            
            HStack{
                TimeDisplayItemView(title: "MacBook",time: motionManager.formattedTotalTime, endTitle: "동안 사용함")
                    .frame(width: 100)
                
                Spacer()
                    .frame(width: 50)
                
                TimeDisplayItemView(title: "정상 자세", time: motionManager.formattedNormalTime, endTitle:"만큼 유지됨")
                    .frame(width: 100)
                
                Spacer()
                    .frame(width: 50)

                TimeDisplayItemView(title: "비정상 자세", time: motionManager.formattedAbnormalTime, endTitle:"만큼 유지됨")
                    .frame(width: 100)
            }
        }
    }
}

fileprivate struct TimeDisplayItemView: View {
    var title : String
    var time : String
    var endTitle : String
    
    init(
        title: String = "MacBook",
        time: String = "00:00",
        endTitle: String = "동안 사용함"
    ) {
        self.title = title
        self.time = time
        self.endTitle = endTitle
    }
    var body: some View{
        VStack(alignment:.leading){
            Text(title)
                .font(.system(size: 10,weight: .semibold))
//            Spacer()
//                .frame(height: 2)
            Text(time)
                .font(.system(size: 34,weight: .bold))
//            Spacer()
//                .frame(height: 2)
            HStack{
                Spacer()
                Text(endTitle)
                    .font(.system(size: 10,weight: .semibold))
            }
        }
    }
}

#Preview {
    DashBoard_DailyView()
        .frame(width: 430,height: 140)
        .environmentObject(DashBoardViewModel())
}
