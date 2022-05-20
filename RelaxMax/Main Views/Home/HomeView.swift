////
////  HomeView.swift
////  relaxMax
////
////  Created by Naji Achkar on 11/05/2022.
////
//

import SwiftUI

struct HomeView: View {
    
    @State private var oneMoves = false
    @State private var twoMoves = false
    @State private var threeMoves = false
    @State private var fourMoves = false
    @State private var hueRotate = false
    @State private var moveIn360 = false
    @State private var progress: CGFloat = 0
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
                            HomeFrameView(progress: $progress, frameHeight: 5,
                                          frameText: "Smart", colors: [.white, .red, .blue, .black])
                    
                        }
                        NavigationLink(destination: FocusView()) {
                            HomeFrameView(progress: $progress, frameHeight: 7.5,
                                          frameText: "Focus", colors: [.green, .orange, .blue, .black])
                            
                        }
                        NavigationLink(destination: RelaxView2()) {
                            HomeFrameView(progress: $progress, frameHeight: 7.5,
                                          frameText: "Relax", colors: [.white, .purple, .pink, .blue])
                            
                        }
                        NavigationLink(destination: BreathView()) {
                            HomeFrameView(progress: $progress, frameHeight: 7.5,
                                          frameText: "Breath", colors: [.green, .white, .gray, .white])
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








////
////  HomeView.swift
////  StarGates
////
////  Created by Naji Achkar on 11/05/2022.
////
//
//import SwiftUI
//
//struct HomeView: View {
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                GradientAnim(color1: .red, color2: .black, color3: .white, color4: .white)
//                    .ignoresSafeArea()
//                VStack(spacing: 60) {
//                    Text("RelaxMax")
//                        .italic()
//                        .font(.largeTitle).fontWeight(.heavy).shadow(radius: 4)
//                        .foregroundColor(.white)
//                    Spacer()
//                    NavigationLink(destination: SmartView()) {
//                        ButtonView(buttonText: "Smart Mode", icon: "bolt", color1: .blue, color2: .gray)
//                    }
//                    Spacer()
//                    NavigationLink(destination: FocusView()) {
//                        ButtonView(buttonText: "Focus", icon: "brain.head.profile", color1: .green, color2: .orange)
//                    }
//                    NavigationLink(destination: RelaxView()) {
//                        ButtonView(buttonText: "Relax", icon: "leaf", color1: .purple, color2: .white)
//                    }
//                    NavigationLink(destination: BreathView()) {
//                        ButtonView(buttonText: "Breathe", icon: "camera.macro", color1: .black,color2: .green)
//                    }
//                    Spacer()
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .previewDevice("iPhone 13")
//    }
//}
//
////  Created by Naji Achkar on 02/03/2022.
////
//
//import SwiftUI
//
//struct ButtonView: View {
//
//    var buttonText: String
//    var icon: String
//
//    let color1: Color
//    let color2: Color
//
////    init(color1: Color, color2: Color) {
////        self.color1 = color1
////        self.color2 = color2
////    }
//
//    var body: some View {
//        Label(buttonText, systemImage: icon)
//            .font(.title2)
//            .foregroundColor(Color.white)
//            .frame(width: 200, height: 20, alignment: .center)
//            .padding()
//            .cornerRadius(10)
//            .background(
//                Capsule()
//                .stroke(LinearGradient(colors: [color1, color2], startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 4))
//            .shadow(radius: 10)
//    }
//}
//
//
//


//  HomeView.swift
//  theXteam
//
//  Created by Tery Vezzuto on 16/05/22.
//
