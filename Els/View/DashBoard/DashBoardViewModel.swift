//
//  DashBoardViewModel.swift
//  Els
//
//  Created by 박성민 on 10/6/24.
//

import Foundation
import CoreMotion

class DashBoardViewModel: ObservableObject {
    private let motionManager = CMHeadphoneMotionManager()
    
    @Published var pitch: Double = 0
    @Published var yaw: Double = 0
    
    @Published var referencePitch: Double = 0
    @Published var referenceYaw: Double = 0
    
    init() {
        setupMotionManager()
    }
        
    func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let self = self, let motion = motion, error == nil else { return }
                self.pitch = motion.attitude.pitch
                self.yaw = motion.attitude.yaw
            }
        }
    }
    
    func setReferenceAttitude() {
        print("재설정")
        referencePitch = pitch
        referenceYaw = yaw
    }
}
