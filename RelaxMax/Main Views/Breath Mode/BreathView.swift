//
//  BreathView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI
import CoreHaptics
import CollectionViewPagingLayout
import AVFoundation

struct BreathView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var quoteService = QuoteService()
    let generator = UINotificationFeedbackGenerator()
    
    @ObservedObject var breathPlayer = AudioPlayer(name: "Breath", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: -1)
    @ObservedObject var completionPlayer = AudioPlayer(name: "breathReward", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: -1)
    
    var breathDurationOptions = [OptionItem(minutes: 0),
                                 OptionItem(minutes: 1),
                                 OptionItem(minutes: 2),
                                 OptionItem(minutes: 3),
                                 OptionItem(minutes: 4),
                                 OptionItem(minutes: 5)]
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var welcomeText = """
Help your body and mind
with regular breathing sessions
"""
    

    
    @State private var progressValue: Double = 0.95
    @State private var gradientProgress: CGFloat = 0.0
    
    @State private var selection: UUID?
    @State private var breathDuration: Int = 20
    @State private var breathTime: Int = 20
    
    @State private var showInhale: Bool = false
    @State private var showExhale: Bool = false
    
    @State private var breathTimeFormated: String = ""
    @State private var breathDurationFormated: String = ""
    
    @State private var timeRemaining: String = ""
    @State private var isBreathing: Bool = false
    @State private var breathingCompleted: Bool = false
    @State private var showInfo: Bool = false
    @State private var stopButtonWasPressed = false
    @State private var showWelcome = false
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------ BODY ------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            ZStack {
                BreathGradientView(progress: $gradientProgress, animate: $isBreathing)
                    .opacity(0.5)
                    .ignoresSafeArea()
                ////////////////////////////////////////////////////////////////////////////////////////////////
                VStack {
                    Spacer(minLength: geo.size.height * 0.25)
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    FlowerView(animFlower: $isBreathing, openFlower: $breathingCompleted)
                        .padding(.bottom, 100)
                        .shadow(radius: 2)
                        .opacity(breathingCompleted ? 0.5 : 0.9)
                        .position(x: geo.size.width / 2, y: geo.size.height / 7)
                    ZStack {
                        if isBreathing == false && !showWelcome && !breathingCompleted {
                            TimeOptionsView(selectionText: "Select Breath Duration:", color: .white, items: breathDurationOptions, selection: self.$selection)
                                .shadow(color: .black, radius: 25)
                                .frame(width: geo.size.width , height: geo.size.height * 0.1, alignment: .center)
                        } else if showWelcome {  welcomeMessage .position(x: geo.size.width / 2, y: geo.size.height / 8)
                        } else if showInhale  {  inhaleMessage
                        } else if showExhale {  exhaleMessage
                        } else if breathingCompleted {  quote
                        } else {  Rectangle().opacity(0.0) }
                    }
                    .position(x: geo.size.width / 2, y: geo.size.height / 7.5)
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    if !showWelcome && !breathingCompleted {
                        ZStack {
                            CircularProgressView(value: $progressValue).scaleEffect(0.8).opacity(0.5)
                            playButton.padding(.top, 30)
                            if isBreathing {
                                HStack {
                                    Spacer()
                                    Text("\(breathDurationFormated)").foregroundColor(Color.black)
                                    Spacer()
                                    Text("\(breathTimeFormated)").foregroundColor(Color.black)
                                    Spacer()
                                }.padding(.top, 60)
                            }
                        }
                    }
                }
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////
            .onChange(of: self.selection) { newValue in
                if let index = breathDurationOptions.firstIndex(where: { $0.id == newValue  }) {
                    if index == 0 {
                        self.breathDuration = 20
                        self.breathTime = 20
                        
                    } else {
                        self.breathDuration = self.breathDurationOptions[index].minutes * 60
                        self.breathTime = self.breathDurationOptions[index].minutes * 60
                      
                    }
                    formatBreathDuration()
                }
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////
            .onReceive(timer, perform: { _ in
                if isBreathing {
                    if breathDuration == 1 {
                                    withAnimation(.linear(duration: 1)) {
                                        isBreathing = false
                                        gradientProgress = 0
                                        breathPlayer.stopAudio()
                                        breathingCompleted = true
                                        completionPlayer.playAudio(duration: 2.0)
                                    }
                        
                    if stopButtonWasPressed {
                        isBreathing = false
                        breathPlayer.stopAudio()
                    }
                }
                if breathDuration % 5 == 0 {
                    self.generator.notificationOccurred(.error)
                }
                if breathDuration % 10 == 0 && breathDuration > 1 {
                    breathPlayer.playAudio(duration: 1.0)
                }
                breathDuration -= 1
                    self.progressValue = ((Double(breathDuration) / Double(breathTime)) * 0.4) + 0.55
                    formatTimeRemaining()
                }
            })
            ///////////////////////////////////////////////////////////////////////////////////////////////
            .onAppear {
                self.selection = breathDurationOptions[1].id
                welcome()
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .navigationBarItems(trailing: infoButton)
            ///////////////////////////////////////////////////////////////////////////////////////////////
            .sheet(isPresented: $showInfo) { BreathInfoView() }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ///------------FUNCTIONS------------------
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func welcome() {
        completionPlayer.stopAudio()
        showWelcome = true
        isBreathing = false
        quoteService.getNewQuote(from: "breathQuotes.json")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.linear(duration: 1)) {
                showWelcome = false
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func startBreathing() {
        breathPlayer.playAudio(duration: 1.0)
        self.generator.notificationOccurred(.error)
            showInhale = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.linear(duration: 2)) {
                showInhale = false
                showExhale = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.linear(duration: 2)) {
                showExhale = false
                }
            }
        }
        withAnimation(.linear(duration: 2)) {
        gradientProgress = 1.0
        isBreathing = true
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func formatTimeRemaining() {
        
        let breathEndTime: Date = Calendar.current.date(byAdding: .second, value: breathDuration + 2, to: Date()) ?? Date()
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: breathEndTime)
        let minutesRemaining = remaining.minute ?? 0
        let secondsRemaining = remaining.second ?? 0

        self.breathDurationFormated = "\(minutesRemaining): \(secondsRemaining)"
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func formatBreathDuration() {
        self.breathTimeFormated = ("\((breathTime  % 3600) / 60): 00")
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func stopButtonPressed() {
        breathPlayer.stopAudio()
        stopButtonWasPressed = true
        self.breathDuration = breathTime
        self.progressValue = 0.95 // 0.95 = 100%
        withAnimation(.linear(duration: 1)) {
        gradientProgress = 0.0
        isBreathing = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            stopButtonWasPressed = false
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------ VIEW EXTENSION ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
extension BreathView {
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var welcomeMessage: some View {
        Text(welcomeText)
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.title).scaleEffect(0.8)
            .foregroundColor(Color.black)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var inhaleMessage: some View {
        Text("Inhale")
            .font(.title).foregroundColor(Color.black).bold()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var exhaleMessage: some View {
        Text("Exhale")
            .font(.title).foregroundColor(Color.black).bold()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var breathInfo: some View {
        Text("Test")
            .italic()
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.black)
            .padding()
            .opacity(0.8)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var quote: some View {
        VStack {
            Text(quoteService.currentQuote.quoteText)
            .italic().bold()
            .multilineTextAlignment(.center)
            .font(.title).scaleEffect(0.8)
            .foregroundColor(Color.black)
            .padding()
            Text(quoteService.currentQuote.quoteAuthor)
                .font(.headline)
                .italic().bold()
                .foregroundColor(Color.purple)
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var playButton: some View {
        Button(action: { isBreathing ? stopButtonPressed() : startBreathing() }) {
            ZStack {
                Circle().foregroundColor(.black)
                Image(systemName: isBreathing ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .foregroundColor(Color.white)
                    .aspectRatio(contentMode: .fit)
                
                    .shadow(radius: 3)
            }    .scaleEffect(0.4)
           
        }
        .opacity(breathingCompleted || stopButtonWasPressed  ? 0.2 : 1.0)
        .disabled(breathingCompleted || stopButtonWasPressed)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    private var backButton: some View {
        Button(action: {
            completionPlayer.stopAudio()
            isBreathing = false
            
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.black).shadow(radius: 5)
                .opacity(isBreathing ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isBreathing)
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
                .opacity(isBreathing ? 0.1 : 0.8)
                .animation(.linear(duration: 1.5), value: isBreathing)
                .foregroundColor(Color.black)
                .scaleEffect(1.2)
                .padding()
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////
///------------ PREVIEW ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
            .previewDevice("iPhone 13")
    }
}




