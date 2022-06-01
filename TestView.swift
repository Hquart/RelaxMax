////
////  TestView.swift
////  RelaxMax
////
////  Created by Naji Achkar on 22/05/2022.
////
//
////import SwiftUI
////
////
////
////struct RetestView: View {
////    @State var progressValue: Float = 0.0
////
////    var body: some View {
////        ZStack {
////            Color.yellow
////                .opacity(0.1)
////                .edgesIgnoringSafeArea(.all)
////
////            VStack {
////                ProgressBar(progress: self.$progressValue)
////                    .frame(width: 150.0, height: 150.0)
////                    .padding(40.0)
////
////                Button(action: {
////                    self.incrementProgress()
////                }) {
////                    HStack {
////                        Image(systemName: "plus.rectangle.fill")
////                        Text("Increment")
////                    }
////                    .padding(15.0)
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 15.0)
////                            .stroke(lineWidth: 2.0)
////                    )
////                }
////
////                Spacer()
////            }
////        }
////    }
////
////    func incrementProgress() {
////        let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
////        self.progressValue += randomValue
////    }
////}
////struct ProgressBar: View {
////    @Binding var progress: Float
////
////    var body: some View {
////        ZStack {
////            Circle()
////                .stroke(lineWidth: 20.0)
////                .opacity(0.3)
////                .foregroundColor(Color.red)
////
////            Circle()
////                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
////                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
////                .foregroundColor(Color.red)
////                .rotationEffect(Angle(degrees: 270.0))
////                .animation(.linear)
////
////            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
////                .font(.largeTitle)
////                .bold()
////        }
////    }
////}
////
////    struct CirclesAnimView_Previews: PreviewProvider {
////        static var previews: some View {
////            RetestView()
////        }
////    }
////
////
////import SwiftUI
////
////struct SnapCarousel: View {
////    @EnvironmentObject var UIState: UIStateModel
////
////    var body: some View {
////        let spacing: CGFloat = 16
////        let widthOfHiddenCards: CGFloat = 32 /// UIScreen.main.bounds.width - 10
////        let cardHeight: CGFloat = 279
////
////        let items = [
////            Text("test"),
////            Text("test"),
////            Text("test"),
////            Text("test")
//////            Card(id: 0, name: "Hey"),
//////            Card(id: 1, name: "Ho"),
//////            Card(id: 2, name: "Lets"),
//////            Card(id: 3, name: "Go")
////        ]
////
////        return Canvas {
////            /// TODO: find a way to avoid passing same arguments to Carousel and Item
////            Carousel(
////                numberOfItems: CGFloat(items.count),
////                spacing: spacing,
////                widthOfHiddenCards: widthOfHiddenCards
////            ) {
////                ForEach(items, id: \.self) { item in
////                    Item(
////                        _id: Int(item),
////                        spacing: spacing,
////                        widthOfHiddenCards: widthOfHiddenCards,
////                        cardHeight: cardHeight
////                    ) {
////                        Text("\(item.name)")
////                    }
////                    .background(Color.red)
////                    .foregroundColor(Color.black)
////                    .background(Color("surface"))
////                    .cornerRadius(8)
////                    .shadow(color: Color("shadow1"), radius: 4, x: 0, y: 4)
////                    .transition(AnyTransition.slide)
////                    .animation(.spring())
////                }
////            }
////        }
////    }
////}
////
////struct Card: Decodable, Hashable, Identifiable {
////    var id: Int
////    var name: String = ""
////}
////
////public class UIStateModel: ObservableObject {
////    @Published var activeCard: Int = 0
////    @Published var screenDrag: Float = 0.0
////}
////
////struct Carousel<Items : View> : View {
////    let items: Items
////    let numberOfItems: CGFloat //= 8
////    let spacing: CGFloat //= 16
////    let widthOfHiddenCards: CGFloat //= 32
////    let totalSpacing: CGFloat
////    let cardWidth: CGFloat
////
////    @GestureState var isDetectingLongPress = false
////
////    @EnvironmentObject var UIState: UIStateModel
////
////    @inlinable public init(
////        numberOfItems: CGFloat,
////        spacing: CGFloat,
////        widthOfHiddenCards: CGFloat,
////        @ViewBuilder _ items: () -> Items) {
////
////        self.items = items()
////        self.numberOfItems = numberOfItems
////        self.spacing = spacing
////        self.widthOfHiddenCards = widthOfHiddenCards
////        self.totalSpacing = (numberOfItems - 1) * spacing
////        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
////
////    }
////
////    var body: some View {
////        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
////        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
////        let leftPadding = widthOfHiddenCards + spacing
////        let totalMovement = cardWidth + spacing
////
////        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
////        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
////
////        var calcOffset = Float(activeOffset)
////
////        if (calcOffset != Float(nextOffset)) {
////            calcOffset = Float(activeOffset) + UIState.screenDrag
////        }
////
////        return HStack(alignment: .center, spacing: spacing) {
////            items
////        }
////        .offset(x: CGFloat(calcOffset), y: 0)
////        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
////            self.UIState.screenDrag = Float(currentState.translation.width)
////
////        }.onEnded { value in
////            self.UIState.screenDrag = 0
////
////            if (value.translation.width < -50) {
////                self.UIState.activeCard = self.UIState.activeCard + 1
////                let impactMed = UIImpactFeedbackGenerator(style: .medium)
////                impactMed.impactOccurred()
////            }
////
////            if (value.translation.width > 50) {
////                self.UIState.activeCard = self.UIState.activeCard - 1
////                let impactMed = UIImpactFeedbackGenerator(style: .medium)
////                impactMed.impactOccurred()
////            }
////        })
////    }
////}
////
////struct Canvas<Content : View> : View {
////    let content: Content
////    @EnvironmentObject var UIState: UIStateModel
////
////    @inlinable init(@ViewBuilder _ content: () -> Content) {
////        self.content = content()
////    }
////
////    var body: some View {
////        content
////            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
////            .background(Color.white.edgesIgnoringSafeArea(.all))
////    }
////}
////
////struct Item<Content: View>: View {
////    @EnvironmentObject var UIState: UIStateModel
////    let cardWidth: CGFloat
////    let cardHeight: CGFloat
////
////    var _id: Int
////    var content: Content
////
////    @inlinable public init(
////        _id: Int,
////        spacing: CGFloat,
////        widthOfHiddenCards: CGFloat,
////        cardHeight: CGFloat,
////        @ViewBuilder _ content: () -> Content
////    ) {
////        self.content = content()
////        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
////        self.cardHeight = cardHeight
////        self._id = _id
////    }
////
////    var body: some View {
////        content
////            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
////    }
////}
////
////struct SnapCarousel_Previews: PreviewProvider {
////    static var previews: some View {
////        SnapCarousel().previewDevice("iPhone 13").environmentObject(UIStateModel())
////    }
////}
//
//
//import SwiftUI
//import CollectionViewPagingLayout
////
////// Make sure you added this dependency to your project
////// More info at https://bit.ly/CVPagingLayout
////import CollectionViewPagingLayout
////
//struct TimeOptionsView: View {
//
//    var items: [OptionItem]
//    @Binding var selection: UUID?
//
//    // Replace with your data
////    struct OptionItem: Identifiable {
////        let id: UUID = .init()
////        let name: String
////    }
//
//    // Use the options to customize the layout
//    var options: ScaleTransformViewOptions {
//          .layout(.cylinder)
//      }
//
//    var body: some View {
//        VStack {
//            Text("Breath Duration:")
//        ScalePageView(items, selection: $selection) { item in
//            // Build your view here
//
//                Text("\(item.minutes)")
//                    .font(.custom("SF Pro Text", size: 35))
//                    .foregroundColor(.black).bold()
//
//
////                    .frame(width: 200, height: 200)
//        }
//
//        }
////        .onTapPage { index in
////            self.selection = index
////            print("SELECTION: \(index)")
////        }
//
//
//        .options(options)
//        // The padding around each page
//        // you can use `.fractionalWidth` and
//        // `.fractionalHeight` too
//        .pagePadding(
//            vertical: .absolute(30),
//            horizontal: .absolute(100)
//        )
//    }
//}
////
//////struct TimeOptionsView_Previews: PreviewProvider {
//////    static var previews: some View {
//////        TimeOptionsView(items: [OptionItem(name: "1"), OptionItem(name: "2") ])
//////            .previewDevice("iPhone 13")
//////    }
//////}
////
////
