//
//  FocusGradientView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 04/06/2022.
//

import SwiftUI

struct FocusGradientView: View {
    
    @Binding var progress: CGFloat
    @Binding var animate: Bool
    
    @Binding var duration: Double
    
    var body: some View {
        ZStack {
            Rectangle()
                .animatableGradient(fromGradient: Gradient(colors: [Color.focusBlue1, Color.focusBlue2]),
                                    toGradient: Gradient(colors: [Color.blue, Color.darkblue]),
                                    progress: progress)
                .ignoresSafeArea()
                .animation(.linear(duration: duration), value: animate)
        }
    }
}

//struct FocusGradientView_Previews: PreviewProvider {
//    static var previews: some View {
//        FocusGradientView()
//    }
//}
