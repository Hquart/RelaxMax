//
//  FocusInfoView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 24/05/2022.
//

import SwiftUI

struct FocusInfoView: View {
    
@State private var infoText = """

Select work session duration

Deep focus with white noise

Music will notify you at break time

"""
    
    var body: some View {
        GeometryReader { geo in
        ZStack {
            LinearGradient(colors: [.blue, .gray], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            
        VStack {
            ZStack {
                ClockView(showTicks: false).scaleEffect(0.8).zIndex(1)
                Image("clock3")
            }

        Text(infoText)
                .foregroundColor(Color.black)
                .font(.headline)
                .italic()
                .multilineTextAlignment(.center)
                .scaleEffect(1.2)
        }
        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.6, alignment: .center)
    }
    }
}
}

struct FocusInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FocusInfoView()
            .previewDevice("iPhone 13")
    }
}
