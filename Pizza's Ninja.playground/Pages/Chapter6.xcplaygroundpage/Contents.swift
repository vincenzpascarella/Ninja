//: [Previous](@previous)


import SwiftUI
import PlaygroundSupport
import AVFoundation

struct ContentView: View{
    
    @State var shurPos = CGPoint(x: -100, y: -100)
    
    let timerRot = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var rotationAngle: Angle = .degrees(0)
    @State var shurVisible = false
    @State var hitCounter = 7
    @State var guideText = "Hit the enemy 7 times with your shurikens"
    
    @State var audioC6: AVAudioPlayer?
    @State var audioC6_Shur: AVAudioPlayer?

    
    var body: some View{
        
        VStack{
            ZStack{
                Image(uiImage: UIImage(named: "roof.png")!)
                
                Image(uiImage: UIImage(named: "cut_shuriken.png")!)
                    .scaleEffect(0.1)
                    .position(shurPos)
                    .opacity(shurVisible ? 1 : 0)
                    .onReceive(timerRot, perform: {
                        _ in rotationAngle += .degrees(30)
                        shurPos.x += 27
                        if (shurPos.x > 350)||(shurPos.y < 400)||(shurPos.y > 520)||(shurPos.x < 50){
                            shurVisible = false
                            if (shurPos.x < 380)&&(shurPos.x > 360)&&(shurPos.y > 400)&&(shurPos.y < 520){
                                hitCounter -= 1
                                if hitCounter < 1{
                                    guideText = "You have won the battle !"
                                }else{
                                    guideText = "Hit the enemy \(hitCounter) times with your shurikens"
                                }
                            }
                        }
                        else{
                            shurVisible = true
                        }
                    })
                    .rotationEffect(rotationAngle, anchor: UnitPoint(x: CGFloat(shurPos.x/400), y: CGFloat(shurPos.y/600))
                                )
                Image(uiImage: UIImage(named: "characters.png")!)

                Text(guideText)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 2)
                    .offset(y: 280)
                    .shadow(color: .black, radius: 2, x: -2, y: 2)
                
                Text("He finally fights the enemy boss... using his pizza-shurikens!!!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                    .padding(.horizontal, 2)
                    .offset(y: -200)
                    .shadow(color: .black, radius: 2, x: -2, y: 2)
                
            }//ZStack
            
        }//VStack
        .frame(width: 400, height: 600)
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onEnded { value in
                    if !shurVisible{
                        if let audioURL = Bundle.main.url(forResource: "Chapter6_shurEffect", withExtension: "mp3"){
                            do {
                                try audioC6_Shur = AVAudioPlayer(contentsOf: audioURL)
                                audioC6_Shur?.numberOfLoops = 0
                                audioC6_Shur?.play()
                                audioC6_Shur?.setVolume(2, fadeDuration: 0)
                            }catch{
                                print("Couldn't play audio. Error: \(error)")
                            }
                        }else{
                            print("No audio file found")
                        }
                    self.shurPos.y = value.location.y
                    self.shurPos.x = 50
                    }
                }
        )
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter6", withExtension: "mp3"){
                do {
                    try audioC6 = AVAudioPlayer(contentsOf: audioURL)
                    audioC6?.numberOfLoops = .max
                    audioC6?.play()
                    audioC6?.setVolume(0.5, fadeDuration: 0)
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
