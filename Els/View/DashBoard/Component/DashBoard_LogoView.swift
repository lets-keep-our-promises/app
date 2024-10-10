//
//  DashBoard_Logo.swift
//  Els
//
//  Created by 박성민 on 10/6/24.
//

import SwiftUI

struct DashBoard_Logo: View {
    var body: some View {
        VStack{
            Image("ELSLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
    }
}

#Preview {
    DashBoard_Logo()
        .frame(width: 150,height: 120)
        .cornerRadius(30)
}
