//: [Previous](@Previous)


import SwiftUI
import PlaygroundSupport
import AVFoundation

struct CurrentView: View {
    // Array of images with the poses for the ninja
    @State var poseArray: [String] = ["downPose.png", "frontPose.png", "jumpPose.png"]
    @State var poseIndex = 0
    @State var audioC5: AVAudioPlayer?
    @State var audioC5_Teleport: AVAudioPlayer?
    
    
    // Variable used to better animate the character throug gestures
    @State var flip = false
    @State var jump = false
    
    var body: some View {

        VStack{
            ZStack{
                // BackGround image
                Image(uiImage: UIImage(named: "Dojo.jpg")!)
                
                // Array of poses changing through gestoures
                Image(uiImage: UIImage(named: poseArray[poseIndex])!)
                    .scaleEffect(0.4)
                    .padding(.top, jump ? -100 : 150)
                    .rotationEffect(flip ? .degrees(180) : .degrees(0), anchor: .center)
                    .rotation3DEffect(flip ? .degrees(180) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                
                Text("Use gestures to view the ninja's moves")
                    .padding(.top, 550)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 10)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: -3, y: 2)
                    .frame(width: 400)
                
                Text("So he begins to train himself to fight against the secret criminal organisation")
                    .padding(.bottom, 430)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .shadow(color: .white, radius: 2, x: -3, y: 2)
                    .frame(width: 400)
                
                
            }

        }// VStack
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter5", withExtension: "mp3"){
                do {
                    try audioC5 = AVAudioPlayer(contentsOf: audioURL)
                    audioC5?.numberOfLoops = .max
                    audioC5?.play()
                    audioC5?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
        .frame(width: 400, height: 600)
        // Drag gesture to make the ninja move throug swipe
        // We added also two extra conditions on each if statement to prevent wrong swipe recognization
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
            
            if let audioURL = Bundle.main.url(forResource: "Chapter5_teleport", withExtension: "mp3"){
                do {
                    try audioC5_Teleport = AVAudioPlayer(contentsOf: audioURL)
                    audioC5_Teleport?.numberOfLoops = 0
                    audioC5_Teleport?.play()
                    audioC5_Teleport?.setVolume(1, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
            
            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                poseIndex=1
                flip = false
                jump = false
            }
            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                poseIndex=1
                flip = true
                jump = false
            }
            else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                poseIndex=2
                jump = true
            }
            else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100{
                poseIndex=0
                jump = false
            }
            
        })
        )
        
    }
    
}


PlaygroundPage.current.setLiveView(CurrentView())

//: [Next](@next)
