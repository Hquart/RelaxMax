//
//  FocusFrameView.swift
//  RelaxMax
//
//  Created by Naji Achkar on 26/05/2022.
//

import SwiftUI

struct FocusFrameView: View {

    @State private var progress: CGFloat = 0.0
    var frameHeight: Double
    
    @State private var animate: Bool = false
    
    let gradientOne = Gradient(colors: [.blue, .gray])
    let gradientTwo = Gradient(colors: [.appGreen, .orange])

    var body: some View {
        
        ZStack {
            Group {
            LinearGradient(colors: [.purple, .blue], startPoint: .trailing, endPoint: .leading)
                .animatableGradient(fromGradient: gradientOne, toGradient: gradientTwo, progress: progress)
                .frame(width: UIScreen.main.bounds.size.width/1.2, height: UIScreen.main.bounds.size.height/frameHeight)
                .cornerRadius(40)
        }
            .shadow(color: Color.appDarkBlue, radius: 1, x: 6, y: 6)
                Spacer()
            ClockFrameView().scaleEffect(frameHeight/9).opacity(1)
            Text("Focus")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
                .shadow(color: .black, radius: 4)
             
                Spacer()
        }
        .onAppear {
            animate = true
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                self.progress = 1
            }
     
        }
       
    }

}

struct FocusFrameView_Previews: PreviewProvider {
    static var previews: some View {
        FocusFrameView(frameHeight: 5)
    }
}





struct ClockFrameView: View {
    @ObservedObject var time = CurrentTime()
    func tick(at tick: Int) -> some View {
               VStack {
                   Rectangle()
                       .fill(Color.white)
                       .opacity(tick % 5 == 0 ? 1 : 0.0)
                       .frame(width: 2, height: tick % 5 == 0 ? 15 : 7)
                   Spacer()
           }.rotationEffect(Angle.degrees(Double(tick)/(60) * 360))
    }
    
    var body: some View {
        return ZStack {
            ForEach(0..<60) { tick in
                self.tick(at: tick)
            }
            GeometryReader { geometry in
                ZStack {
                }
                .frame(width: geometry.size.width - 40, height: geometry.size.height - 30, alignment: .center)
            }
            
            Clock(model: .init(type: .hour, timeInterval: time.seconds, tickScale: 0.4))
            .stroke(Color.primary, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle.degrees(360/60))
            
            Clock(model: .init(type: .minute, timeInterval: time.seconds, tickScale: 0.6))
            .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle.degrees(360/60))
            }.frame(width: 200, height: 200, alignment: .center)
    }
}
