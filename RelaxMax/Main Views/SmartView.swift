//
//  SmartView.swift
//  StarGates
//
//  Created by Naji Achkar on 12/05/2022.
//

import SwiftUI

struct SmartView: View {
    
    @State private var infoText: String =    """
    Smart Mode provides sounds effects
    automatically for you throughout the day
    based on your location, heartrate...
    """
    
    var body: some View {
        ZStack {
            GradientAnim(color1: .blue, color2: .gray, color3: .black, color4: .white)
                .opacity(0.5)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Text(infoText)
                    .italic()
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .padding()
                Spacer()
                Button("Autorize localisation") {
                }
                .buttonStyle(.bordered)
                .scaleEffect(1.2)
                Button("Autorize Health Data") {
                }
                .buttonStyle(.bordered)
                .scaleEffect(1.2)
                Button("Autorize Motion Data") {
                }
                .buttonStyle(.bordered)
                .scaleEffect(1.2)
                Button("Autorize Notifications") {
                }
                .buttonStyle(.bordered)
                .scaleEffect(1.2)
                Spacer()
//                PlayerAudioView()
                
            }
        }
       
    }
}

struct SmartView_Previews: PreviewProvider {
    static var previews: some View {
        SmartView()
            .previewDevice("iPhone 13")
    }
}
