////
////  HomeView.swift
////  relaxMax
////
////  Created by Naji Achkar on 11/05/2022.
////
//

import SwiftUI

struct HomeView: View {
    
    @State private var progress = 0.0
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .ignoresSafeArea()

                VStack(spacing: 20){
                    Spacer()
                    Text("SoundStates")
                       
                        .italic()
                        .font(.largeTitle).fontWeight(.heavy).scaleEffect(1.4)
                        .foregroundColor(.black)
                        .shadow(color: .orange, radius: 15)
                        .padding()
                    Group {
                        NavigationLink(destination: SmartView()) {
                            SmartFrameView(frameHeight: 4)
                          
                        }
                        NavigationLink(destination: FocusView()) {
                            FocusFrameView(frameHeight: 6)
                               
                            
                        }
                        NavigationLink(destination: BreathView2()) {
                            BreathFrameView(frameHeight: 6)
                              
                        }
                        Spacer()
                    }
                    
                    
                }
            }.onAppear {
                withAnimation(.easeInOut(duration: 10.0).repeatForever()) {
                    self.progress = 0.2
                }
            }
            .navigationBarHidden(true)
            .navigationBarItems(trailing: settingsButton)
        }
    }
}

extension HomeView {
    private var settingsButton: some View {
        Button(action: {
           
        }) {
                Image(systemName: "gear")
                .opacity(0.8)
                    .foregroundColor(Color.black)
                    .scaleEffect(1.4)
                    .padding()
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 13")
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
