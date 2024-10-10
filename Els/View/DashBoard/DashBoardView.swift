//
//  DashBoardView.swift
//  Els
//
//  Created by 박성민 on 10/3/24.
//

import SwiftUI

struct DashBoardView: View {
    @StateObject var dashBoardViewModel = DashBoardViewModel()
    var body: some View {
        HStack{
            VStack{
                DashBoard_Live()
                    .frame(width: 150,height: 210)
                    .background(Color.white)
                    .cornerRadius(30)
                
                b()
                    .frame(width: 150,height: 210)
                    .background(Color.blue)
                    .cornerRadius(30)
            }
            VStack{
                HStack{
                    VStack{
                        HStack{
                            c()
                                .frame(width: 140,height: 120)
                                .background(Color.yellow)
                                .cornerRadius(30)

                            
                            d()
                                .frame(width: 140,height: 120)
                                .background(Color.green)
                                .cornerRadius(30)
                        }
                        
                        e()
                            .frame(width: 300,height: 168)
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    VStack{
                        f()
                            .frame(width: 150,height: 60)
                            .background(Color.cyan)
                            .cornerRadius(20)
                        
                        g()
                            .frame(width: 150,height: 225)
                            .background(Color.red)
                            .cornerRadius(30)
                    }
                }
                HStack{
                    DashBoard_Logo()
                        .frame(width: 150,height: 120)
                        .background(Color.white)
                        .cornerRadius(30)
                    
                    i()
                        .frame(width: 300,height: 120)
                        .background(Color.orange)
                        .cornerRadius(30)
                }
            }
        }
        .environmentObject(dashBoardViewModel)
    }
}

#Preview {
    DashBoardView()
        .frame(width: 750, height: 500)
}

struct a : View {
    var body: some View {
        VStack{
            Text(" ")
        }
    }
}

struct b : View {
    var body: some View {
        VStack{
            Text("b")
        }
    }
}

struct c : View {
    var body: some View {
        VStack{
            Text("c")
        }
    }
}

struct d : View {
    var body: some View {
        VStack{
            Text("d")
        }
    }
}

struct e : View {
    var body: some View {
        VStack{
            Text(" ")
                .foregroundStyle(.white)
        }
    }
}

struct f : View {
    var body: some View {
        VStack{
            Text("f")
        }
    }
}

struct g : View {
    var body: some View {
        VStack{
            Text(" ")
        }
    }
}

struct i : View {
    var body: some View {
        VStack{
            Text("i")
        }
    }
}
