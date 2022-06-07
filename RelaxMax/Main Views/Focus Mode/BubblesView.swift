//
//  BubblesView.swift
//  RelaxMax
//
//  Created by Andrea Romagnuolo on 07/06/2022.
//

import SwiftUI



struct BubblesView: View {
    
    @Binding  var animate : Bool 
    
    let whitePosition1 = Float.random(in: -200..<100)
    let whitePosition2 = Float.random(in: -200..<100)
    let whitePosition3 = Float.random(in: -200..<100)
    let whitePosition4 = Float.random(in: -200..<100)
    let whitePosition5 = Float.random(in: -200..<100)
    let whitePosition6 = Float.random(in: -200..<100)
    
    @State private var rotate2d = false
    @State private var rotate2dWhite = false
    
    var body: some View {
        
        ZStack {
      Group {
              Image("circle")
              .offset(x: CGFloat(animate ? 100 : whitePosition2), y: CGFloat(animate  ? whitePosition2 : whitePosition1))
                Image("circle")
              .offset(x: CGFloat(animate ? -100 : whitePosition3), y: CGFloat(animate  ? whitePosition3 : whitePosition2))
                Image("circle")
              .offset(x: CGFloat(animate ? -90 : whitePosition4), y: CGFloat(animate  ? whitePosition4 : whitePosition3))
                Image("circle")
              .offset(x: CGFloat(animate ? 0 : whitePosition5), y: CGFloat(animate  ? whitePosition5:whitePosition4))
                Image("circle")
              .offset(x: CGFloat(animate ? -50 : whitePosition6),y: CGFloat(animate  ? whitePosition6 : whitePosition5))
                Image("circle")
              .offset(x: CGFloat(animate ? -60 : whitePosition1), y: CGFloat(animate  ? whitePosition1 : whitePosition6))
      }
//      .rotationEffect(.degrees( Double(rotate2d ? whitePosition1: whitePosition2)))
            
      .animation(Animation.linear(duration: 10).delay(0.0001).repeatForever(), value: rotate2d)
                .onAppear {
                    rotate2d.toggle()
                }
                
        Group {
                
                Image("circle2")
                .offset(x: animate ? 70 : 30, y: animate  ? -100:10)
            
                Image("circle2")
                .offset(x: animate ? 150 : -30, y: animate  ? -120:20)
            
                Image("circle2")
                .offset(x: animate ? 180 : 100, y: animate  ? -130:30)
            
                Image("circle2")
                .offset(x: animate ? 10 : -100, y: animate  ? -200:40)
            
                Image("circle2")
                .offset(x: animate ? 30 : -150, y: animate  ? 100:50)
            
                Image("circle2")
                .offset(x: animate ? 50 : 50, y: animate  ? 200:60)
            
                Image("circle2")
                .offset(x: animate ? 60 : 100, y: animate  ? 150:70)
            
                Image("circle2")
                .offset(x: animate ? 70 : -200, y: animate  ? 90:80)
            
                Image("circle2")
                .offset(x: animate ? 100 : 00, y: animate  ? -70:90)
            
                Image("circle2")
                .offset(x: animate ? 120 : 00, y: animate  ? -90:100)

        }
        .rotationEffect(.degrees( Double(rotate2dWhite ? whitePosition6: whitePosition5)))
                .animation(Animation.linear(duration: 16).delay(0.00001).repeatForever(autoreverses: true), value: rotate2dWhite)
                  .onAppear {
                      rotate2dWhite.toggle()
                  }
        .animation(Animation.easeInOut(duration: 4).delay(2).repeatForever(autoreverses: true), value: animate)
        .onAppear {
            animate.toggle()
        }
                

        }
        .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true), value: animate)
                .onAppear {
                   animate.toggle()
             }
        
 
    }
}
//
//struct FocusView_Previews: PreviewProvider {
//    static var previews: some View {
//        BubblesView()
//    }
//}
//}
