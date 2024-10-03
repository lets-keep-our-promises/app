//
//  StartView.swift
//  Els
//
//  Created by Boseok Son on 9/11/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("ELSLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    
                Spacer()
                    .frame(height: 50)
                    
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("계속하기")
                            .frame(width: 125, height: 50)
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .background(.customLavender)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                )
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    StartView()
        .frame(minWidth: 750, minHeight: 500)
}
