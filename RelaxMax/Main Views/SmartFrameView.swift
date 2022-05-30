//
//  HomeFrameView2.swift
//  RelaxMax
//
//  Created by Naji Achkar on 26/05/2022.
//

import SwiftUI


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SmartFrameView: View {

    var frameHeight: Double
    
    @State private var progress: CGFloat = 0.0
    @State private var isGlowing: Bool = false
    @State private var isPlaying: Bool = false
    @ObservedObject var musicPlayer = AudioPlayer(name: "marconi", type: "mp3", volume: 1, fadeDuration: 5.0, loops: 0)

    let gradientOne = Gradient(colors: [.blue, .appDarkBlue])
    let gradientTwo = Gradient(colors: [.appDarkBlue, .blue])
    
    var body: some View {
        
        ZStack {
            Group {
                LinearGradient(colors: [.purple, .blue], startPoint: .trailing, endPoint: .leading)
                    .animatableGradient(fromGradient: gradientOne, toGradient: gradientTwo, progress: progress)
            }
            .frame(width: UIScreen.main.bounds.size.width/1.2, height: UIScreen.main.bounds.size.height/frameHeight)
            .cornerRadius(40)
            .shadow(color: Color.black, radius: 1, x: 6, y: 6)
        
           
//                VStack(alignment: .leading, spacing: 10) {
//                Image(systemName: "heart.circle")
//                    .foregroundColor(Color.appRed).opacity(0.5)
//                    .scaleEffect(2)
//                    .padding()
//                Spacer()
//                Image(systemName: "location.circle")
//                        .foregroundColor(Color.appDarkBlue).opacity(0.5)
//                    .scaleEffect(2)
//                    .padding()
//            }
                Spacer()
            VStack {
                ZStack {
                    Text("Smart Sounds")
                        .italic()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .blur(radius: isGlowing ? 2 : 0)
                        .animation(.linear(duration: 0.05).repeatForever(), value: isGlowing)
                    Text("Smart Sounds")
                        .italic()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .shadow(color: .orange, radius: 5)
                }
                .padding()
                                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(Color.orange)
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(Color.black)
                                        .aspectRatio(contentMode: .fit)
                                        .shadow(color: .appBlue, radius: 3)
                                        .scaleEffect(1.2)
                Spacer()
                
                
           

//                Image(systemName: "cloud.sun")
//                        .foregroundColor(Color.appOrange).opacity(0.5)
//                    .scaleEffect(2)
//                    .padding()
//
//                Spacer()
//
//                Image(systemName: "figure.walk")
//                        .foregroundColor(Color.black).opacity(0.5)
//                    .scaleEffect(2)
//                    .padding()

         
                
            
               
            }
            .frame(width: UIScreen.main.bounds.size.width/1.4, height: UIScreen.main.bounds.size.height/6)
         
        }.onAppear {
            isGlowing = true
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                self.progress = 1
            }
        }
      
        }
        
    }

struct SmartFrameView_Previews: PreviewProvider {
    static var previews: some View {
        SmartFrameView(frameHeight: 6)
    }
}



