import SwiftUI
import PlaygroundSupport
import AVFoundation


struct ContentView: View {
    @State var animation = false
    @State var textOp = false
    @State var titleColor: [Color] = [.red , .green]
    @State var index = 0
    @State var audioC1: AVAudioPlayer?

    
    var body: some View {
        VStack {
            // Use a ZStack to create a Shimmer effect thanks to the
            // oveloading of two pieces of text and the use of an animate mask
            ZStack{
                // Main Title
                Text("Pizza's Ninja")
                    .padding(.top, 50)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(titleColor[index].opacity(0.50))
                
                // Text masked with a rotated rectangle moved by an animation
                // effect to create a Shimmer Effect
                Text("Pizza's Ninja")
                    .padding(.top, 50)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(titleColor[index])
                
                // Mask for the effect
                    .mask(
                        Rectangle()
                        //  Gradient used to create a better effect to see
                            .fill(
                                LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                            )
                        //  Rotataion of the rectangle
                            .rotationEffect(.init(degrees: 70))
                        //  Increment the padding to increment the dimensions
                        //  of the rotated rectangle
                            .padding(30)
                        // offset to set the starting point of the animation
                            .offset(x: -120)
                            .offset(x: animation ? 300 : -30)
                            .onAppear(perform: {
                                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false).delay(0)){
                                    animation.toggle()
                                }
                            })
                    )
                
                
            }
            Text("Once upon a time there was a food deliver that works for a pizzeria...")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 100)
                .padding(.top, 50)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .mask(
                    Rectangle()
                        .scaledToFit()
                        .scaleEffect(x: textOp ? 2 : 0, y: 1, anchor: .leading)
                )
            
        }
        .frame(width: 400, height: 600)
        .background(Color.black)
        // Use the tap to show the story text
        .onTapGesture(perform: { withAnimation(Animation.linear(duration: 2)){
            textOp = true
            // use this if statement to change view after the
            // text has been showed (write the code to change
            // chapter in the else)
            if index==0{
                index=1 // Change the color of the text
            }else{
                index=0
            }
        }})
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter1", withExtension: "mp3"){
                do {
                    try audioC1 = AVAudioPlayer(contentsOf: audioURL)
                    audioC1?.numberOfLoops = .max
                    audioC1?.play()
                    audioC1?.setVolume(0.5, fadeDuration: 0)
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
