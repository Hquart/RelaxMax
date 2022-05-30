//
//  BreathView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI
import CoreHaptics

struct BreathView: View {
    
    @ObservedObject var vm = BreathViewModel()
    @ObservedObject var quoteService = QuoteService()
    
    @State private var isBreathing: Bool = false
    @State private var breathingCompleted: Bool = false
    @State private var showInfo: Bool = false
    @State private var stopButtonWasPressed = false
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var inhalePlayer = AudioPlayer(name: "inhale", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: 0)
    @ObservedObject var exhalePlayer = AudioPlayer(name: "exhale", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: 0)
    @ObservedObject var completionPlayer = AudioPlayer(name: "breathReward", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: 0)
    
    let generator = UINotificationFeedbackGenerator()
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
        ZStack {
            Image("backSpace").resizable().ignoresSafeArea()
            GradientAnim(color1: .blue, color2: .purple, color3: .blue, color4: .white, animDuration: 5)
                .opacity(0.5)
                .ignoresSafeArea()
            ////////////////////////////////////////////////////////////////////////////////////////////////
            VStack {
                FlowerView(animFlower: $isBreathing)
                    .padding(.bottom, 100)
                if breathingCompleted == false {
                Menu {
                    ForEach(0..<4, id: \.self) { index in
                        Button(vm.breathDurationOptions[index], action: { vm.setBreathDuration(index: index)})
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.blue)
                            .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05, alignment: .top)
                            .shadow(color: .black, radius: 5)
                        Text(String(Int(vm.breathCount * 5/60)) + " mn")
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                }
                    .padding()
               
                    actionButton
                }
                             
                if breathingCompleted {
                    quote.padding(.top, 50)
                       
                }
            }
        }
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: infoButton)
        .sheet(isPresented: $showInfo) {
            BreathInfoView()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isBreathing = false
            inhalePlayer.stopAudio()
            exhalePlayer.stopAudio()
            completionPlayer.stopAudio()
        }
    }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreathing() {
       
        stopButtonWasPressed = false
        quoteService.getNewQuote()
        
        withAnimation(Animation.easeOut(duration: 1)) {
        breathingCompleted = false
        }
      
        var count: Int = 1
        
        withAnimation(.linear(duration: 2.0)) {
            isBreathing = true
            inhale()
        }
       
        print("breath Count: \(count) / \(vm.breathCount)")
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            if stopButtonWasPressed {
                timer.invalidate()
            }
            if stopButtonWasPressed == false {
            count += 1
//                if isBreathing {
                    
               
            if count % 2 == 0 {
                exhale()
            } else if count % 2 != 0 {
                inhale()
            }
//                }
                
            print("breath Count: \(count) / \(vm.breathCount)")
                
            if isBreathing == false || count == vm.breathCount || stopButtonWasPressed {
                inhalePlayer.stopAudio()
                exhalePlayer.stopAudio()
                isBreathing = false
                if stopButtonWasPressed == false {
                timer.invalidate()
                }
            }
            if count == vm.breathCount && stopButtonWasPressed == false {
                withAnimation(.linear(duration: 1)) {
                    exhale()
                    breathingCompleted = true
                    completionPlayer.fadeIn()
                isBreathing = false
                }
            }
        }
    }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopButtonPressed() {
        stopButtonWasPressed = true
        inhalePlayer.stopAudio()
        exhalePlayer.stopAudio()
        completionPlayer.stopAudio()
        isBreathing = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            stopButtonWasPressed = false
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
//    func soundAndVibrate(count: Int)  {
//
//        if count % 2 == 0 {
//        exhalePlayer.playAudio()
//        } else {
//            inhalePlayer.playAudio()
//        }
//        self.generator.notificationOccurred(.error)
//    }
    func exhale() {
        exhalePlayer.playAudio()
        self.generator.notificationOccurred(.error)
    }
    func inhale() {
        self.generator.notificationOccurred(.error)
        inhalePlayer.playAudio()
    }

////////////////////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------ VIEW EXTENSION ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
extension BreathView {
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
    private var quote: some View {
        Text(quoteService.current)
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.title).scaleEffect(1)
            .foregroundColor(Color.appDarkBlue)
            .padding()
            .opacity(breathingCompleted ? 1 : 0.0)
    }
////////////////////////////////////////////////////////////////////////////////////////////////
    private var actionButton: some View {
        Button(action: { isBreathing ? stopButtonPressed() : startBreathing() }) {
            Text(isBreathing ? "End Session" : "Start")
                    .font(.headline)
                    .foregroundColor(isBreathing ? .white : .appDarkBlue).scaleEffect(1.2)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 75)
                    .background(isBreathing ? .purple : Color.flowerColor)
                    .cornerRadius(30)
                    .opacity(isBreathing ? 0.6 : 1)
                    .shadow(color: .black, radius: 5)
            }
        .disabled(stopButtonWasPressed)
        }
////////////////////////////////////////////////////////////////////////////////////////////////
    private var backButton: some View {
        Button(action: {
            inhalePlayer.stopAudio()
            exhalePlayer.stopAudio()
            completionPlayer.stopAudio()
            isBreathing = false
         
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward.circle")
                .foregroundColor(Color.white).shadow(radius: 5)
                .opacity(isBreathing ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isBreathing)
                .foregroundColor(Color.white)
                .scaleEffect(1.2)
               
                .padding()
        }
    }
////////////////////////////////////////////////////////////////////////////////////////////////
private var infoButton: some View {
    Button(action: {
        showInfo.toggle()
    }) {
            Image(systemName: "info.circle")
            .foregroundColor(Color.white).shadow(radius: 5)
            .opacity(isBreathing ? 0.1 : 0.8)
            .animation(.linear(duration: 1.5), value: isBreathing)
                .foregroundColor(Color.white)
                .scaleEffect(1.2)
                .padding()
    }
}
}










////////////////////////////////////////////////////////////////////////////////////////////////
///------------ PREVIEW ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
            .previewDevice("iPhone 13")
    }
}
