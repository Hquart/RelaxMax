//
//  CircularProgressView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 02/06/2022.
//

import SwiftUI

struct CircularProgressView: View {
    
    @Binding var value: Double
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.55, to: 0.95)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round)).foregroundColor(.white).opacity(0.2)
            Circle()
                .trim(from: 0.55, to: value)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round)).foregroundColor(.white)
                .animation(.easeOut, value: value)
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.breathGreen1.ignoresSafeArea()
            CircularProgressView(value: .constant(0.75))
            .frame(width: 200, height: 200)
        }
    }
}
