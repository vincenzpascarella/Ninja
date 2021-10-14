//: [Previous](@previous)


import SwiftUI
import PlaygroundSupport
import AVFoundation



struct ContentView :View {
    @State var guideText = [" ... " ,
                            "We kidnapped you because we need your help.",
                            "A new minace comes  over the city, a group of mysterious ninjas invaded it and has implemented a plan to destroy all pizzerias ",
                            "They make pizza illegal and start : THE PIZZA-POCALYPSE ",
                            "If you decide to join us, you will be trained to become a ninja in our dojo"]
    @State var index=0
    @State var audioC4: AVAudioPlayer?
    @State var audioC4_change: AVAudioPlayer?
    
    var body: some View {
        
        VStack{
               
            ZStack{
                Image( uiImage: UIImage (named:"apocalypse.png" )! )
                
                HStack{
                    Text (guideText[index])
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    
                        .multilineTextAlignment(.center)
                        .shadow(color: .black, radius: 2, x: -3, y: 2)
                        .animation(.none, value: guideText)
                        .frame(width: 400)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .background(.ultraThinMaterial)
                        .padding(.top,450)
                        .animation(.easeIn(duration: 1.0), value: index)
                    
                    
                    
                }
            }
        }
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter4", withExtension: "mp3"){
                do {
                    try audioC4 = AVAudioPlayer(contentsOf: audioURL)
                    audioC4?.numberOfLoops = .max
                    audioC4?.play()
                    audioC4?.setVolume(2, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
        .frame(width: 400, height: 600)
        .onTapGesture(count: 1, perform: {
                if index<4 {
                    if let audioURL = Bundle.main.url(forResource: "Chapter4_change", withExtension: "mp3"){
                        do {
                            try audioC4_change = AVAudioPlayer(contentsOf: audioURL)
                            audioC4_change?.numberOfLoops = 0
                            audioC4_change?.play()
                            audioC4_change?.setVolume(0.7, fadeDuration: 0)
                        }catch{
                            print("Couldn't play audio. Error: \(error)")
                        }
                    }else{
                        print("No audio file found")
                    }
                    index += 1
                }
                else {
                    return
                }
                
            })
    }
}


PlaygroundPage.current.setLiveView(ContentView())

//: [Next](@next)
