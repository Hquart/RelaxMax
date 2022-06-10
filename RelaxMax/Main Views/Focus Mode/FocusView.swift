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
    Focus mode
    helps you concentrate on your work
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
    
    @ObservedObject var whiteNoisePlayer = AudioPlayer(name: "whiteNoise", type: "mp3", volume: 0, fadeDuration: 10.0, loops: -1)
    @ObservedObject var breakMusicPlayer = AudioPlayer(name: "marconi", type: "mp3", volume: 1, fadeDuration: 5.0, loops: -1)
    
    @State private var showHello: Bool = false
    @State private var showQuote: Bool = false
    
    @State var breakGap: Double = 0.2 // == 12 seconds for demo purpose
    
    @State private var isWorking: Bool = false
    @State private var isInBreak: Bool = false
    @State private var showInfo: Bool = false
    @State private var userHasQuit: Bool = false
    
    @State private var showBackToWorkButton: Bool = false
    @State private var showClock: Bool = false
    @State private var showBubbles: Bool = false
    
    @State private var playButtonDisabled = false
    @State private var isPlaying: Bool = false
    @State private var showPlayerButton: Bool = false
    
    @State private var selection: UUID?
    
    @State private var showStartMode: Bool = false
    @State private var gradientProgress: CGFloat = 0
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            ZStack {
                    FocusGradientView(progress: $gradientProgress, animate: $isWorking, duration: $breakGap)
                    .ignoresSafeArea()
                ////////////////////////////////////////////////////////////////////////////////////////////////
                VStack {
                    Spacer(minLength: geo.size.height * 0.25)
                    ZStack {
                    helloMessage
                    quoteMessage.opacity(showQuote ? 0.8 : 0.0)
                        ClockView(showTicks: true)
                            .scaleEffect(0.9)
                        .padding(.bottom, 50)
                        .position(x: geo.size.width / 2, y: geo.size.height / 7)
                        .opacity(showClock ? 1.0 : 0.0)
                   
                    }
                    ZStack {
                        BubblesView(animate: $showBubbles).opacity(showBubbles ? 0.2 : 0.0).zIndex(1)
                    
                     
                        breakMessage.opacity(isInBreak ? 0.8 : 0.0)
                    }
                    
                    Spacer()
                    ////////////////////////////////////////////////////////////////////////////////////////////////
//                        BubblesView(animate: $showStartMode).opacity(showBubbles ? 0.2 : 0.0).zIndex(1)
//                    .frame(width: geo.size.width * 0.9 , height: geo.size.height * 0.3, alignment: .center)
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    ZStack {
                        TimeOptionsView(selectionText: "Have a break After:", color: .darkblue, items: focusDurationOptions, selection: $selection)
                            .opacity(showStartMode ? 0.8 : 0.0)
                        Spacer()
                        backToWorkButton.opacity(showBackToWorkButton ? 0.8 : 0.0)
                    }
                    .frame(width: geo.size.width , height: geo.size.height * 0.1, alignment: .center)
                    //////////////////////////////////////////  START BUTTON   ///////////////////////////////////////
                    if showPlayerButton {
                        VStack {
                                Button(action: { startFocusMode(breakGap: breakGap) }) {
                                    playButton
                                        .disabled(showPlayerButton)
                                        .opacity(showPlayerButton ? 1.0 : 0.0)
                                }
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
                    quoteService.getNewQuote(from: "focusQuotes.json")
                    showHello = true
                    showClock = false
                    showBubbles = true
                    self.selection = focusDurationOptions[0].id
                    resetView()
                    userHasQuit = false
                    welcome()
                    gradientProgress = 0.0
                }
                .onChange(of: self.selection) { newValue in
                    if let index = focusDurationOptions.firstIndex(where: { $0.id == newValue  }) {
                        if index == 0 {
                            self.breakGap = 0.2
                        } else {
                            self.breakGap = Double(self.focusDurationOptions[index].minutes)
                        }
                    }
                }
            }
        }
    }
    func resetView() {
        showBubbles = true
        showClock = false
        gradientProgress = 0.0
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
                showClock = false
                showHello = false
                showQuote = true
                showBubbles = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(Animation.easeOut(duration: 2)) {
                showStartMode = true
                showPlayerButton = true
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startFocusMode(breakGap: Double) {
        withAnimation(.linear(duration: 3.0)) {
            isWorking = true
            showPlayerButton = false
            showClock = true
            showBubbles = false
        }
        whiteNoisePlayer.playAudio(duration: 5.0)
        withAnimation(.linear(duration: 3.0)) {
            showStartMode = false
            showQuote = false
        }
        withAnimation(.linear(duration: self.breakGap * 60)) {
            gradientProgress = 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + breakGap * 60) {
            startBreakTime()
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreakTime() {
        quoteService.getNewQuote(from: "focusQuotes.json")
        withAnimation(.linear(duration: 5.0)) {
            isInBreak = true
            isWorking = false
            showBubbles = true
            showClock = false
        }
      
        whiteNoisePlayer.player.setVolume(0.0, fadeDuration: 10.0)
        breakMusicPlayer.playAudio(duration: 10.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            withAnimation(Animation.easeOut(duration: 3)) {
                showBackToWorkButton = true
                gradientProgress = 0
                isInBreak = false
                showQuote = true
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
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.title).scaleEffect(0.8)
            .foregroundColor(Color.darkblue)
            .padding()
            .opacity(showHello ? 0.8 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var quoteMessage: some View {
        VStack {
            Text(quoteService.currentQuote.quoteText)
                .italic().bold()
                .multilineTextAlignment(.center)
                .font(.title).scaleEffect(0.7)
                .foregroundColor(Color.darkblue)
                
              
            Text(quoteService.currentQuote.quoteAuthor)
                .italic().bold()
                .font(.headline)
                .foregroundColor(Color.white)
        }  .opacity(showQuote ? 1 : 0.0)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            resetView()
            userHasQuit = true
        }) {
            Image(systemName: "chevron.backward")
                .opacity(isWorking ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isWorking)
                .foregroundColor(Color.darkblue)
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
                .opacity(isWorking ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isWorking)
                .foregroundColor(Color.darkblue)
                .scaleEffect(1.2)
                .padding()
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var playButton: some View {
        Button(action: {
            if isWorking == false {
                startFocusMode(breakGap: breakGap)
            } else if isPlaying && isWorking {
                whiteNoisePlayer.pauseAudio()
            } else {
                whiteNoisePlayer.playAudio(duration: 5.0)
            }
            }) {
                ZStack {
                Circle().foregroundColor(.black)
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 3)
                }
            }
            .scaleEffect(0.4)
        }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var backToWorkButton: some View {
        Button(action: {
            showStartMode = true
            withAnimation(.linear(duration: 3)) {
                showPlayerButton = true
                showBackToWorkButton = false
                showQuote = true
                isInBreak = false
                breakMusicPlayer.player.setVolume(0.0, fadeDuration: 10.0)
            }
        }) {
        Text("Back to work")
            .font(.headline)
            .foregroundColor(.white).scaleEffect(1.2)
            .padding(.vertical, 15)
            .padding(.horizontal, 75)
            .background(.blue)
            .cornerRadius(30)
            .shadow(color: .black, radius: 5)
    }
        .disabled(!showBackToWorkButton)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breakMessage: some View {
        Text(breakMessageText)
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.title).scaleEffect(0.8)
            .foregroundColor(Color.white)
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








