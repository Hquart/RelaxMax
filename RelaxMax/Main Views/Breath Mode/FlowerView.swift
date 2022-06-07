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
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower", rotationIn: -25, rotationOut: -5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower", rotationIn: 25, rotationOut: 5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower", rotationIn:  -50, rotationOut: -10).opacity(0.7)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower", rotationIn: 50, rotationOut: 10).opacity(0.7)
        }

        .scaleEffect(1.2)
        .shadow(color: .white, radius: animFlower ? 20 : 0)
        .shadow(color: .purple, radius: openFlower ? 0 : 100)
        .animation(Animation.easeInOut(duration: 5.0).repeat(while: animFlower, autoreverses: true), value: animFlower)
                   
          
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
struct FlowerInfoView: View {
    
    @Binding var animFlower: Bool
    @Binding var openFlower: Bool
    
    var body: some View {
        ZStack {
            Image("flower2")
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower2", rotationIn: -25, rotationOut: -5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower2", rotationIn: 25, rotationOut: 5).opacity(0.9)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower2", rotationIn:  -50, rotationOut: -10).opacity(0.7)
            Petal(animate: $animFlower, openFlower: $openFlower, flowerImageString: "flower2", rotationIn: 50, rotationOut: 10).opacity(0.7)
        }

        .scaleEffect(1.2)
        .shadow(color: .white, radius: animFlower ? 20 : 0)
        .shadow(color: .purple, radius: openFlower ? 0 : 100)
//        .animation(Animation.easeInOut(duration: 5.0).repeat(while: animFlower, autoreverses: true), value: animFlower)
                   
          
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////
struct Petal: View {
    
    @Binding var animate: Bool
    @Binding var openFlower: Bool
    
    var flowerImageString: String
    var rotationIn: Double
    var rotationOut: Double
    
    var body: some View {
        Image(flowerImageString)
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
            Color.black.ignoresSafeArea()
        VStack {
            FlowerView(animFlower: .constant(false), openFlower: .constant(false)).scaleEffect(0.7)
                .padding()
            FlowerView(animFlower: .constant(true), openFlower: .constant(true)).scaleEffect(0.7)
                .padding()
            FlowerInfoView(animFlower: .constant(true), openFlower: .constant(true)).scaleEffect(0.7)
        }
      
        }
        .previewDevice("iPhone 13")
}
}
