import SwiftUI

struct DashBoard_Live: View {
    @EnvironmentObject var motionManager: DashBoardViewModel
    @State private var smoothedRoll: Double = 0
    @State private var smoothedPitch: Double = 0
    
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                Text("Live")
                    .font(.title)
                    .fontWeight(.bold)
                Text("움직임을 실시간으로 확인해요")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.gray)
            }
            .padding(.trailing,40)
            ZStack{
                Circle()
                    .stroke(Color(red: 130/255, green: 134/255, blue: 255/255), lineWidth: 10)
                    .frame(width: 100, height: 120)
                Circle()
                    .foregroundStyle(Color(red: 130/255, green: 134/255, blue: 255/255))
                    .frame(width: 50)
                    .offset(
                        x: CGFloat(-(smoothedRoll) * 30),
                        y: CGFloat((smoothedPitch) * 30)
                    )
                    .animation(.interpolatingSpring(stiffness: 300, damping: 15), value: smoothedRoll)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 15), value: smoothedPitch)
            }
            .frame(height:150)
            Button(
                action:{
                    motionManager.setReferenceAttitude()
                    smoothedRoll = 0
                    smoothedPitch = 0
                },
                label: {
                    Text("초기화")
                        .padding()
                        .font(.system(size: 15,weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 40)
                        .background(Color(red: 130/255, green: 134/255, blue: 255/255))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            )
            .buttonStyle(PlainButtonStyle())
        }
        .onReceive(motionManager.$roll) { newRoll in
            smoothedRoll = smoothedRoll * 0.9 + (motionManager.referenceRoll - newRoll) * 0.1
            smoothedRoll = max(-1, min(1, smoothedRoll))  // 범위 제한
        }
        .onReceive(motionManager.$pitch) { newPitch in
            smoothedPitch = smoothedPitch * 0.9 + (motionManager.referencePitch - newPitch) * 0.1
            smoothedPitch = max(-1, min(1, smoothedPitch))  // 범위 제한
        }
    }
}
