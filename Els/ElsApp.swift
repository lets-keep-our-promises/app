import SwiftUI

@main
struct ElsApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                // Set the background color to white for the entire view
                Color.white
                    .edgesIgnoringSafeArea(.all) // Ensure it covers the entire screen
                
//                DashBoardIctView() // Your dashboard view
//                    .frame(width: 750, height: 500)
//                    .padding(.bottom,
                ContentView()
                    .frame(width: 750, height: 500)
                    .padding(.bottom)
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
