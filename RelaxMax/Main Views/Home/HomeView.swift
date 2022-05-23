////
////  HomeView.swift
////  relaxMax
////
////  Created by Naji Achkar on 11/05/2022.
////
//

import SwiftUI

struct HomeView: View {
    
//    @State private var progress: CGFloat = 0
    ////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.gray, .white, .white]), center: .top, startRadius: 2, endRadius: 800)
                    .ignoresSafeArea()
                VStack(spacing: 40){
                    Text("RelaxMax")
                        .italic()
                        .font(.largeTitle).fontWeight(.heavy)
                        .foregroundColor(.purple)
                    Group {
                        NavigationLink(destination: SmartView()) {
                            HomeFrameView(frameHeight: 5,
                                          frameText: "Smart", colors1: [.white, .red], colors2: [.blue, .black])
                        }
                        NavigationLink(destination: FocusView()) {
                            HomeFrameView(frameHeight: 7.5,
                                          frameText: "Focus", colors1: [.green, .orange], colors2: [.blue, .black])
                            
                        }
                        NavigationLink(destination: RelaxView2()) {
                            HomeFrameView(frameHeight: 7.5,
                                          frameText: "Relax", colors1: [.white, .purple], colors2: [.pink, .blue])
                        }
                        NavigationLink(destination: BreathView2()) {
                            HomeFrameView(frameHeight: 7.5,
                                          frameText: "Breath", colors1: [.green, .white], colors2: [.gray, .white])
                        }
                        Spacer()
                    }
                }
            }
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
