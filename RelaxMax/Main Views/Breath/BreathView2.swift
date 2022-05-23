//
//  BreathView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI
import CoreHaptics

struct BreathView2: View {
    
    @ObservedObject var vm = BreathViewModel()
    @State private var isBreathing: Bool = false
    @State private var showBreathingMessage: Bool = false
    
    @ObservedObject var chimeSound = AudioPlayer(name: "bell", type: "wav", volume: 0.5, fadeDuration: 5.0)
    
    let generator = UINotificationFeedbackGenerator()
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        ZStack {
            GradientAnim(color1: .blue, color2: .purple, color3: .blue, color4: .white)
                .opacity(0.8)
                .ignoresSafeArea()
            ////////////////////////////////////////////////////////////////////////////////////////////////
            VStack {
                FlowerView(animFlower: $isBreathing)
                    .padding(.bottom, 100)
                breathDurationMenuButton
                    .padding()
                    actionButton
                if showBreathingMessage {
                    
                }
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreathing() {
        isBreathing = true
        soundAndVibrate()
        var count: Int = 1
        print("breath Count: \(count) / \(vm.breathCount)")
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            count += 1
            print("breath Count: \(count) / \(vm.breathCount)")
            if isBreathing == false || count == vm.breathCount {
                stopBreathing()
                timer.invalidate()
            }
            soundAndVibrate()
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopBreathing() {
        withAnimation(Animation.easeOut(duration: 1)) {
            chimeSound.stopAudio()
            isBreathing = false
            print("stop")
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func soundAndVibrate()  {
        chimeSound.playAudio()
        self.generator.notificationOccurred(.error)
    }
////////////////////////////////////////////////////////////////////////////////////////////////
}

////////////////////////////////////////////////////////////////////////////////////////////////
///------------ VIEW EXTENSION ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
extension BreathView2 {
////////////////////////////////////////////////////////////////////////////////////////////////
    private var breathInfo: some View {
        Text("Test")
            .italic()
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.white)
            .padding()
            .opacity(0.8)
    }
////////////////////////////////////////////////////////////////////////////////////////////////
    private var breathDurationMenuButton: some View {
        Menu {
            ForEach(0..<4, id: \.self) { index in
                Button(vm.breathDurationOptions[index], action: { vm.setBreathDuration(index: index)})
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(.white)
                    .frame(width: 70, height: 30, alignment: .top)
                Text(String(Int(vm.breathCount * 5/60)) + " mn")
                    .font(.headline)
                    .foregroundColor(Color.white)
            }
        }
    }
////////////////////////////////////////////////////////////////////////////////////////////////
    private var actionButton: some View {
        Button(action: { isBreathing ? stopBreathing() : startBreathing() }) {
            Text(isBreathing ? "End Session" : "Start")
                    .font(.headline)
                    .foregroundColor(.white).scaleEffect(1.2)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 75)
                    .background(isBreathing ? .purple : .blue)
                    .cornerRadius(30)
                    .opacity(isBreathing ? 0.5 : 0.8)
            }
        }
////////////////////////////////////////////////////////////////////////////////////////////////
}










////////////////////////////////////////////////////////////////////////////////////////////////
///------------ PREVIEW ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct BreathView2_Previews: PreviewProvider {
    static var previews: some View {
        BreathView2()
            .previewDevice("iPhone 13")
    }
}
