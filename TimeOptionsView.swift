//
//  TimeOptionsView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 01/06/2022.

// get package: CollectionViewPagingLayout


import SwiftUI
import CollectionViewPagingLayout


struct TimeOptionsView: View {
    
    var selectionText: String
    var color: Color
    var items: [OptionItem]
    @Binding var selection: UUID?
    
    var options: ScaleTransformViewOptions {
        .layout(.cylinder)
    }
    
    var body: some View {
        VStack {
            Text(selectionText)
                .font(.custom("SF Pro Text", size: 20))
                .foregroundColor(color).bold()
        ScalePageView(items, selection: $selection) { item in
            Text("\(item.minutes) mn")
                .font(.custom("SF Pro Text", size: 35))
                .foregroundColor(color).bold()
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

struct OptionItem: Identifiable {
    var id: UUID = .init()
    let minutes: Int
}


//struct TimeOptionsPicker_Previews: PreviewProvider {
//
//    var breathDurationOptions = [OptionItem(minutes: 0),
//                                 OptionItem(minutes: 1),
//                                 OptionItem(minutes: 2),
//                                 OptionItem(minutes: 3),
//                                 OptionItem(minutes: 4),
//                                 OptionItem(minutes: 5)]
//
//    static var previews: some View {
//        TimeOptionsView(items: [OptionItem(id: UUID(), minutes: 0), OptionItem(id: UUID(), minutes: 1)], selection: <#T##Binding<UUID?>#>)
//    }
//}

