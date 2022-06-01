//
//  TimeOptionsView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 01/06/2022.
//


import SwiftUI
import CollectionViewPagingLayout


struct TimeOptionsView: View {
    
    var items: [OptionItem]
    @Binding var selection: UUID?
    
    var options: ScaleTransformViewOptions {
        .layout(.cylinder)
    }
    
    var body: some View {
        VStack {
            Text("Select duration:")
                .font(.custom("SF Pro Text", size: 25))
                .foregroundColor(.white).bold()
        ScalePageView(items, selection: $selection) { item in
            Text("\(item.minutes) mn")
                .font(.custom("SF Pro Text", size: 35))
                .foregroundColor(.white).bold()
                .scaleEffect(item.id == selection ? 1.4 : 1.0)
        }
        .options(options)
        .pagePadding(
            vertical: .absolute(0),
            horizontal: .absolute(120)
        )
    }
    }
}


//struct TimeOptionsPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeOptionsView()
//    }
//}
