//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Thomas Dobson on 7/6/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    let quotes = [
        "You are awesome!",
        "You are great!",
        "You are amazing!",
        "You are incredible!",
        "You are Outstanding!",
        "Believe in yourself!",
        "You can achieve anything!",
        "Stay positive and strong!",
        "Your potential is limitless!",
        "Keep pushing forward!",
        "Success is within reach!",
        "Embrace the journey!",
        "You are capable of greatness!",
        "Never give up!",
        "You make a difference!",
        "Dream big and dare to fail!",
        "Your efforts matter!",
        "Stay focused and determined!",
        "You are a star!",
        "Shine bright and inspire!"
    ]
    
    @State private var quoteNumber: Int
    @State private var imageNumber: Int
    @State private var soundNumber: Int
    @State private var soundIsOn = true
    @State private var audioPlayer: AVAudioPlayer!
    
    init() {
        _quoteNumber = State(initialValue: Int.random(in: 0..<quotes.count))
        _imageNumber = State(initialValue: Int.random(in: 0...9))
        _soundNumber = State(initialValue: Int.random(in: 0...5))
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .fill(
                        Gradient(colors: [Color("Tan"), Color("Vermillion")])
                    )
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(quotes[quoteNumber])
                        .font(.title)
                        .padding(1)
                        .fontWeight(.heavy)
                        .foregroundColor(.indigo)
                        .italic()
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .background(Color("SkyBlue"))
                        .cornerRadius(30)
                        .padding()
                        .animation(.easeInOut(duration: 0.15), value: imageNumber)
                    
                    Image("image\(imageNumber)")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(30)
                        .shadow(radius: 30)
                        .padding()
                        .animation(.easeInOut(duration: 0.7), value: imageNumber)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.indigo)
                        .frame(width: geometry.size.width * (2/5), height: 2)
                        .cornerRadius(30)
                    
                    HStack {
                        Text("Sound On:")
                        Toggle("", isOn: $soundIsOn)
                            .labelsHidden()
                            .onChange(of: soundIsOn) {
                                (audioPlayer != nil && audioPlayer.isPlaying) ? audioPlayer.stop() : nil
                            }
                        
                        Spacer()
                        
                        Button("Press Me") {
                            quoteNumber = generateNewRandomNumber(
                                lowerBounds: 0,
                                UpperBounds: quotes.count-1,
                                currentNumber: quoteNumber
                            )
                            
                            imageNumber = generateNewRandomNumber(
                                lowerBounds: 0,
                                UpperBounds: 9,
                                currentNumber: imageNumber
                            )
                            
                            let soundNumber = generateNewRandomNumber(
                                lowerBounds: 0,
                                UpperBounds: 5,
                                currentNumber: soundNumber
                            )
                            soundIsOn ? playSound(sound: "sound\(soundNumber)") : nil
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .tint(.accentColor)
                }
            }
        }
    }

    
    func generateNewRandomNumber(lowerBounds: Int, UpperBounds: Int, currentNumber: Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: lowerBounds...UpperBounds)
        } while newNumber ==  currentNumber
        return newNumber
    }
    
    func playSound(sound: String) {
        guard let soundFile = NSDataAsset(name: sound) else {
            print("Could not read file named: \(sound)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView()
}
