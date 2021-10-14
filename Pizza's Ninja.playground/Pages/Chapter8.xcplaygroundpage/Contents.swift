//: [Previous](@previous)


import SwiftUI
import PlaygroundSupport
import AVFoundation

struct ContentView : View {
    @State var temp = 1
    @State var tapped = false
    @State var animation = true
    @State var TextUp =  "Click the button to save the world "
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State var opacitaBack : Double = 0
    @State var opacitaButton : Double = 100
    @State var audioC8: AVAudioPlayer?

    
    
    var body : some View{
        VStack {
            
            ZStack{
                
                Image(uiImage: UIImage(named: "final-photo.png")!)
                    .opacity(opacitaBack)
                    .scaleEffect(1)
                
                Text(" PIZZA IS SAFE  ")
                    .opacity(opacitaBack)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.bottom, 335)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .shadow(color: .white, radius: 2, x: -2, y: 2)
                
                Text(" PIZZA IS SAFE  ")
                    .opacity(opacitaBack)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.bottom, 335)
                    .multilineTextAlignment(.center)
                    .shadow(color: .red, radius: 2, x: -2, y: 2)
                    .mask (
                      Rectangle()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.red.opacity(0.5), Color.red, Color.red.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
                      
                        .rotationEffect(.init(degrees: 30))
                        .padding(1)
                        .offset(x: -120)
                        .offset(x: animation ? 400 : -100)
                        .onAppear(perform: {
                            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)){
                                animation.toggle()
                            }
                        })
                    )
                
                    
                
                Image(uiImage: UIImage(named: "\(temp).png")!)
                    .opacity(opacitaButton)
                    .frame(width: 400, height: 600, alignment: .leading)
                    .scaleEffect(0.5)
                    .onReceive(timer, perform: { _ in
                        if tapped {
                            opacitaBack = 100
                            opacitaButton = 0
                        }
                        if temp < 8 && !tapped {temp += 1}
                        else if temp == 8 {temp=1}
                        
                    })
                
                Text(TextUp)
                    .opacity(opacitaButton)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding(.top, 550)
                    .padding(.horizontal, 5)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .shadow(color: .green, radius: 2, x: -2, y: 2)
                    .animation(.easeInOut(duration: 4.0), value: TextUp)
             
            } //ZStack
        } //vStack
        .frame(width: 400, height: 600)
        .background(LinearGradient(gradient: Gradient(colors: [.red.opacity(0.2), .white,.white, .white , .green.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .onTapGesture(count :  1, perform : {
            tapped = true
            if let audioURL = Bundle.main.url(forResource: "Chapter8", withExtension: "m4a"){
                do {
                    try audioC8 = AVAudioPlayer(contentsOf: audioURL)
                    audioC8?.numberOfLoops = .max
                    audioC8?.play()
                    audioC8?.setVolume(0.5, fadeDuration: 0)
                }catch{
                    print("Couldn't play audio. Error: \(error)")
                }
            }else{
                print("No audio file found")
            }
        })
    }//body
} //ContentView

PlaygroundPage.current.setLiveView(ContentView())
