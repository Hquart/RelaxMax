//
////  RelaxView.swift
////  StarGates
////
////  Created by Naji Achkar on 11/05/2022.
////
//
//import SwiftUI
//
//struct RelaxView: View {
//
//    @ObservedObject var player2 = AudioPlayer(name: "relax1", type: "mp3", volume: 0.5, fadeDuration: 5.0, loops: 0)
//
//    @State private var showBreathView: Bool = false
//
//    @State private var quote = """
//    Tension is who you think you should be.
//    Relaxation is who you are.
//    """
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                GradientAnim(color1: .blue, color2: .purple, color3: .pink, color4: .white, animDuration: 10)
//                    .opacity(0.9)
//                    .ignoresSafeArea()
//                SpringAnim()
//                CirclesAnimationView().opacity(0.2)
//                VStack {
//                    Spacer()
//                    Text(quote)
//                        .italic()
//                        .multilineTextAlignment(.center)
//                        .font(.title3).opacity(0.6)
//                        .foregroundColor(Color.white)
//                    Spacer()
//
//                }
//            }
//            .sheet(isPresented: $showBreathView) {
//                BreathView()
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showBreathView.toggle()
//                    }) {
//                        VStack {
//                            Image(systemName: "camera.macro.circle")
//                                .scaleEffect(1.4)
//                                .padding()
//
//                        }
//                    }
//                }
//            }
//
//        }
//    }
//}
//
//
//struct RelaxView_Previews: PreviewProvider {
//    static var previews: some View {
//        RelaxView()
//    }
//}

import SwiftUI

struct CarView: View {
    
    @State var dragAmount = CGSize.zero

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(1..<20) { num in
                        VStack {
                            GeometryReader { geo in
                                Text("Number \(num)")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(.red)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).minX) / 8), axis: (x: 0, y: 1, z: 0))
                                    .frame(width: 200, height: 200)
                            }
                            .frame(width: 200, height: 200)
                        }
                    }
                }
            }
//            Rectangle()
//                .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                .frame(width: 200, height: 150)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .rotation3DEffect(.degrees(-Double(dragAmount.width) / 20), axis: (x: 0, y: 1, z: 0))
//                .rotation3DEffect(.degrees(Double(dragAmount.height / 20)), axis: (x: 1, y: 0, z: 0))
//                .offset(dragAmount)
//                .gesture(
//                    DragGesture()
//                        .onChanged { dragAmount = $0.translation }
//                        .onEnded { _ in
//                            withAnimation(.spring()) {
//                                dragAmount = .zero
//                            }
//                        }
//                )
//        }
//        .frame(width: 400, height: 400)
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarView()
          
    }
}
