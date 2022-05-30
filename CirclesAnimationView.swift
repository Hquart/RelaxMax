////
////  CirclesAnimationView.swift
////  RelaxMax
////
////  Created by Naji Achkar on 20/05/2022.
////
//
//
//import SwiftUI
//
//struct CirclesAnimationView: View {
//    
//    @State private var movement = -300.0
//    @State private var animDuration = 2.0
//    @State private var animate: Bool = true
//    
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            ZStack {
//                Circle() //1 no delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 100, height: 100)
//                    .foregroundColor(.red).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //2 0.1 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 150, height: 150)
//                    .foregroundColor(.orange).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                    
//                Circle() //3 0.2 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 200, height: 200)
//                    .foregroundColor(.yellow).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //4 0.3 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 250, height: 250)
//                    .foregroundColor(.green).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //5 0.4 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 300, height: 300)
//                    .foregroundColor(.blue).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //6 0.5 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 350, height: 350)
//                    .foregroundColor(.pink).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //7 0.6 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 400, height: 400)
//                    .foregroundColor(.purple).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                    
//                Circle() //8 0.7 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 450, height: 450)
//                    .foregroundColor(.indigo).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //9 0.8 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 500, height: 500)
//                    .foregroundColor(.white).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//                
//                Circle() //10 0.9 delay
//                    .stroke(lineWidth: 5)
//                    .frame(width: 550, height: 550)
//                    .foregroundColor(.cyan).shadow(radius: 3)
//                    .offset(y: CGFloat(movement))
//                    .animation(Animation.easeInOut(duration: randomDuration()).repeatForever(autoreverses: true))
//        }
//            
//            .rotation3DEffect(.degrees(45), axis: (x: 10, y: 5, z:0))
//    }
//        
// 
//        .onAppear() {
//            movement = Double.random(in: 100.0 ..< 500.0)
//        }
//}
//    func randomDuration() -> Double {
//        return Double.random(in: 2.0..<3.0)
//    }
//
//}
//
//
//
//
//struct CirclesAnimView_Previews: PreviewProvider {
//    static var previews: some View {
//        CirclesAnimationView()
//    }
//}
//
//
