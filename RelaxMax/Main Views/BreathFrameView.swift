//
//  BreathFrameView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 26/05/2022.
//

import SwiftUI

struct BreathFrameView: View {

    @State private var progress: CGFloat = 0.0
    var frameHeight: Double
    
    @State private var animate: Bool = false
    @State private var hasShadow: Bool = false
    
    let gradientOne = Gradient(colors: [.purple, .gray])
    let gradientTwo = Gradient(colors: [.blue, .purple])

    var body: some View {
        
        ZStack {
            Group {
            LinearGradient(colors: [.purple, .blue], startPoint: .trailing, endPoint: .leading)
            
//                .animatableGradient(fromGradient: gradientOne, toGradient: gradientTwo, progress: progress)
            
                .frame(width: UIScreen.main.bounds.size.width/1.2, height: UIScreen.main.bounds.size.height/frameHeight)
                
                .cornerRadius(40)
            }.shadow(color: Color.appDarkBlue, radius: 1, x: 6, y: 6)
                Spacer()
            FlowerFrameView(animFlower: $animate).scaleEffect().opacity(0.3)
              
            Text("Breath")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
                .shadow(color: .black, radius: 4)
                Spacer()
        }
       
      
      
        .onAppear {
            animate = true
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                self.progress = 1
            }
     
        }
       
    }

}

struct BreathFrameView_Previews: PreviewProvider {
    static var previews: some View {
        BreathFrameView(frameHeight: 5)
    }
}






struct FlowerFrameView: View {
    
    @Binding var animFlower: Bool
    
    var body: some View {
        ZStack {
            Image("flower")
//            Petal(animate: $animFlower,
//                  rotationIn: -25, rotationOut: -15)
//            Petal(animate: $animFlower,
//                  rotationIn: 25, rotationOut: 5)
//            Petal(animate: $animFlower,
//                  rotationIn:  -50, rotationOut: -10)
//            Petal(animate: $animFlower,
//                  rotationIn: 50, rotationOut: 10)
        }
//        .scaleEffect(2.1)
        .shadow(color: .blue, radius: animFlower ? 100 : 0)
//        .hueRotation(Angle(degrees: animFlower ? 0 : 90))
        .animation(Animation.easeInOut(duration: 5.0)
            .repeat(while: animFlower, autoreverses: true), value: animFlower)
    }
}
