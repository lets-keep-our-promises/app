//
//  StartView.swift
//  Els
//
//  Created by Boseok Son on 9/11/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
            VStack {
                Image("ELSLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    
                Spacer()
                    .frame(height: 50)
                    
                NavigationLink(destination: ConnectView()){
                    CustomText(title: "계속하기")
                        .navigationBarBackButtonHidden()
                }
                .buttonStyle(PlainButtonStyle())
            }
    }
}

#Preview {
    StartView()
        .frame(minWidth: 750, minHeight: 500)
}
