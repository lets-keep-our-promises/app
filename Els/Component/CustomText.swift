//
//  CustomButton.swift
//  Els
//
//  Created by 박성민 on 10/3/24.
//

import SwiftUI

struct CustomText: View {
    var title: String = "test"
    var body: some View {
        Text(title)
            .frame(width: 125, height: 50)
            .font(.system(size: 18))
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .background(.customLavender)
            .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

#Preview {
    CustomText()
        .frame(width: 500,height: 500)
}
