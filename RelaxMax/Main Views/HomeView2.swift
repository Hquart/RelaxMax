//  HomeView.swift
//  theXteam
//
//  Created by Tery Vezzuto on 16/05/22.
//

import SwiftUI

struct HomeView2: View {
    
    @State private var animate = false
    @State private var agreedToTerms = true
    
    @State private var isGlowing: Bool = false
    
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkblue
                    .ignoresSafeArea()
                VStack(spacing: 40) {
//                    ZStack {
//                        Text("Hily")
//                            .italic()
//                            .foregroundColor(.purple)
//                            .fontWeight(.bold)
//                            .font(.headline).scaleEffect(4)
//                            .blur(radius: isGlowing ? 2 : 0)
//                            .shadow(color: .blue, radius: 3)
//                            .animation(.linear(duration: 0.05).repeatForever(), value: isGlowing)
//                        Text("Hily")
//                            .italic()
//                            .foregroundColor(.purple)
//                            .fontWeight(.bold)
//                            .font(.headline).scaleEffect(4)
//                            .shadow(color: .green, radius: 3)
//                    }
//                    .padding()
                    Group {
                        NavigationLink(destination: SmartModeView()) {
                            ZStack {
                                Image("smartmode")
                                    .ButtonStyle(elementButton: animate, widhtSize: 1.2,  heightSize: 4, shadowRadius: 120)
                                Text("SmartMode").foregroundColor(Color.white)
                                    .TextStyle(textHeight: 8)
                                    .disabled(agreedToTerms == true)
                            }
                        }
                        NavigationLink(destination: FocusView()) {
                            ZStack{
                                Image("focusmode")
                                    .ButtonStyle(elementButton: animate, widhtSize: 1.2, heightSize: 6, shadowRadius: 100)
                                
                                Text("Focus Mode").foregroundColor(Color.white)
                                    .TextStyle(textHeight: 14)
                            }
                        }
                        NavigationLink(destination: BreathView()) {
                            ZStack{
                                Image("breathmode")
                                    .ButtonStyle(elementButton: animate, widhtSize: 1.2, heightSize: 6, shadowRadius: 60)
                                
                                Text("Breath Mode").foregroundColor(Color.white)
                                    .TextStyle(textHeight: 14)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                isGlowing = true
                animate.toggle()
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
            .previewInterfaceOrientation(.portrait)
    }
}



extension View {
    func ButtonStyle(elementButton: Bool, widhtSize : CGFloat,  heightSize: CGFloat, shadowRadius: Int) -> some View {

        self
            .scaleEffect(elementButton ? 1.2 : 0.9)
            .offset(x: elementButton ? UIScreen.main.bounds.width/40 : UIScreen.main.bounds.width/40)
            .animation(.easeOut(duration: 360).repeatForever(autoreverses:true).speed(15), value: elementButton)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .frame(width: UIScreen.main.bounds.width/widhtSize, height: UIScreen.main.bounds.height/heightSize)
            .cornerRadius(40)
            .shadow(color:.cyan, radius: CGFloat(shadowRadius), x: UIScreen.main.bounds.width/6, y: UIScreen.main.bounds.width/40)

    }
}

extension Text {
    func TextStyle(textHeight: CGFloat) -> some View {
        self
                .bold()
                .font(.title)
                .shadow(radius: 10)
                .foregroundColor(.white)
                .padding(.bottom, UIScreen.main.bounds.height/textHeight)
    }
}
