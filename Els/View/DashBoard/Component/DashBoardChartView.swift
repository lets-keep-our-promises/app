//import SwiftUI
//import Combine
//import Charts
//
//class DataModel: ObservableObject {
//    @Published var dataPoints: [Double] = [1, 3, 2, 5, 4]
//    
//    func addDataPoint(_ newValue: Double) {
//        dataPoints.append(newValue)
//        if dataPoints.count > 5 {  // 최대 10개의 데이터 포인트만 유지
//            dataPoints.removeFirst()
//        }
//    }
//}
//
//struct DashboardChartView: View {
//    @StateObject private var dataModel = DataModel()
//    
//    var body: some View {
//        LineChartView(dataModel: dataModel)
//            .onAppear {
//                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//                    let newValue = Double.random(in: 1...10)
//                    withAnimation(.easeInOut(duration: 1.0)) {
//                        dataModel.addDataPoint(newValue)
//                    }
//                }
//            }
//    }
//}
//
//struct LineChartView: View {
//    @ObservedObject var dataModel: DataModel
//    
//    var body: some View {
//        Chart {
//            ForEach(Array(dataModel.dataPoints.enumerated()), id: \.offset) { index, value in
//                LineMark(
//                    x: .value("Index", index),
//                    y: .value("Value", value)
//                )
//                .foregroundStyle(Color(red: 142/255, green: 120/255, blue: 255/255))
//            }
//        }
//        .chartXAxis {
//            AxisMarks(values: .stride(by: 1)) { value in
//            }
//        }
//        .chartYAxis {
//            AxisMarks() { value in
//                AxisTick()
//                AxisValueLabel()
//            }
//        }
//        .frame(width: 180, height: 110)
//        .background(Color(red: 71/255, green: 71/255, blue: 79/255))
//        .cornerRadius(10)
//        .animation(.easeInOut(duration: 0.5), value: dataModel.dataPoints) // 애니메이션 추가
//    }
//}
//


import SwiftUI
import Combine
import Charts

class DataModel: ObservableObject {
    @Published var dataPoints: [Double] = []
    
    func addDataPoint(_ newValue: Double) {
        dataPoints.append(newValue)
        if dataPoints.count > 5 {
            dataPoints.removeFirst()
        }
    }
}

struct DashboardChartView: View {
    @StateObject private var dataModel = DataModel()
    @ObservedObject var viewModel: DashBoardViewModel
    
    var body: some View {
        LineChartView(dataModel: dataModel)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        dataModel.addDataPoint(viewModel.filteredForwardAcceleration)
                    }
                }
            }
    }
}

struct LineChartView: View {
    @ObservedObject var dataModel: DataModel
    
    var body: some View {
        Chart {
            ForEach(Array(dataModel.dataPoints.enumerated()), id: \.offset) { index, value in
                LineMark(
                    x: .value("Index", index),
                    y: .value("Value", value)
                )
                .foregroundStyle(Color(red: 142/255, green: 120/255, blue: 255/255))
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: 1)) { value in
                AxisGridLine()
            }
        }
        .chartYAxis {
            AxisMarks() { value in
                AxisTick()
//                AxisValueLabel()
            }
        }
        .frame(width: 180, height: 110)
        .background(Color(red: 71/255, green: 71/255, blue: 79/255))
        .cornerRadius(10)
        .animation(.easeInOut(duration: 0.5), value: dataModel.dataPoints)
    }
}
