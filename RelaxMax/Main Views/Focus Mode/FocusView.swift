//
//  FocusView.swift
//  StarGates
//
//  Created by Naji Achkar on 11/05/2022.
//

import SwiftUI
import AVFAudio

struct FocusView: View {
    
    @ObservedObject var quoteService = QuoteService()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var welcomeMessage: String = """
Focus mode helps you concentrate on your work
for better productivity
"""
    var breakMessageText: String = """
                        Time to take a break
                        Walk a little,
                        Get some fresh air,
                        Drink water
                        """
    
    var focusDurationOptions = [OptionItem(minutes: 0),
                                 OptionItem(minutes: 30),
                                 OptionItem(minutes: 45),
                                 OptionItem(minutes: 60),
                                 OptionItem(minutes: 90),
                                 OptionItem(minutes: 120)]
    
    @ObservedObject var whiteNoisePlayer = AudioPlayer(name: "sound2", type: "mp3", volume: 0, fadeDuration: 10.0, loops: -1)
    @ObservedObject var breakMusicPlayer = AudioPlayer(name: "marconi", type: "mp3", volume: 1, fadeDuration: 5.0, loops: -1)
    
    @State private var showHello: Bool = false
    @State private var showQuote: Bool = false
    
    @State var breakLenght: Double = 30 // in seconds
    @State var breakGap: Double = 20
    
    @State private var isWorking: Bool = false
    @State private var isInBreak: Bool = false
    @State private var showInfo: Bool = false
    @State private var userHasQuit: Bool = false
    
    @State private var isPlaying: Bool = false
    
    @State private var selection: UUID?
    
    @State private var showStartMode: Bool = false
    @State private var progress: CGFloat = 0
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            ZStack {
                FocusGradientView(progress: $progress, animate: $isWorking)
                    .ignoresSafeArea()
                ////////////////////////////////////////////////////////////////////////////////////////////////
                VStack {
                    Spacer(minLength: geo.size.height * 0.25)
                    ClockView()
                        .opacity(isWorking ? 0.3 : 0.8)
                        .scaleEffect(0.8)
                        .padding(.bottom, 50)
                        .position(x: geo.size.width / 2, y: geo.size.height / 7)
                       
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    ZStack {
                        helloMessage
                        quote
                        breakMessage.opacity(isInBreak ? 0.8 : 0.0)
                    }
                    .frame(width: geo.size.width * 0.8 , height: geo.size.height * 0.2, alignment: .center)
                    .padding(.bottom, 30)
                 
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                        if showStartMode {
                                //////////////////////////////////////////  BREAK PICKERS   ///////////////////////////////////////
                                TimeOptionsView(selectionText: "Break After:", color: .appDarkBlue, items: focusDurationOptions, selection: $selection)
                                    .frame(width: geo.size.width , height: geo.size.height * 0.1, alignment: .center)
                        } else {
                            Rectangle().opacity(0)
                        }
                                //////////////////////////////////////////  START BUTTON   ///////////////////////////////////////
                    if !showHello {
                                Button(action: { startFocusMode(breakGap: breakGap, breakDuration: breakLenght) }) {
                                    playButton
                                }
                    }
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton)
                .navigationBarItems(trailing: infoButton)
                .sheet(isPresented: $showInfo) {
                    FocusInfoView()
                }
                .onAppear {
                    quoteService.getNewQuote(from: "quotes.json")
                    showHello = true
                    resetView()
                    userHasQuit = false
                    welcome()
                }
                .onChange(of: self.selection) { newValue in
                    if let index = focusDurationOptions.firstIndex(where: { $0.id == newValue  }) {
                        if index == 0 {
                            self.breakGap = 0.2
                            self.breakLenght = 0.1
                            
                        } else {
                            self.breakGap = Double(self.focusDurationOptions[index].minutes)
                            self.breakLenght = 15
                          
                        }
                    }
                }
            }
        }
    }
    func resetView() {
        userHasQuit = true
        isWorking = false
        whiteNoisePlayer.stopAudio()
        breakMusicPlayer.stopAudio()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func welcome() {
       
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
        print(self.breakGap)
        let focusStartTime: DispatchTime = .now()
        isWorking = true
        if isWorking {
            DispatchQueue.main.asyncAfter(deadline: focusStartTime + 0.5) {
                withAnimation(Animation.easeOut(duration: 3)) {
                    isInBreak = false
                    breakMusicPlayer.fadeOut()
                    whiteNoisePlayer.fadeIn()
                    isPlaying = true
                    showStartMode = false
                    showQuote = false
                }
            }
            DispatchQueue.main.asyncAfter(deadline: focusStartTime + breakGap) {
                withAnimation(Animation.easeOut(duration: 3)) {
                    startBreakTime()
                }
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreakTime() {
        isWorking = false
        isInBreak = true
        whiteNoisePlayer.fadeOut()
        breakMusicPlayer.fadeIn()
        
        if isInBreak && userHasQuit == false {
        DispatchQueue.main.asyncAfter(deadline: .now() + breakLenght) {
            withAnimation(Animation.easeOut(duration: 3)) {
                startFocusMode(breakGap: breakGap, breakDuration: breakLenght)
            }
        }
    }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------VIEW  EXTENSION --------
////////////////////////////////////////////////////////////////////////////////////////////////
extension FocusView {
    private var helloMessage: some View {
        Text(welcomeMessage)
            .font(.headline).scaleEffect(1.1)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.appDarkBlue)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
            .opacity(showHello ? 0.8 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var quote: some View {
        Text(quoteService.current)
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
            resetView()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.white).shadow(radius: 5)
                .opacity(isWorking ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isWorking)
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
                .opacity(isWorking ? 0.2 : 0.8)
                .foregroundColor(Color.white)
                .scaleEffect(1.4)
                .padding()
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var playButton: some View {
        Button(action: { whiteNoisePlayer.isPlayingAudio() ? whiteNoisePlayer.muteAudio() : startFocusMode(breakGap: breakGap, breakDuration: 15) }) {
            ZStack {
                Circle().foregroundColor(.black)
                Image(systemName: isWorking ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .foregroundColor(Color.white)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 3)
            }   .scaleEffect(0.4)
           
        }
    }
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
        Text(breakMessageText)
            .font(.headline).scaleEffect(1.1)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.appDarkBlue)
            .padding()
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








