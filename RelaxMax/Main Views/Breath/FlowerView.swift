//
//  FlowerView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 21/05/2022.
//

import SwiftUI

struct FlowerView: View {
    
    @Binding var animFlower: Bool
    
    var body: some View {
        ZStack {
            Image("flower")
            Petal(animate: $animFlower,
                  rotationIn: -25, rotationOut: -5)
            Petal(animate: $animFlower,
                  rotationIn: 25, rotationOut: 5)
            Petal(animate: $animFlower,
                  rotationIn:  -50, rotationOut: -10)
            Petal(animate: $animFlower,
                  rotationIn: 50, rotationOut: 10)
        }
        .scaleEffect(2.1)
        .shadow(color: .blue, radius: animFlower ? 100 : 0)
        .hueRotation(Angle(degrees: animFlower ? 0 : 90))
        .animation(Animation.easeInOut(duration: 5.0)
            .repeat(while: animFlower, autoreverses: true), value: animFlower)
    }
    func resetFlower() {
        
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
struct Petal: View {
    
    @Binding var animate: Bool
    
    var rotationIn: Double
    var rotationOut: Double
    
    var body: some View {
        Image("flower")
            .rotationEffect(.degrees(animate ? rotationIn : rotationOut), anchor: .bottom)
            .animation(Animation.easeInOut(duration: 5.0)
                .repeat(while: animate, autoreverses: true), value: animate)
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
///------------  PREVIEW  ------------------
////////////////////////////////////////////////////////////////////////////////////////////////
struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FlowerView(animFlower: .constant(false))
                .padding(.bottom, 200)
            FlowerView(animFlower: .constant(true))
                .padding()
        }
        .previewDevice("iPhone 13")
    }
}
