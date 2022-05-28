//
//  SmartView.swift
//  StarGates
//
//  Created by Naji Achkar on 12/05/2022.
//

import SwiftUI

struct SmartView: View {
    
    @State private var infoText: String =    """
    Data below is analyzed to provide
    the best music possible for you
    """
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var hearRateIsOn: Bool = false
    @State private var localizationIsOn: Bool = false
    @State private var motionIsOn: Bool = false
    @State private var notifIsOn: Bool = false
    
    @State private var isPlaying: Bool = false
    @State private var showInfo: Bool = false
    
    @ObservedObject var musicPlayer = AudioPlayer(name: "sound1", type: "mp3", volume: 1, fadeDuration: 5.0)
    
    var body: some View {
        NavigationView {
        ZStack {
            LinearGradient(colors: [.gray, .blue], startPoint: .center, endPoint: .bottom)
                .opacity(0.5)
                .ignoresSafeArea()
            Group {
            VStack {
         
                Text(infoText)
                    .italic()
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 350)
                    .padding()
                Spacer()
                
                HStack {
                    VStack {
                    Image(systemName: "heart.circle")
                        .foregroundColor(Color.red)
                        .scaleEffect(3)
                        .padding()
                        Text("80 bpm")
                    }
                    Spacer()
                    VStack {
                    Image(systemName: "location.circle")
                        .foregroundColor(Color.blue)
                        .scaleEffect(3)
                        .padding()
                        Text("Naples")
                    }
                }
                Spacer()
                HStack {
                    VStack {
                    Image(systemName: "cloud.sun")
                        .foregroundColor(Color.gray)
                        .scaleEffect(3)
                        .padding()
                        Text("80 bpm")
                    }
                    Spacer()
                    VStack {
                    Image(systemName: "figure.walk")
                        .foregroundColor(Color.black)
                        .scaleEffect(3)
                        .padding()
                        Text("Walking")
                    }
                }
  Spacer()
                    PlayerAudioView(isPlaying: $isPlaying, player: musicPlayer)
                    .scaleEffect(1.5)
            }
            }
            .frame(width: 250)
            .padding()
                Spacer()
            }
 
        }
        .sheet(isPresented: $showInfo) {
            SmartInfoView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarItems(trailing: infoButton)
    }
}

extension SmartView {
    private var infoButton: some View {
        Button(action: {
            showInfo.toggle()
        }) {
                Image(systemName: "info.circle")
              
                    .foregroundColor(Color.black).opacity(0.6)
                    .scaleEffect(1.4)
                    .padding()
        }
    }
    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
                Image(systemName: "chevron.backward.circle")

                .foregroundColor(Color.black).opacity(0.6)
                    .scaleEffect(1.4)
                    .padding()
        }
    }
}


struct SmartView_Previews: PreviewProvider {
    static var previews: some View {
        SmartView()
            .previewDevice("iPhone 13")
    }
}
