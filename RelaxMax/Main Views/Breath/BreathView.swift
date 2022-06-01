//
//  BreathView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI
import CoreHaptics
import CollectionViewPagingLayout

struct BreathView: View {
    
    @State private var selection: UUID?
    @State private var breathCount: Int = 10
    
   var breathDurationOptions = [OptionItem(minutes: 1),
                                OptionItem(minutes: 2),
                                OptionItem(minutes: 3),
                                OptionItem(minutes: 4),
                                OptionItem(minutes: 5),
                                OptionItem(minutes: 0)]
    
    @ObservedObject var quoteService = QuoteService()
    
    @State private var isBreathing: Bool = false
    @State private var breathingCompleted: Bool = false
    @State private var showInfo: Bool = false
    @State private var stopButtonWasPressed = false
    
    @State var scale: CGFloat = 1.0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var breathPlayer = AudioPlayer(name: "Breath", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: 0)
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
            GradientAnim(color1: .breathGreen1, color2: .breathGreen1, color3: .white, color4: .black, animDuration: 5)
                .opacity(0.5)
                .ignoresSafeArea()
            ////////////////////////////////////////////////////////////////////////////////////////////////
            VStack {
                Spacer(minLength: geo.size.height * 0.35)
                ////////////////////////////////////////////////////////////////////////////////////////////////
                if breathingCompleted {
                    quote
                } else {
                FlowerView(animFlower: $isBreathing)
                    .padding(.bottom, 100)
                    .shadow(radius: 2)
                }
                ////////////////////////////////////////////////////////////////////////////////////////////////
                Spacer()
                ////////////////////////////////////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////////////////////////////////////
                TimeOptionsView(items: breathDurationOptions, selection: self.$selection)
                Button("Test Selection") {
                    print("\(self.breathCount)")
                }
                ////////////////////////////////////////////////////////////////////////////////////////////////
                if breathingCompleted == false {
                    playButton
                        .disabled(breathingCompleted)
                        .opacity(breathingCompleted ? 0.0 : 1.0)
                }
                Spacer()
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
        .onChange(of: self.selection) { newValue in
            if let index = breathDurationOptions.firstIndex(where: { $0.id == newValue }) {
                self.breathCount = self.breathDurationOptions[index].minutes * 6
            }
        }
    }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreathing() {
       
        stopButtonWasPressed = false
        quoteService.getNewQuote()
        isBreathing = true
        inhale()
        var count: Int = 1
        print("breath Count: \(count) / \(breathCount)")
    
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            if stopButtonWasPressed {
                timer.invalidate()
            } else {
            count += 1
                
            if count % 2 == 0 {
                exhale()
            } else if count % 2 != 0 {
                inhale()
            }
                
            print("breath Count: \(count) / \(breathCount)")
                
            if isBreathing == false || count == breathCount || stopButtonWasPressed {
                inhalePlayer.stopAudio()
                exhalePlayer.stopAudio()
                isBreathing = false
                if stopButtonWasPressed == false {
                timer.invalidate()
                }
            }
            if count == breathCount && stopButtonWasPressed == false {
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
    func exhale() {
        exhalePlayer.playAudio()
        self.generator.notificationOccurred(.error)
    }
    func inhale() {
        self.generator.notificationOccurred(.error)
        inhalePlayer.playAudio()
    }
    
//    func breath() {
//        breathPlayer.playAudio()
//        self.generator.notificationOccurred(.error)
//    }
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
    private var playButton: some View {
        Button(action: { isBreathing ? stopButtonPressed() : startBreathing() }) {
            ZStack {
                Circle().foregroundColor(.black).frame(width: 50, height: 50)
            Image(systemName: isBreathing ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.white).opacity(1)
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 3)
                .padding()
            }
        }
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




