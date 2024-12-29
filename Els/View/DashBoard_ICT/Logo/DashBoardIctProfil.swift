//
//  DashBoardIctProfil.swift
//  Els
//
//  Created by 박성민 on 10/9/24.
//

import SwiftUI

struct DashBoardIctProfil: View {
    var body: some View {
        HStack{
            ZStack{
                Image("SchoolLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
            }
            
            VStack(alignment:.leading){
                Text("경북소프트웨어고")
                    .font(.system(size: 20,weight: .bold))
                
                Spacer()
                    .frame(height: 5)
                
                Text(verbatim: "gbswhs@naver.com")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    DashBoardIctProfil()
        .frame(width: 230,height: 90)
}
