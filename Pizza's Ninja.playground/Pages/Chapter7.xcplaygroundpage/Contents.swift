//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import AVFoundation

struct ContentView: View {
    @State var animation = false
    @State var poseArray: [String] = ["twerkPose.png", "winPose.png"]
    @State var indexPose = 0
    @State var tapCounter = 0
    @State var storyText = "Unlocking Pizza Power"
    @State var audioC7: AVAudioPlayer?
    @State var audioC7_power: AVAudioPlayer?

    
    
    var body: some View {
        VStack{
            ZStack{
                // This image is masked in order to unlock a part of the power at each tap
                Image(uiImage: UIImage(named: "pizzaBack.png")!)
                    .padding(.top, 120)
                    .mask(
                        Rectangle()
                            .padding(.top, CGFloat((620 - (tapCounter * 38)))
                                    )
                    )
                
                HStack{
                    
                    // In this ZStack we write the main text with the shimmer effect
                    ZStack{
                        
                        Text(storyText)
                            .padding(.bottom, indexPose==1 ? 410 : 530)
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text(storyText)
                            .padding(.bottom, indexPose==1 ? 410 : 530)
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)

                            .mask(
                                Rectangle()
                                //  Gradient used to create a better effect to see
                                    .fill(
                                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.5),Color.white,Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                                    )
                                //  Rotataion of the rectangle
                                    .rotationEffect(.init(degrees: 70))
                                //  Increment the padding to increment the dimensions thanks to the up and down of the mask
                                    .padding(.bottom, 450)
                                // offset to set the starting point of the animation
                                    .offset(x: -160)
                                    .offset(x: animation ? 400 : -150)
                                    .onAppear(perform: {
                                        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false).delay(0)){
                                            animation.toggle()
                                        }
                                    }))
                    }//Zstack power
                }//HStack power
                .frame(width: 400)
                
                Image(uiImage: UIImage(named: poseArray[indexPose])!)
                    .scaleEffect(0.3)
                    .padding(.trailing, 180)
                    .padding(.top, 250)
                
                Text(indexPose==1 ? "Power unlocked !" : "Tap \(10-tapCounter) times to unlock the power")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .padding(.top, 550)
                    .foregroundColor(.black.opacity(0.7))
                    .shadow(color: .white, radius: 2, x: -2, y: 2)
                
            }//ZStack pizza
            
            
        }//Vstack
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter7", withExtension: "mp3"){
                do {
                    try audioC7 = AVAudioPlayer(contentsOf: audioURL)
                    audioC7?.numberOfLoops = .max
                    audioC7?.play()
                    audioC7?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
        .frame(width: 400, height: 600)
        .background(
            LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.2), .white, .white, .green.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading)
)
        // Tap Gesture to change pose and storyText
        .onTapGesture {
            if let audioURL = Bundle.main.url(forResource: "Chapter7_power", withExtension: "mp3"){
                do {
                    try audioC7_power = AVAudioPlayer(contentsOf: audioURL)
                    audioC7_power?.numberOfLoops = 0
                    audioC7_power?.play()
                    audioC7_power?.setVolume(1, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
            tapCounter += 1
            if tapCounter>9{
                indexPose=1
                storyText = "Until finally he unlocks the ninja pizza's power in order to defeat the enemy"
                if let audioURL = Bundle.main.url(forResource: "Chapter7_finale", withExtension: "mp3"){
                    do {
                        try audioC7 = AVAudioPlayer(contentsOf: audioURL)
                        audioC7?.numberOfLoops = .max
                        audioC7?.play()
                        audioC7?.setVolume(0.5, fadeDuration: 0)
                    }catch{
                        print("Couldn't play audio. Error: \(error)")
                    }
                }else{
                    print("No audio file found")
                }
            }
        }
    }
}
PlaygroundPage.current.setLiveView(ContentView())

//: [Next](@next)
