
//
//  RelaxView.swift
//  theXteam
//
//  Created by Tery Vezzuto on 16/05/22.
//


import SwiftUI


struct SpringAnim: View {
    
    @State private var oneMoves = false
    @State private var twoMoves = false
    @State private var threeMoves = false
    @State private var fourMoves = false
    @State private var fiveMoves = false
    @State private var sixMoves = false
    @State private var sevenMoves = false
    @State private var eightMoves = false
    @State private var nineMoves = false
    @State private var hueRotate = false
    @State private var isTapped = false
    @State private var rotateIn3D = false
    
    
    
    var body: some View {
        ZStack{
            Group{
                CirclesModel(size: 20, element: oneMoves, rotateHue: hueRotate, colorDelay: 0.1, animationDelay: 0.2)
                CirclesModel(size: 12, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.15, animationDelay: 0.3)
                
                CirclesModel(size: 8, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.2, animationDelay: 0.4)
                
                CirclesModel(size: 6, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.25, animationDelay: 0.5)
                
                CirclesModel(size: 5, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.3, animationDelay: 0.6)
                
                CirclesModel(size: 4, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.35, animationDelay: 0.7)
                
                CirclesModel(size: 3, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.4, animationDelay: 0.8)
                
                CirclesModel(size: 2.5, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.45, animationDelay: 0.9)
                
                CirclesModel(size: 2, element: twoMoves, rotateHue: hueRotate, colorDelay: 0.5, animationDelay: 1)
            }
            .scaleEffect(isTapped ? 1 : 1.7)
                .animation(.easeInOut(duration: 1.0), value: isTapped)
            
                .onTapGesture {
                    self.isTapped.toggle()
                }
                .rotation3DEffect(.degrees(rotateIn3D ? -12 : 12), axis: (x: rotateIn3D ? 85 : -20, y: rotateIn3D ? -20 : 85, z: 1000))
                .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: rotateIn3D)
                .onAppear() {
                    self.rotateIn3D.toggle()
                }
        }
    }
}

struct SpingAnim_Previews: PreviewProvider {
    static var previews: some View {
        RelaxView2()
    }
}

