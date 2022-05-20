//
//  CircleModel.swift
//  StarGates
//
//  Created by Naji Achkar on 19/05/2022.
//

import SwiftUI

struct CirclesModel: View {
    
    var size : Double
    @State var element : Bool
    @State var rotateHue : Bool
    var colorDelay : Double
    var animationDelay : Double
    let heightOfScreen = UIScreen.main.bounds.height
    let widthOfScreen = UIScreen.main.bounds.width
    
    var body: some View {
        Circle()
            .stroke(lineWidth:7)
            .frame(minWidth: widthOfScreen/size, maxWidth: widthOfScreen/size, minHeight: heightOfScreen/size, maxHeight: heightOfScreen/size)
            .foregroundColor(.cyan)
            .hueRotation(.degrees(rotateHue ? -400 : .pi * 300))
            .animation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true).delay(colorDelay), value: element)
            .onAppear() {
                rotateHue.toggle()
            }
            .rotation3DEffect(.degrees(85), axis:(x: 1, y: 0, z: 0))
            .offset(y: element ? -200 : 200)
            .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses:true).delay(animationDelay), value: element)
            .onAppear(){
                self.element.toggle()
            }
    }
}

struct CirclesModel_Previews: PreviewProvider {
    static var previews: some View {
        CirclesModel(size: 2, element: true, rotateHue: true, colorDelay: 1.0, animationDelay: 1.0)
            .previewDevice("iPhone 13")
    }
}
