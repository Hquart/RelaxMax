//
//  FocusView.swift
//  StarGates
//
//  Created by Naji Achkar on 11/05/2022.
//

import SwiftUI

struct FocusView: View {
    
    @ObservedObject var vm = FocusViewViewModel()
    @ObservedObject var quoteService = QuoteService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var whiteNoisePlayer = AudioPlayer(name: "sound2", type: "mp3", volume:1, fadeDuration: 0.0)
    @ObservedObject var breakMusicPlayer = AudioPlayer(name: "marconi", type: "mp3", volume: 1, fadeDuration: 5.0)
    
    @State private var showHello: Bool = false
    @State private var showQuote: Bool = false
    
    @State private var isWorking: Bool = false
    @State private var showBreakMessage: Bool = false
    @State private var showInfo: Bool = false
    
    @State private var isPlaying: Bool = false
    @State private var showNoisePlayer: Bool = false
    @State private var showBreakMusicPlayer: Bool = false
    
    @State private var showStartMode: Bool = false
    @State private var progress: Double = 0
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
//            ZStack {
                ZStack {
                    Image("forest4")
                     
                        .resizable()
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    GradientAnim(color1: .blue, color2: .orange, color3: .green, color4: .blue, animDuration: 20)
                        .opacity(0.5)
                        .ignoresSafeArea()

                ////////////////////////////////////////////////////////////////////////////////////////////////
                VStack {
                    Spacer()
                    ClockView()
                        .opacity(isWorking ? 0.3 : 0.8)
                        .padding()
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    ZStack {
                        helloMessage
                        quote
                            .padding(.bottom, 30)
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    ZStack {
                        if showStartMode {
                            VStack {
                                //////////////////////////////////////////  BREAK PICKERS   ///////////////////////////////////////
                                HStack {
                                    Menu {
                                        ForEach(0..<4, id: \.self) { index in
                                            Button(vm.breakDurationOptions[index], action: { vm.setBreakDuration(index: index)})
                                        }
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 40)
                                                .fill(.blue)
                                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05, alignment: .top)
                                                .shadow(color: .black, radius: 5)
                                            Text(String(Int(vm.breakDuration / 60)) + " mn")
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                        }
                                    } ////////////////////////////////////////////////////////////////////////////////////////////////
                                    Text(" break every ").foregroundColor(Color.appDarkBlue).font(.headline)
                                    ////////////////////////////////////////////////////////////////////////////////////////////////
                                    Menu {
                                        ForEach(0..<4, id: \.self) { index in
                                            Button(vm.breakGapOptions[index], action: { vm.setBreakGap(index: index)})
                                        }
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 40)
                                                .fill(.blue)
                                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05, alignment: .top)
                                                .shadow(color: .black, radius: 5)
                                            Text(String(Int(vm.breakGap / 60)) + "  mn")
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                }
                                //////////////////////////////////////////  START BUTTON   ///////////////////////////////////////
                                Button(action: { startFocusMode(breakGap: vm.breakGap, breakDuration: vm.breakDuration) }) {
                                    startButton
                                        .padding(.top)
                                }
                            }
                        }
                        if showNoisePlayer {
                            PlayerAudioView(isPlaying: $isPlaying, player: whiteNoisePlayer)
                        } else if showBreakMusicPlayer {
                            PlayerAudioView(isPlaying: $isPlaying, player: breakMusicPlayer)
                        }
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    if showBreakMessage {
                        breakMessage
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .navigationBarItems(trailing: infoButton)
                
            .sheet(isPresented: $showInfo) {
                FocusInfoView()
            }
            .onAppear {
                resetView()
                welcome()
            }
            .onChange(of: vm.breakGap) { newValue in
                withAnimation(.linear(duration: newValue)) {
                                            self.progress = 1.0
                                        }
                                                      }
        }
    }
    }
    func resetView() {
        isWorking = false
        whiteNoisePlayer.stopAudio()
        breakMusicPlayer.stopAudio()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func welcome() {
        quoteService.getNewQuote()
        withAnimation(Animation.easeIn(duration: 1.5)) {
            showHello = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(Animation.easeOut(duration: 2)) {
                showHello = false
                showQuote = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.easeOut(duration: 2)) {
                showStartMode = true
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startFocusMode(breakGap: Double, breakDuration: Double) {
        print(vm.breakGap)
        let focusStartTime: DispatchTime = .now()
        isWorking = true
        if isWorking {
        DispatchQueue.main.asyncAfter(deadline: focusStartTime + 0.5) {
            withAnimation(Animation.easeOut(duration: 1)) {
                showBreakMusicPlayer = false
                showBreakMessage = false
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
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreakTime() {
        breakMusicPlayer.playAudio()
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
///------------VIEW  EXTENSION --------
////////////////////////////////////////////////////////////////////////////////////////////////
extension FocusView {
    private var helloMessage: some View {
        Text("Hello")
            .font(.title)
            .foregroundColor(Color.appDarkBlue)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .opacity(showHello ? 0.8 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var quote: some View {
        Text(quoteService.current)
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.headline).scaleEffect(1.1)
            .foregroundColor(Color.appDarkBlue)
            .padding()
            .opacity(showQuote ? 1 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            isWorking = false
            whiteNoisePlayer.stopAudio()
            breakMusicPlayer.stopAudio()
        }) {
                Image(systemName: "chevron.backward.circle")
                .opacity(isWorking ? 0.2 : 0.8)
                    .foregroundColor(Color.white)
                    .scaleEffect(1.4)
                    .padding()
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var infoButton: some View {
        Button(action: {
            showInfo.toggle()
        }) {
                Image(systemName: "info.circle")
                .opacity(isWorking ? 0.2 : 0.8)
                    .foregroundColor(Color.white)
                    .scaleEffect(1.4)
                    .padding()
        }
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
            .shadow(color: .black, radius: 5)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breakMessage: some View {
        Text(vm.breakMessageText)
            .italic()
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.white)
            .padding()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breakPickers: some View {
        HStack {
            Menu {
                ForEach(0..<4, id: \.self) { index in
                    Button(vm.breakDurationOptions[index], action: { vm.setBreakDuration(index: index)})
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.blue)
                        .frame(width: 70, height: 30, alignment: .top)
                    Text(String(Int(vm.breakDuration / 60)) + " mn")
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            } ////////////////////////////////////////////////////////////////////////////////////////////////
            Text(" break every ").foregroundColor(Color.white)
            ////////////////////////////////////////////////////////////////////////////////////////////////
            Menu {
                ForEach(0..<4, id: \.self) { index in
                    Button(vm.breakGapOptions[index], action: { vm.setBreakGap(index: index)})
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.blue)
                        .frame(width: 70, height: 30, alignment: .top)
                    Text(String(Int(vm.breakGap / 60)) + "  mn")
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
// ---------- PREVIEW ----------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
            .previewDevice("iPhone 13")
    }
}








