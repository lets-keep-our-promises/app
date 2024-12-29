////  DashBoardViewModel.swift
//import Foundation
//import CoreMotion
//import UserNotifications
//
//class DashBoardViewModel: ObservableObject {
//    private let motionManager = CMHeadphoneMotionManager()
//    
//    @Published var pitch: Double = 0
//    @Published var roll: Double = 0
//    
//    @Published var referencePitch: Double = 0
//    @Published var referenceRoll: Double = 0
//    
//    @Published var posture = true
//    @Published var isPaused = false
//    
//    @Published var formattedTotalTime = "00:00"
//    @Published var formattedNormalTime = "00:00"
//    @Published var formattedAbnormalTime = "00:00"
//    @Published var formattedConnectTime = "00:00"
//    
//    private var totalTime = 0.0
//    private var normalTime = 0.0
//    private var abnormalTime = 0.0
//    private var connectTime = 0.0
//    
//    private var checkingTimer: Timer?
//    private var dailyResetTimer: Timer?
//    
//    private var lastMotionUpdateTime: Date = Date()
//    private let pauseThreshold: TimeInterval = 3.0
//    
//    private var referenceAttitude: CMAttitude?
//    
//    // 저역 통과 필터를 위한 변수
//    private var filteredPitch: Double = 0
//    private var filteredRoll: Double = 0
//    private let alpha = 0.1 // 필터 계수
//    
//    // 거북목 감지를 위한 변수
//    private var forwardAccelerationThreshold: Double = 0.02 // 임계값 (필요에 따라 조정)
//    private var isTurtleNeck: Bool = false
//    
//    // 비정상 자세 지속 시간 추적 변수
//    private var abnormalPostureDuration: TimeInterval = 0.0
//    private let abnormalPostureThreshold: TimeInterval = 3.0 // 3초 이상 유지 시 알림
//    
//    init() {
//        setupMotionManager()
//        startMonitoringPosture()
//        scheduleMidnightReset()
//        requestNotificationAuthorization() // 알림 권한 요청
//        
//        setupMotionManager()
//        startMonitoringPosture()
//        scheduleMidnightReset()
//        requestNotificationAuthorization()
//        
//        // 10초 간격 타이머 시작
//        startChartUpdateTimer()
//    }
//    
//    func setupMotionManager() {
//        if motionManager.isDeviceMotionAvailable {
//            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
//                guard let self = self, let motion = motion, error == nil else { return }
//                
//                // 저역 통과 필터 적용
//                self.filteredPitch = self.alpha * motion.attitude.pitch + (1 - self.alpha) * self.filteredPitch
//                self.filteredRoll = self.alpha * motion.attitude.roll + (1 - self.alpha) * self.filteredRoll
//                
//                self.pitch = self.filteredPitch
//                self.roll = self.filteredRoll
//                
//                self.lastMotionUpdateTime = Date()
//            }
//        }
//    }
//    
//    // 디버깅용 각도 측정
//    func check() {
//        print("Pitch: \(String(format: "%.2f", pitch))")
//        print("Roll: \(String(format: "%.2f", roll))")
//        print("Reference Pitch: \(String(format: "%.2f", referencePitch))")
//        print("Reference Roll: \(String(format: "%.2f", referenceRoll))")
//    }
//    
//    // 기준 자세 설정
//    func setReferenceAttitude() {
//        print("재설정")
//        if let currentAttitude = motionManager.deviceMotion?.attitude {
//            referenceAttitude = currentAttitude.copy() as? CMAttitude
//            referencePitch = pitch
//            referenceRoll = roll
//        }
//    }
//    
//    // 타이머 정지
//    func stopMonitoringPosture() {
//        checkingTimer?.invalidate()
//        checkingTimer = nil
//    }
//    
//    // 알림 권한 요청 함수
//    func requestNotificationAuthorization() {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
//            if let error = error {
//                print("알림 권한 요청 오류: \(error.localizedDescription)")
//            } else if granted {
//                print("알림 권한이 승인되었습니다.")
//            } else {
//                print("알림 권한이 거부되었습니다.")
//            }
//        }
//    }
//    
//    // 알림 전송 함수
//    func sendPostureNotification(for type: String) {
//        let content = UNMutableNotificationContent()
//        content.title = "📣 자세 교정 알림"
//        if type == "turtleNeck" {
//            content.body = "거북목 자세가 감지되었습니다. 올바른 자세로 교정하세요!"
//        } else {
//            content.body = "비정상적인 자세가 3초 이상 유지되었습니다. 올바른 자세로 교정하세요!"
//        }
//        content.sound = UNNotificationSound.default // 소리 포함
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("알림 전송 오류: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    // 차트에 표시할 히스토리 배열
//    @Published var timeStamps: [Date] = []
//    @Published var normalTimeHistory: [Double] = []
//    @Published var abnormalTimeHistory: [Double] = []
//    
//    private var chartUpdateTimer: Timer? // 10초 주기 타이머
//    
//    // 10초 단위로 차트용 데이터 업데이트
//    func startChartUpdateTimer() {
//        chartUpdateTimer?.invalidate()
//        chartUpdateTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            let currentDate = Date()
//            
//            // 현재 누적된 normalTime, abnormalTime을 그래프 데이터에 추가
//            DispatchQueue.main.async {
//                self.timeStamps.append(currentDate)
//                self.normalTimeHistory.append(self.normalTime)
//                self.abnormalTimeHistory.append(self.abnormalTime)
//            }
//        }
//    }
//    
//    // 타이머 해제 (필요 시)
//    func stopChartUpdateTimer() {
//        chartUpdateTimer?.invalidate()
//        chartUpdateTimer = nil
//    }
//    
//    // resetTimes()에서 차트용 데이터도 초기화
//    func resetTimes2() {
//        print("자정이 되어 값들이 초기화됩니다.")
//        totalTime = 0.0
//        normalTime = 0.0
//        abnormalTime = 0.0
//        abnormalPostureDuration = 0.0
//        
//        // 차트 데이터도 리셋
//        DispatchQueue.main.async {
//            self.timeStamps.removeAll()
//            self.normalTimeHistory.removeAll()
//            self.abnormalTimeHistory.removeAll()
//        }
//    }
//}
//
//// 자세 감지 함수들
//extension DashBoardViewModel {
//    func isAbnormalPosture() -> Bool {
//        guard let referenceAttitude = referenceAttitude, let currentMotion = motionManager.deviceMotion else {
//            return false
//        }
//        
//        let currentAttitude = currentMotion.attitude
//        let relativeAttitude = currentAttitude.copy() as! CMAttitude
//        relativeAttitude.multiply(byInverseOf: referenceAttitude)
//        
//        // 상대적인 자세 변화
//        let pitchDiff = abs(relativeAttitude.pitch)
//        let rollDiff = abs(relativeAttitude.roll)
//        let yawDiff = abs(relativeAttitude.yaw)
//        
//        // 임계값 설정 (필요에 따라 조정)
//        let pitchThreshold = 0.2
//        let rollThreshold = 0.2
//        let yawThreshold = 0.2
//        
//        // 현재 자세 업데이트 (디스플레이 용도)
//        DispatchQueue.main.async {
//            self.pitch = relativeAttitude.pitch
//            self.roll = relativeAttitude.roll
//        }
//        
//        // 거북목 감지
//        detectTurtleNeck(using: currentMotion)
//        
//        // 비정상 자세 감지
//        return pitchDiff > pitchThreshold || rollDiff > rollThreshold || yawDiff > yawThreshold || isTurtleNeck
//    }
//    
//    // 거북목 감지 함수
//    func detectTurtleNeck(using motion: CMDeviceMotion) {
//        // 사용자 가속도에서 전방(X축) 성분 추출
//        let userAcceleration = motion.userAcceleration
//        let rotationMatrix = motion.attitude.rotationMatrix
//        
//        // 전방 방향 벡터 계산 (기기 좌표계 기준)
//        let forwardVectorX = rotationMatrix.m31
//        let forwardVectorY = rotationMatrix.m32
//        let forwardVectorZ = rotationMatrix.m33
//        
//        // 전방 가속도 계산
//        let forwardAcceleration = userAcceleration.x * forwardVectorX +
//        userAcceleration.y * forwardVectorY +
//        userAcceleration.z * forwardVectorZ
//        
//        // 저역 통과 필터 적용
//        let filteredForwardAcceleration = alpha * forwardAcceleration + (1 - alpha) * (isTurtleNeck ? forwardAcceleration : 0)
//        
//        // 임계값을 초과하면 거북목 상태로 간주
//        if filteredForwardAcceleration > forwardAccelerationThreshold {
//            if !isTurtleNeck {
//                isTurtleNeck = true
//                print("거북목 상태 감지됨!")
//                // 거북목 감지 시 즉시 알림 전송
//                sendPostureNotification(for: "turtleNeck")
//            }
//        } else {
//            isTurtleNeck = false
//        }
//    }
//    
//    // 0.5초마다 자세를 측정하여 비정상 자세를 감지
//    func startMonitoringPosture() {
//        checkingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            
//            self.totalTime += 0.5
//            
//            DispatchQueue.main.async {
//                self.formattedTotalTime = TimeFormatter.formattedtime(from: self.totalTime)
//            }
//            
//            let currentTime = Date()
//            if currentTime.timeIntervalSince(self.lastMotionUpdateTime) >= self.pauseThreshold {
//                self.isPaused = true
//                print("Pause 상태 - 자세 변화 없음")
//                self.abnormalPostureDuration = 0.0 // 비정상 자세 지속 시간 초기화
//            } else {
//                DispatchQueue.main.async {
//                    self.connectTime += 0.5
//                    self.isPaused = false
//                    self.formattedConnectTime = TimeFormatter.formattedtime(from: self.connectTime)
//                    if self.isAbnormalPosture() {
//                        print("비정상 자세")
//                        self.abnormalTime += 0.5
//                        self.formattedAbnormalTime = TimeFormatter.formattedtime(from: self.abnormalTime)
//                        self.posture = false
//                        
//                        if self.isTurtleNeck {
//                            // 거북목은 이미 알림을 보냈으므로 처리 필요 없음
//                            self.abnormalPostureDuration = 0.0 // 비정상 자세 지속 시간 초기화
//                        } else {
//                            // 비정상 자세 지속 시간 증가
//                            self.abnormalPostureDuration += 0.5
//                            
//                            // 비정상 자세가 3초 이상 유지되었는지 확인
//                            if self.abnormalPostureDuration >= self.abnormalPostureThreshold {
//                                // 알림 전송
//                                self.sendPostureNotification(for: "abnormalPosture")
//                                self.abnormalPostureDuration = 0.0 // 지속 시간 초기화하여 계속 알림 발송
//                            }
//                        }
//                    } else {
//                        print("정상 자세")
//                        self.normalTime += 0.5
//                        self.formattedNormalTime = TimeFormatter.formattedtime(from: self.normalTime)
//                        self.posture = true
//                        
//                        // 비정상 자세 지속 시간 초기화
//                        self.abnormalPostureDuration = 0.0
//                    }
//                }
//            }
//        }
//    }
//}
//
//// 자정에 값을 초기화하는 부분
//extension DashBoardViewModel {
//    func scheduleMidnightReset() {
//        let now = Date()
//        let calendar = Calendar.current
//        
//        var midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
//        
//        if now >= midnight {
//            midnight = calendar.date(byAdding: .day, value: 1, to: midnight)!
//        }
//        
//        let timeInterval = midnight.timeIntervalSince(now)
//        
//        dailyResetTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
//            self?.resetTimes()
//            self?.scheduleMidnightReset()
//        }
//    }
//    
//    // 시간 초기화 함수
//    func resetTimes() {
//        print("자정이 되어 값들이 초기화됩니다.")
//        totalTime = 0.0
//        normalTime = 0.0
//        abnormalTime = 0.0
//        abnormalPostureDuration = 0.0
//    }
//}
//





import Foundation
import CoreMotion
import UserNotifications
import Combine

class DashBoardViewModel: ObservableObject {
    private let motionManager = CMHeadphoneMotionManager()
    @Published var pitch: Double = 0
    @Published var roll: Double = 0
    @Published var referencePitch: Double = 0
    @Published var referenceRoll: Double = 0
    @Published var posture = true
    @Published var isPaused = false
    @Published var formattedTotalTime = "00:00"
    @Published var formattedNormalTime = "00:00"
    @Published var formattedAbnormalTime = "00:00"
    @Published var formattedConnectTime = "00:00"
    @Published var filteredForwardAcceleration: Double = 0
    
    private var totalTime = 0.0
    private var normalTime = 0.0
    private var abnormalTime = 0.0
    private var connectTime = 0.0
    private var checkingTimer: Timer?
    private var dailyResetTimer: Timer?
    private var lastMotionUpdateTime: Date = Date()
    private let pauseThreshold: TimeInterval = 3.0
    private var referenceAttitude: CMAttitude?
    
    private var filteredPitch: Double = 0
    private var filteredRoll: Double = 0
    private let alpha = 0.1
    
    private var forwardAccelerationThreshold: Double = 0.02
    private var isTurtleNeck: Bool = false
    
    private var abnormalPostureDuration: TimeInterval = 0.0
    private let abnormalPostureThreshold: TimeInterval = 3.0
    
    init() {
        setupMotionManager()
        startMonitoringPosture()
        scheduleMidnightReset()
        requestNotificationAuthorization()
    }
    
    func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
                guard let self = self, let motion = motion, error == nil else { return }
                
                self.filteredPitch = self.alpha * motion.attitude.pitch + (1 - self.alpha) * self.filteredPitch
                self.filteredRoll = self.alpha * motion.attitude.roll + (1 - self.alpha) * self.filteredRoll
                self.pitch = self.filteredPitch
                self.roll = self.filteredRoll
                self.lastMotionUpdateTime = Date()
                
                self.detectTurtleNeck(using: motion)
            }
        }
    }
    
    func check() {
        print("Pitch: \(String(format: "%.2f", pitch))")
        print("Roll: \(String(format: "%.2f", roll))")
        print("Reference Pitch: \(String(format: "%.2f", referencePitch))")
        print("Reference Roll: \(String(format: "%.2f", referenceRoll))")
    }
    
    func setReferenceAttitude() {
        print("재설정")
        if let currentAttitude = motionManager.deviceMotion?.attitude {
            referenceAttitude = currentAttitude.copy() as? CMAttitude
            referencePitch = pitch
            referenceRoll = roll
        }
    }
    
    func stopMonitoringPosture() {
        checkingTimer?.invalidate()
        checkingTimer = nil
    }
    
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("알림 권한 요청 오류: \(error.localizedDescription)")
            } else if granted {
                print("알림 권한이 승인되었습니다.")
            } else {
                print("알림 권한이 거부되었습니다.")
            }
        }
    }
    
    func sendPostureNotification(for type: String) {
        let content = UNMutableNotificationContent()
        content.title = "📣 자세 교정 알림"
        if type == "turtleNeck" {
            content.body = "거북목 자세가 감지되었습니다. 올바른 자세로 교정하세요!"
        } else {
            content.body = "비정상적인 자세가 3초 이상 유지되었습니다. 올바른 자세로 교정하세요!"
        }
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 전송 오류: \(error.localizedDescription)")
            }
        }
    }
    
    func detectTurtleNeck(using motion: CMDeviceMotion) {
        let userAcceleration = motion.userAcceleration
        let rotationMatrix = motion.attitude.rotationMatrix
        
        let forwardVectorX = rotationMatrix.m31
        let forwardVectorY = rotationMatrix.m32
        let forwardVectorZ = rotationMatrix.m33
        
        let forwardAcceleration = userAcceleration.x * forwardVectorX + userAcceleration.y * forwardVectorY + userAcceleration.z * forwardVectorZ
        
        filteredForwardAcceleration = alpha * forwardAcceleration + (1 - alpha) * (isTurtleNeck ? forwardAcceleration : 0)
        
        if filteredForwardAcceleration > forwardAccelerationThreshold {
            if !isTurtleNeck {
                isTurtleNeck = true
                print("거북목 상태 감지됨!")
                sendPostureNotification(for: "turtleNeck")
            }
        } else {
            isTurtleNeck = false
        }
    }
    
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
                self.abnormalPostureDuration = 0.0
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
                        
                        if self.isTurtleNeck {
                            self.abnormalPostureDuration = 0.0
                        } else {
                            self.abnormalPostureDuration += 0.5
                            if self.abnormalPostureDuration >= self.abnormalPostureThreshold {
                                self.sendPostureNotification(for: "abnormalPosture")
                                self.abnormalPostureDuration = 0.0
                            }
                        }
                    } else {
                        print("정상 자세")
                        self.normalTime += 0.5
                        self.formattedNormalTime = TimeFormatter.formattedtime(from: self.normalTime)
                        self.posture = true
                        self.abnormalPostureDuration = 0.0
                    }
                }
            }
        }
    }
    
    func isAbnormalPosture() -> Bool {
        guard let referenceAttitude = referenceAttitude, let currentMotion = motionManager.deviceMotion else {
            return false
        }
        
        let currentAttitude = currentMotion.attitude
        let relativeAttitude = currentAttitude.copy() as! CMAttitude
        relativeAttitude.multiply(byInverseOf: referenceAttitude)
        
        let pitchDiff = abs(relativeAttitude.pitch)
        let rollDiff = abs(relativeAttitude.roll)
        let yawDiff = abs(relativeAttitude.yaw)
        
        let pitchThreshold = 0.2
        let rollThreshold = 0.2
        let yawThreshold = 0.2
        
        DispatchQueue.main.async {
            self.pitch = relativeAttitude.pitch
            self.roll = relativeAttitude.roll
        }
        
        return pitchDiff > pitchThreshold || rollDiff > rollThreshold || yawDiff > yawThreshold || isTurtleNeck
    }
    
    func scheduleMidnightReset() {
        let now = Date()
        let calendar = Calendar.current
        var midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
        
        if now >= midnight {
            midnight = calendar.date(byAdding: .day, value: 1, to: midnight)!
        }
        
        let timeInterval = midnight.timeIntervalSince(now)
        
        dailyResetTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            self?.resetTimes()
            self?.scheduleMidnightReset()
        }
    }
    
    func resetTimes() {
        print("자정이 되어 값들이 초기화됩니다.")
        totalTime = 0.0
        normalTime = 0.0
        abnormalTime = 0.0
        abnormalPostureDuration = 0.0
    }
}
