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
    @Published var roll: Double = 0
    
    @Published var referencePitch: Double = 0
    @Published var referenceRoll: Double = 0
    
    @Published var posture = true
    @Published var isPaused = false
    
    @Published var formattedTotalTime = "00H 00M"
    @Published var formattedNormalTime = "00H 00M"
    @Published var formattedAbnormalTime = "00H 00M"
    @Published var formattedConnectTime = "00H 00M"
    
    private var totalTime = 0.0
    private var normalTime = 0.0
    private var abnormalTime = 0.0
    private var connectTime = 0.0
    
    private var checkingTimer : Timer?
    private var dailyResetTimer: Timer?
    
    private var lastMotionUpdateTime: Date = Date()
    private let pauseThreshold: TimeInterval = 3.0
    
    init() {
        setupMotionManager()
        startMonitoringPosture()
        scheduleMidnightReset()
    }
        
    func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let self = self, let motion = motion, error == nil else { return }
                self.pitch = motion.attitude.pitch
                self.roll = motion.attitude.roll
                self.lastMotionUpdateTime = Date()
            }
        }
    }
    
    //그냥 각도 측정(디버깅용)
    func check(){
        print("Pitch: \(String(format: "%.2f", pitch))")
        print("yaw: \(String(format: "%.2f", roll))")
        print("referencePitch: \(String(format: "%.2f", referencePitch))")
        print("referenceRoll: \(String(format: "%.2f", referenceRoll))")
    }
    
    //원의 중심점으로 맞추는 코드
    func setReferenceAttitude() {
        print("재설정")
        referencePitch = pitch
        referenceRoll = roll
    }
    
    //타이머 정지
    func stopMonitoringPosture() {
        checkingTimer?.invalidate()
        checkingTimer = nil
    }
}

//각도 측정및 감지 함수들
extension DashBoardViewModel {
    func isAbnormalPosture() -> Bool {
        let pitchDiff = abs(pitch - referencePitch)
        let rollDiff = abs(roll - referenceRoll)
        
        return pitchDiff > 0.3 || rollDiff > 0.3
    }
    
    //0.5초마다 자세를 측정하여 만약 비정상 자세가 감지된다면 print("비정상 자세 감지됨!")을 보내주는 코드
    func startMonitoringPosture() {
        checkingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.totalTime += 0.5

            DispatchQueue.main.async {
                self.formattedTotalTime = TimeFormatter.formattedtime(from: self.totalTime)
            }
            
            let currentTime = Date()
            if currentTime.timeIntervalSince(self.lastMotionUpdateTime) >= self.pauseThreshold {
                self.isPaused = true
                print("Pause 상태 - 자세 변화 없음")
            } else {
                DispatchQueue.main.async {
                    self.connectTime += 0.5
                    self.isPaused = false
                    self.formattedConnectTime = TimeFormatter.formattedtime(from: self.connectTime)
                    if self.isAbnormalPosture() {
                        print("비정상 자세")
                        self.abnormalTime += 0.5
                        self.formattedAbnormalTime = TimeFormatter.formattedtime(from: self.abnormalTime)
                        self.posture = false
                    } else {
                        print("정상 자세")
                        self.normalTime += 0.5
                        self.formattedNormalTime = TimeFormatter.formattedtime(from: self.normalTime)
                        self.posture = true
                    }
                }
            }
        }
    }
}



//12시가되면 초기화해주는 부분
extension DashBoardViewModel {
    func scheduleMidnightReset() {
        let now = Date()
        let calendar = Calendar.current
        
        // 오늘 자정 계산
        var midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
        
        print(midnight)
        // 만약 현재 시간이 자정 이후라면 다음 날 자정으로 설정
        if now >= midnight {
            midnight = calendar.date(byAdding: .day, value: 1, to: midnight)!
        }
        
        // 자정까지 남은 시간 계산
        let timeInterval = midnight.timeIntervalSince(now)
        print(timeInterval)
        
        // 타이머 설정: 자정에 맞춰 한 번 실행된 후, 매일 24시간 후 다시 실행
        dailyResetTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            self?.resetTimes()
            self?.scheduleMidnightReset()
        }
    }
    
    // totalTime, normalTime, abnormalTime 변수를 0으로 초기화하는 함수
    func resetTimes() {
        print("자정이 되어 값들이 초기화됩니다.")
        totalTime = 0.0
        normalTime = 0.0
        abnormalTime = 0.0
    }
}
