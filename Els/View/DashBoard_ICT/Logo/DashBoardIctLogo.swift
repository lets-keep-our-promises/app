//
//  DashBoardIctLogo.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import SwiftUI

struct DashBoardIctLogo: View {
    var gradient1 = Color(red: 255/255, green:237/255, blue: 255/255)
    var gradient2 = Color(red:224/255, green: 224/255,blue: 255/255)
    var dark = Color(red:71/255, green: 71/255,blue: 79/255)
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [dark, dark]), startPoint: .topLeading, endPoint: .bottomTrailing)

//            Image("ELSLogo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50)
            DashboardChartView(viewModel: DashBoardViewModel())
        }
    }
}

#Preview {
    DashBoardIctLogo()
        .frame(width: 200,height: 140)
}
