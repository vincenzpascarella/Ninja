//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport
import AVFoundation


struct ContentView: View {
//    @State var tapCount = 0
    @State var tapped = false
    @State var actionText = "Press to deliver the last pizza"
    @State var temp = 0
    @State var photoName = "backNoNinja.png"
    @State var ninjaText = ""
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    @State var audioC3: AVAudioPlayer?

    
    
var body : some View{
       
        VStack{
            
            ZStack{
                Image(uiImage: UIImage(named: "vesuvio.jpg")!)
                    .frame(width: 400, height: 600, alignment: .leading)
                
                Image(uiImage: UIImage(named: photoName)!)
                    .frame(width: 400, height: 600, alignment: .leading)
               
                Text(actionText)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.top, 550)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black, radius: 2, x: -2, y: 2)
                    .animation(.none, value: actionText)
                
                Text(ninjaText)
                    .frame(width: 380, height: 600, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 470)
                    .padding(.horizontal, 5)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: -3, y: 2)
                    .animation(.none, value: ninjaText)
                
                HStack{
                    
                    
                    Image(uiImage: UIImage(named: "\(temp)")!)
                    .scaleEffect(2)
                    .onReceive(timer, perform: { _ in
                        if temp == 19 {
                            photoName = "backWithNinja.png"
                            ninjaText = "A group of ninjas appear from the shadows and kidnap the pizza-deliver"
                        }
                        if temp < 35 && tapped {temp += 1}
                        else if temp == 35 {return}
                    })
                    
                } //HStack
        
            } //Zstack
            
        } //VSTack
        .frame(width: 400, height: 600)
        .onTapGesture(count :  1, perform : {
            actionText = "Uhm, wait..."
            tapped = true
            if let audioURL = Bundle.main.url(forResource: "Chapter3_kidnap", withExtension: "mp3"){
                do {
                    try audioC3 = AVAudioPlayer(contentsOf: audioURL)
                    audioC3?.numberOfLoops = .max
                    audioC3?.play()
                    audioC3?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
            
        })
        .onAppear(perform: {
            if let audioURL = Bundle.main.url(forResource: "Chapter3", withExtension: "mp3"){
                do {
                    try audioC3 = AVAudioPlayer(contentsOf: audioURL)
                    audioC3?.numberOfLoops = .max
                    audioC3?.play()
                    audioC3?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
    

} //body
} //ContentView

PlaygroundPage.current.setLiveView(ContentView())

//: [Next](@next)

