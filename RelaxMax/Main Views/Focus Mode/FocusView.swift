//
//  FocusView.swift
//  StarGates
//
//  Created by Naji Achkar on 11/05/2022.
//

import SwiftUI

struct FocusView: View {
    
    @ObservedObject var vm = FocusViewViewModel()

    @ObservedObject var whiteNoisePlayer = AudioPlayer(name: "sound2", type: "mp3", volume: 0.5, fadeDuration: 5.0)
    @ObservedObject var breakMusicPlayer = AudioPlayer(name: "sound1", type: "mp3", volume: 0.5, fadeDuration: 5.0)
    
    @State private var showGoodMorning: Bool = false
    @State private var showQuote: Bool = false
    
    @State private var showBreakMessage: Bool = false
    
    @State private var isPlaying: Bool = false
    @State private var showNoisePlayer: Bool = false
    @State private var showBreakMusicPlayer: Bool = false
    
    @State private var showStartMode: Bool = false
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GradientAnim(color1: .green, color2: .blue, color3: .orange, color4: .blue)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    ClockView().padding()
                    ZStack {
                        goodMorning
                        quote
                            .padding(.bottom, 30)
                    }
                    ZStack {
                        if showStartMode {
                            VStack {
                                breakPickers
                                Button(action: { startFocusMode(breakGap: vm.breakGap, breakDuration: vm.breakDuration) }) {
                                    startButton
                                        .padding(.top)
                                }
                            }
                        }
                        if showNoisePlayer {
                            PlayerAudioView(isPlaying: $isPlaying, showNextButton: false, player: whiteNoisePlayer)
                        } else if showBreakMusicPlayer {
                            PlayerAudioView(isPlaying: $isPlaying, showNextButton: false, player: breakMusicPlayer)
                        }
                    }
                    if showBreakMessage {
                        breakMessage
                    }
                    Spacer()
                }
            }
            .onAppear {
                showStartMode = false
                welcome()
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func welcome() {
        withAnimation(Animation.easeIn(duration: 2)) {
            showGoodMorning = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.easeOut(duration: 2)) {
                showGoodMorning = false
                showQuote = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(Animation.easeOut(duration: 2)) {
                showStartMode = true
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startFocusMode(breakGap: Double, breakDuration: Double) {
        showBreakMusicPlayer = false
        let focusStartTime: DispatchTime = .now()
        showBreakMessage = false
        DispatchQueue.main.asyncAfter(deadline: focusStartTime + 0.5) {
            withAnimation(Animation.easeOut(duration: 1)) {
                breakMusicPlayer.pauseAudio()
                whiteNoisePlayer.playAudio()
                isPlaying = true
                showNoisePlayer = true
                showStartMode = false
                showQuote = false
            }
        }
            DispatchQueue.main.asyncAfter(deadline: .now() + breakGap) {
                withAnimation(Animation.easeOut(duration: 3)) {
                   startBreakTime()
                }
            }
        }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreakTime() {
        whiteNoisePlayer.pauseAudio()
        showNoisePlayer = false
        breakMusicPlayer.playAudio()
        showBreakMusicPlayer = true
        showBreakMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + vm.breakDuration) {
            withAnimation(Animation.easeOut(duration: 3)) {
                startFocusMode(breakGap: vm.breakGap, breakDuration: vm.breakDuration)
            }
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------FOCUS VIEW -------- EXTENSION
////////////////////////////////////////////////////////////////////////////////////////////////
extension FocusView {
    
    private var goodMorning: some View {
        Text("Good morning")
            .font(.title)
            .foregroundColor(Color.white)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .opacity(showGoodMorning ? 0.8 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var quote: some View {
        Text(vm.quoteText)
            .italic()
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.white)
            .opacity(0.5)
            .padding()
            .opacity(showQuote ? 0.8 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
//    private var timer: some View {
//        Text(String(format: "%.1f", focusTimer.secondsElapsed))
//            .font(.custom("Avenir", size: 40))
//            .padding(.top, 200)
//            .padding(.bottom, 100)
//    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var startButton: some View {
        Text("Start")
            .font(.headline)
            .foregroundColor(.white).scaleEffect(1.2)
            .padding(.vertical, 15)
            .padding(.horizontal, 75)
            .background(.green)
            .cornerRadius(30)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breakMessage: some View {
        Text(vm.breakMessageText)
            .italic()
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.white)
            .opacity(0.5)
            .padding()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breakPickers: some View {
        HStack {
            Menu {
                Button(vm.breakDurationOptions[0], action: { vm.setBreakDuration(index: 0)})
                Button(vm.breakDurationOptions[1], action: { vm.setBreakDuration(index: 1)})
                Button(vm.breakDurationOptions[2], action: { vm.setBreakDuration(index: 2)})
                Button(vm.breakDurationOptions[3], action: { vm.setBreakDuration(index: 3)})
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.white)
                        .frame(width: 70, height: 30, alignment: .top)
                    Text(String(Int(vm.breakDuration / 60)) + " mn")
                        .font(.headline)
                        .foregroundColor(Color.green)
                }
            } ////////////////////////////////////////////////////////////////////////////////////////////////
            Text(" break every ").foregroundColor(Color.white).opacity(0.5)
            ////////////////////////////////////////////////////////////////////////////////////////////////
            Menu {
                Button(vm.breakGapOptions[0], action: { vm.setBreakGap(index: 0)})
                Button(vm.breakGapOptions[1], action: { vm.setBreakGap(index: 1)})
                Button(vm.breakGapOptions[2], action: { vm.setBreakGap(index: 2)})
                Button(vm.breakGapOptions[3], action: { vm.setBreakGap(index: 3)})
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.white)
                        .frame(width: 70, height: 30, alignment: .top)
                    Text(String(Int(vm.breakGap / 60)) + "  mn")
                        .font(.headline)
                        .foregroundColor(Color.green)
                }
            }
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////// ////////////////////////////////////////////////////////////////////////////////////////////////
// ---------- PREVIEW ----------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
            .previewDevice("iPhone 13")
    }
}








