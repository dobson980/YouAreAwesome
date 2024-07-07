//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Thomas Dobson on 7/6/24.
//

import SwiftUI

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
    @State private var inspiration: String
    
    init() {
        _inspiration = State(initialValue: quotes.randomElement() ?? "You are awesome!")
    }
    
    var body: some View {
        
        VStack {
            Text(inspiration)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.indigo)
                .italic()
                .padding()
            
            Button("Press Me") {
                inspiration = getRandomQuote(excluding: inspiration)
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func getRandomQuote(excluding currentQuote: String) -> String {
        var newQuote: String
        repeat {
            newQuote = quotes.randomElement() ?? "You are Awesome!"
        } while newQuote == currentQuote
        return newQuote
    }
}



#Preview {
    ContentView()
}
