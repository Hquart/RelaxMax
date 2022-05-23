//
//  TestView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 22/05/2022.
//

import SwiftUI
import CoreHaptics
//
//struct TestView: View {
//
//    let generator = UINotificationFeedbackGenerator()
//
//
//    var body: some View {
//
//        VStack(alignment: .center, spacing: 30.0) {
//            Button(action: {
////                custom()
//            }) {
//                Text("Custom")
//            }
//            Button(action: {
//                self.generator.notificationOccurred(.success)
//            }) {
//                Text("Success")
//            }
//
//            Button(action: {
//                self.generator.notificationOccurred(.error)
//            }) {
//                Text("Error")
//            }
//
//            Button(action: {
//                self.generator.notificationOccurred(.warning)
//            }) {
//                Text("Warning")
//            }
//
//            Button(action: {
//                let impactLight = UIImpactFeedbackGenerator(style: .light)
//                impactLight.impactOccurred()
//            }) {
//                Text("Light")
//            }
//
//            Button(action: {
//                let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                impactMed.impactOccurred()
//            }) {
//                Text("Medium")
//            }
//
//            Button(action: {
//                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
//                impactHeavy.impactOccurred()
//            }) {
//                Text("Heavy")
//            }
//
//            Button(action: {
//                let selectionFeedback = UISelectionFeedbackGenerator()
//                selectionFeedback.selectionChanged()
//            }) {
//                Text("Selection Feedback Changed")
//            }
//        }
//        .padding(.all, 30.0)
//
//    .onAppear {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        do {
//            self.engine = try CHHapticEngine()
//            try engine.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//
//    }
    
//    
//    func custom() {
//       
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//            let engine: CHHapticEngine?
//        
//        do {
//            let engine = try CHHapticEngine()
//            try engine.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//        
//           let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//           let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//           let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//
//           do {
//               let pattern = try CHHapticPattern(events: [event], parameters: [])
//               let player = try engine?.makePlayer(with: pattern)
//               try player?.start(atTime: 0)
//           } catch {
//               print("Failed to play pattern: \(error.localizedDescription).")
//           }
//       }
//    }
    





//
//struct TestView: View {
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
//
//    var body: some View {
//        Text("Hello, World!")
//            .onReceive(timer) { time in
//                if counter == 5 {
//                    timer.upstream.connect().cancel()
//                } else {
//                    print("The time is now \(time)")
//                }
//
//                counter += 1
//            }
//    }
//}
//
//
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
