//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import AVFoundation

struct ContentView: View {
    // Use this variabe to start animating the backgrund city
    @State var tapCount = false
    // Use this variable to animate the frames of the character
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var imageNames: [String] = ["run_0.png", "run_1.png","run_2.png", "run_3.png","run_4.png","run_5.png",]
    @State var imageIndex: Int = 0
    // Use this string to guide the user on how to use the playground
    @State var guideText = "Keep pressed for one second to start running"
    @State var audioC2: AVAudioPlayer?

    
    var body: some View{
        VStack {
            ZStack{
                // Image of backgrouns, static behind th city that moves
                Image(uiImage: UIImage(named: "vesuvio.jpg")!)
                    .frame(width: 400, height: 600, alignment: .leading)
                
                HStack{
                    Image(uiImage: UIImage(named: "cityBack.png")!)
                        .frame(width: 400, height: 600, alignment: .leading)
                        .offset(x: tapCount ? -1014 : 0)
                }
                
                Text(guideText)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.top, 550)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black, radius: 2, x: -2, y: 2)
                    .animation(.none, value: guideText)
                
                // Story text
                Text("Every day he delivers thousands of pizzas")
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 400)
                    .padding(.horizontal, 5)
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: -3, y: 2)
                    .animation(.none, value: guideText)
                // Image of the character with an array used to animate it
                Image(uiImage: UIImage(named: imageNames[imageIndex])!)
                    .padding(.top, 480)
                    .offset(x: -180)
                    .scaleEffect(0.7)
                    .onReceive(timer, perform: { timer in
                    if (imageIndex < 5)&&(tapCount) {
                        imageIndex += 1
                    }
                    else {
                        imageIndex = 0
                    }})
                
                
            }
            
            
        }
        // Through the Long Press of the screnn you active the animation oof the Playground
        .onLongPressGesture(minimumDuration: 1, maximumDistance: 10, perform: {
            withAnimation(
                Animation.linear(duration: 5).repeatForever(autoreverses: false)){
                tapCount = true
                guideText = "Delivering pizzas..."
                
            }
        })
        .frame(width: 400, height: 600)
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter2", withExtension: "mp3"){
                do {
                    try audioC2 = AVAudioPlayer(contentsOf: audioURL)
                    audioC2?.numberOfLoops = .max
                    audioC2?.play()
                    audioC2?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
    }
}

PlaygroundPage.current.setLiveView(ContentView())

//: [Next](@next)
