////
////  breatView.swift
////  theXteam
////
////  Created by Andrea Romagnuolo on 13/05/22.
////
//
//import SwiftUI
//
//struct BreathView: View {
//
//    @State private var rBreath = false
//    @State private var lBreath = false
//    @State private var mrBreath = false
//    @State private var mlBreath = false
//    @State private var showShadow = false
//    @State private var showRightStroke = false
//    @State private var showLeftStroke = false
//    @State private var showInhale = true
//    @State private var showExhale = false
//
//    var body: some View {
//        ZStack {
//            GradientAnim(color1: .blue, color2: .purple, color3: .pink, color4: .white)
//                .opacity(0.9)
//                .ignoresSafeArea()
//            VStack {
//                breathText
////                flower
//                Text("ddd")
//            }
//        }
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//extension BreathView {
//////////////////////////////////////////////////////////////////////////////////////////////////
//    private var breathText: some View {
//        ZStack {
//            Text("Breath In")
//                .font(.largeTitle)
//                .foregroundColor(Color.white)
//                .opacity(showInhale ? 0:1)
//                .scaleEffect(showInhale ? 0:1, anchor: .center)
//                .offset(y: -300)
//                .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
//                .onAppear {
//                    showInhale.toggle()
//                }
//            Text("Breath Out")
//                .foregroundColor(Color.green)
//                .font(.largeTitle)
//                .opacity(showExhale ? 0:1)
//                .offset(y: -300)
//                .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
//                .onAppear {
//                    showExhale.toggle()
//                }
//        }
//    }
//////////////////////////////////////////////////////////////////////////////////////////////////
//
//}
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//struct breatView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreathView()
//    }
//}




//
//  BreathHomeView.swift
//  theXteam
//
//  Created by Andrea Romagnuolo on 19/05/22.
//

import SwiftUI

struct BreathView: View {
    
    @State var isPressed : Int = 0
    
    @State var nowDate: Date = Date()
    @State var referenceDate: Date = Date.now.addingTimeInterval(60*1)
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    @State var moltiplytimer = 1
    var body: some View {
        
        VStack {
            ZStack {
                GradientAnim(color1: .blue, color2: .purple, color3: .blue, color4: .white)
                    .opacity(0.8)
                                .ignoresSafeArea()
            Text("Breathing")
                .font(.largeTitle).bold()
                .foregroundColor(Color.white)
                .offset(y: -300)
            
            Image("flower")
                .rotationEffect(.degrees(0), anchor: .bottom)
                .offset(y: -100)
                .opacity(30)
                .padding(.bottom,100)
                
                
                VStack{
//                    Text("Breath's Time")
//                        .font(.system(size: 18))
//                        .bold()
//                        .padding(.top)
//                        .foregroundColor(.white)
//                HStack{
//                    Button(action: {
//                            if isPressed != 1{
//                            isPressed = 1
//
//
//                            } else {
//                                isPressed = 0
//                            }
//
//                        })  {
                    
                        Text("Breath's Time") .foregroundColor(Color.white).opacity(1)
             Text(countDownString(from: referenceDate))
                 .font(.largeTitle)
                        .font(.title2)
                                    Menu {
                                        Button("5", action: {moltiplytimer = 5 })
                                        Button("4", action: { moltiplytimer = 4})
                                        Button("3", action: { moltiplytimer = 3 })
                                        Button("2", action: {moltiplytimer = 2 })
                                        Button("1", action: {moltiplytimer = 1  })
                                    } label: {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(.white)
                                                .frame(width: 70, height: 30, alignment: .top)
                                            Text(" \(moltiplytimer) min")
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                   
                                        Button(action: {
                                            nowDate = referenceDate
                                            _ = self.timer
                                        })
                                        {
                                            Text("Start")
                                                    .font(.headline)
                                                    .foregroundColor(.white).scaleEffect(1.2)
                                                    .padding(.vertical,15)
                                                    .padding(.horizontal,75)
                                                    .background(.green)
                                                    .cornerRadius(30)
                                        }
                  
                    
                                        
//                    RoundedRectangle(cornerRadius: 40)
////                            .stroke(isPressed==1 ? Color.white : Color.black)
//                            .frame(width: 70, height: 30, alignment: .top)
//                        Text("1 min")
//                            .foregroundColor(isPressed==1 ? Color.white : Color.black.opacity(2))
//                     }
//                        }
//                Button(action: {
//                        if isPressed != 2{
//                        isPressed = 2
//
//                        } else {
//                            isPressed = 0
//                        }
//
//                    })  {
//                    ZStack{
//                    RoundedRectangle(cornerRadius: 40)
//                            .stroke(isPressed==2 ? Color.white : Color.black.opacity(2))
//                            .frame(width: 70, height: 30, alignment: .top)
//
//                        Text("2 min")
//                            .foregroundColor(isPressed==2 ? Color.white : Color.black.opacity(2))
//                     }
//                    }
//                    Button(action: {
//                            if isPressed != 3{
//                            isPressed = 3
//
//                            } else {
//                                isPressed = 0
//                            }
//
//                        })  {
//                    ZStack{
//                    RoundedRectangle(cornerRadius: 40)
//                            .stroke(isPressed==3 ? Color.white : Color.black.opacity(2))
////                            .frame(width: 70, height: 30, alignment: .top)
//                        Text("3 min")
//                            .foregroundColor(isPressed==3 ? Color.white : Color.black.opacity(2))
//                    }
//                        }
    
                }
                .padding()
                

            
            }

        } .onChange(of: moltiplytimer, perform: {
            _ in
         
            referenceDate = nowDate.addingTimeInterval(60 * Double(moltiplytimer))
        })
    }
    //////////////////////////////////Funzione
    ///
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02d:%02d",
                    
                      
                      components.minute ?? 00,
                      components.second ?? 00)
    }
    
}
struct BreathHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}

