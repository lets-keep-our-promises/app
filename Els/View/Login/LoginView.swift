//
//  LoginView.swift
//  Els
//
//  Created by 박성민 on 9/19/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack{
            Image("ELSLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
            
            Spacer()
                .frame(height: 20)
            
            Text("계속하려면 로그인 해야해요.")
                .font(.system(size:25,weight: .semibold))
            
            Spacer()
                .frame(height: 40)
            
            HStack{
                LoginBtn(action: loginViewModel.appleLogin, imageString: "AppleLogo")
                
                Spacer()
                    .frame(width: 40)
                
                LoginBtn(action: loginViewModel.googleLogin, imageString: "GoogleLogo")
            }
        }
    }
}

private struct LoginBtn: View{
    var action: () -> Void
    var imageString = ""
    var body: some View{
        Button(
            action: {
                self.action()
            },
            label: {
                VStack{
                    Image(imageString)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                .frame(width: 160,height: 55)
            }
        )
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.3), lineWidth:1))
    }
}

#Preview {
    LoginView()
        .frame(minWidth: 750, minHeight: 500)
}
