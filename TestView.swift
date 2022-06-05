import SwiftUI
//
//let timer = Timer
//    .publish(every: 1, on: .main, in: .common)
//    .autoconnect()
//
struct Tester: View {
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .position(x: 100, y: 100)
                .background(.red)
        }
    }

   
}




struct TesterView: PreviewProvider {
    static var previews: some View {
        Tester()
        }
    }

//
//struct ProgressTrack: View {
//    var body: some View {
//        Circle()
//            .fill(Color.clear)
//            .frame(width: 250, height: 250)
//            .overlay(
//                Circle().stroke(Color.black, lineWidth: 15)
//        )
//    }
//}
//
//struct ProgressBar: View {
//    var counter: Int
//    var countTo: Int
//
//    var body: some View {
//        Circle()
//            .fill(Color.clear)
//            .frame(width: 250, height: 250)
//            .overlay(
//                Circle().trim(from:0, to: progress())
//                    .stroke(
//                        style: StrokeStyle(
//                            lineWidth: 15,
//                            lineCap: .round,
//                            lineJoin:.round
//                        )
//                )
//                    .foregroundColor(
//                        (completed() ? Color.green : Color.orange)
//                ).animation(.easeInOut(duration: 0.2), value: <#T##V#>
//
//                )
//        )
//    }
//
//    func completed() -> Bool {
//        return progress() == 1
//    }
//
//    func progress() -> CGFloat {
//        return (CGFloat(counter) / CGFloat(countTo))
//    }
//}
//
//struct CountdownView: View {
//    @State var counter: Int = 0
//    var countTo: Int = 120
//
//    var body: some View {
//        VStack{
//            ZStack{
//                ProgressTrack()
//                ProgressBar(counter: counter, countTo: countTo)
//                Clockx(counter: counter, countTo: countTo)
//            }
//        }.onReceive(timer) { time in
//            if (self.counter < self.countTo) {
//                self.counter += 1
//            }
//        }
//    }
//}
//
//
//
//
//
