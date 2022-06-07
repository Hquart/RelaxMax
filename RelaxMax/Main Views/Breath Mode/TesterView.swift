//
//  TesterView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 31/05/2022.
//

import SwiftUI

struct TesterView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var counter = 0

    var body: some View {
        Text("\(counter)")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                    print("\(counter)")
                } 
                counter += 1
                print("\(counter)")
            }
    }
}


struct TesterView_Previews: PreviewProvider {
    static var previews: some View {
        TesterView()
            .previewDevice("iPhone 13")
    }
}
