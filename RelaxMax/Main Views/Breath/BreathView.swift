//
//  BreathView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI
import CoreHaptics
import CollectionViewPagingLayout

struct BreathView2: View {

    @State private var selection: UUID?
    @State private var breathTime: Int = 10
    
    @State private var timeRemaining: String = ""
    
   var breathDurationOptions = [OptionItem(minutes: 0),
                                OptionItem(minutes: 1),
                                OptionItem(minutes: 2),
                                OptionItem(minutes: 3),
                                OptionItem(minutes: 4),
                                OptionItem(minutes: 5)]
    
    @ObservedObject var quoteService = QuoteService()

    @State private var isBreathing: Bool = false
    @State private var breathingCompleted: Bool = false
    @State private var showInfo: Bool = false
    @State private var stopButtonWasPressed = false

    @State private var index: Int = 2

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var breathPlayer = AudioPlayer(name: "Breath", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: -1)
    @ObservedObject var completionPlayer = AudioPlayer(name: "breathReward", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: -1)

    let generator = UINotificationFeedbackGenerator()
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
        ZStack {
            GradientAnim(color1: .breathGreen1, color2: .breathGreen1, color3: .breathGreen1, color4: .breathGreen1, animDuration: 5)
                .opacity(0.5)
                .ignoresSafeArea()
            ////////////////////////////////////////////////////////////////////////////////////////////////
            VStack {
                Spacer(minLength: geo.size.height * 0.35)
                ////////////////////////////////////////////////////////////////////////////////////////////////
                FlowerView(animFlower: $isBreathing)
                    .padding(.bottom, 100)
                    .shadow(radius: 2)
                    .opacity(breathingCompleted ? 0.5 : 0.9)
                       if breathingCompleted {
                           quote
                       }
                ////////////////////////////////////////////////////////////////////////////////////////////////
                Spacer()
                ////////////////////////////////////////////////////////////////////////////////////////////////

                ////////////////////////////////////////////////////////////////////////////////////////////////
                if !isBreathing  && !breathingCompleted  {
                TimeOptionsView(items: breathDurationOptions, selection: self.$selection)
                }
                ////////////////////////////////////////////////////////////////////////////////////////////////
                    playButton
                        .disabled(breathingCompleted)
                        .opacity(breathingCompleted ? 0.0 : 1.0)
                Spacer()
                
            }
        }
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: infoButton)
        .sheet(isPresented: $showInfo) {
            BreathInfoView()
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: self.selection) { newValue in
            if let index = breathDurationOptions.firstIndex(where: { $0.id == newValue  }) {
                if index == 0 {
                    self.breathTime = 10
                } else {
                self.breathTime = self.breathDurationOptions[index].minutes * 60
            }
            }
        }
        .onAppear {
            quoteService.getNewQuote()
            isBreathing = false
            completionPlayer.stopAudio()
        }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreathing() {
        stopButtonWasPressed = false
        breathingCompleted = false
        isBreathing = true
        breathPlayer.playAudio()
        var count: Int = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            count += 1
            print("\(count)")
            
            if count == breathTime || stopButtonWasPressed {
                timer.invalidate()
                isBreathing = false
            }
            if count % 10 == 0 {
                breathPlayer.playAudio()
                self.generator.notificationOccurred(.error)
            }
            if count % 5 == 0 {
                self.generator.notificationOccurred(.error)
            }
            if count == breathTime && stopButtonWasPressed == false {
                withAnimation(.linear(duration: 3)) {
                    breathPlayer.stopAudio()
                    breathingCompleted = true
                    completionPlayer.fadeIn()
                    isBreathing = false
                }
        }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopButtonPressed() {
        stopButtonWasPressed = true
        breathPlayer.fadeOut()
        completionPlayer.stopAudio()
        isBreathing = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            stopButtonWasPressed = false
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func breath() {
       
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
struct OptionItem: Identifiable {
                     var id: UUID = .init()
                     let minutes: Int
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




