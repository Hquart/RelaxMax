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
    
    var body: some View {
        ZStack {
            Rectangle()
                .animatableGradient(fromGradient: Gradient(colors: [Color.focusBlue1, Color.focusBlue2]),
                                    toGradient: Gradient(colors: [Color.green, Color.orange]),
                                    progress: progress)
                .ignoresSafeArea()
                .animation(.linear(duration: 5.0).repeat(while: animate), value: animate)
        }
    }
}

//struct FocusGradientView_Previews: PreviewProvider {
//    static var previews: some View {
//        FocusGradientView()
//    }
//}
