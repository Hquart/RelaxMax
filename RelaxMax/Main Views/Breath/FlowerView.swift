//
//  FlowerView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI

struct FlowerView: View {
    
    @Binding var animFlower: Bool
    @Binding var openFlower: Bool
    
    var body: some View {
        ZStack {
            Image("flower")
            Petal(animate: $animFlower, openFlower: $openFlower, rotationIn: -25, rotationOut: -5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, rotationIn: 25, rotationOut: 5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, rotationIn:  -50, rotationOut: -10).opacity(0.7)
            Petal(animate: $animFlower, openFlower: $openFlower, rotationIn: 50, rotationOut: 10).opacity(0.7)
        }
        .scaleEffect(1.2)
        .shadow(color: .white, radius: animFlower ? 20 : 0)
        .shadow(color: .purple, radius: openFlower ? 0 : 100)
        .animation(Animation.easeInOut(duration: 5.0).repeat(while: animFlower, autoreverses: true), value: animFlower)
                   
          
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
struct Petal: View {
    
    @Binding var animate: Bool
    @Binding var openFlower: Bool
    
    var rotationIn: Double
    var rotationOut: Double
    
    var body: some View {
        Image("flower")
            .rotationEffect(.degrees(animate ? rotationIn : rotationOut), anchor: .bottom)
            .rotationEffect(.degrees(openFlower ? rotationIn : rotationOut), anchor: .bottom)
            .animation(Animation.easeInOut(duration: 5.0)
                .repeat(while: animate, autoreverses: true), value: animate)
            .animation(.linear(duration: 3).repeatCount(1), value: openFlower)
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------  PREVIEW  ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.breathGreen1.ignoresSafeArea()
        VStack {
            FlowerView(animFlower: .constant(false), openFlower: .constant(false))
                .padding(.bottom, 200)
            FlowerView(animFlower: .constant(true), openFlower: .constant(true))
                .padding()
        }
        .previewDevice("iPhone 13")
    }
}
}
