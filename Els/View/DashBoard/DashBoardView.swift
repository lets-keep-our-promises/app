//
//  DashBoardView.swift
//  Els
//
//  Created by 박성민 on 10/3/24.
//

import SwiftUI

struct DashBoardView: View {
    var body: some View {
        HStack{
            VStack{
                a()
                    .frame(width: 150,height: 200)
                    .background(Color.red)
                    .cornerRadius(30)
                
                b()
                    .frame(width: 150,height: 200)
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
                            .cornerRadius(30)
                        
                        g()
                            .frame(width: 150,height: 225)
                            .background(Color.orange)
                            .cornerRadius(30)
                    }
                }
                HStack{
                    h()
                        .frame(width: 150,height: 120)
                        .background(Color.pink)
                        .cornerRadius(30)
                    
                    i()
                        .frame(width: 300,height: 120)
                        .background(Color.teal)
                        .cornerRadius(30)
                }
            }
        }
    }
}

#Preview {
    DashBoardView()
        .frame(width: 750, height: 500)
}

struct a : View {
    var body: some View {
        VStack{
            Text("a")
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
            Text("e")
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
            Text("g")
        }
    }
}

struct h : View {
    var body: some View {
        VStack{
            Text("h")
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
