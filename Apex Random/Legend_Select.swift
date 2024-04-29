//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

struct LegendButton: View {
    let legendNumber:Int
    var toggleLegend: (Int) -> Void
    let size: CGFloat
    var legendName: String
    @Binding var highlight: Color
    
    func tap() {
           toggleLegend(legendNumber)
    }
    var body: some View {
        Button(action: tap) {
            Image(legendName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: size, maxHeight: size, alignment: .bottom)
                .background(Color.gray.opacity(0.3))
                .clipped()
                .border(highlight, width: 5)
        }
    }
}

struct LegendSelect: View {
    
    let legendNames = [
        "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith", "Alter"
    ]
    let playerColors = [Color.clear, Color.yellow, Color.blue, Color.green]
    @State var rolledLegend = " "
    @State var rolledImage = "apexlogo"
    @State var nextPlayer = 1
    @State var buttonPlayerSelections: [Int]
    @State var buttonHighlights: [Color]
    
    func toggleLegend(legendNumber: Int) {
        
        //sets "selected by" status and highlight
        if buttonPlayerSelections[legendNumber] == 0 {
            buttonPlayerSelections[legendNumber] = nextPlayer
            buttonHighlights[legendNumber] = playerColors[nextPlayer]
        }
        else {
            buttonPlayerSelections[legendNumber] = 0
            buttonHighlights[legendNumber] = playerColors[0]
        }
        // sets next player
        if !buttonPlayerSelections.contains(1) {
            nextPlayer = 1
        }
        else if !buttonPlayerSelections.contains(2) {
            nextPlayer = 2
        }
        else if !buttonPlayerSelections.contains(3) {
            nextPlayer = 3
        }
        else {
            nextPlayer = 0
        }
    }

    func resetPlayer1() {
        if let index = buttonPlayerSelections.firstIndex(of: 1) {
            buttonHighlights[index] = playerColors[0]
            buttonPlayerSelections[index] = 0
            nextPlayer = 1
            rolledLegend = " "
            rolledImage = "apexlogo"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width)
                    .ignoresSafeArea()
                    .background(Color.gray.opacity(0.35))
                
                VStack {
                    // Button creation and layout
                    VStack (alignment: .leading) {
                        ForEach(Array(legendNames.enumerated()), id: \.offset) { index, name in
                            if index % 5 == 0 {
                                HStack {
                                    ForEach(Array(legendNames[index...].enumerated()), id: \.offset) { column, name in
                                        if column < 5 {
                                            let current = index + column
                                            LegendButton(legendNumber: (current), toggleLegend: toggleLegend, size: 60, legendName: name, highlight: $buttonHighlights[current])
                                        }
                                    }
                                }
                                .padding(index % 2 == 0 ? .trailing : .leading)
                            }
                        }
                    }

                    Spacer()
                    
                    Image(rolledImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width/3, maxHeight: geometry.size.width/3)
                    
                    Text(rolledLegend)
                        .font(.title)
                    
                    Button(action: {
                        let rolled = Int.random(in:0..<legendNames.count)
                        resetPlayer1()
                        toggleLegend(legendNumber: rolled)
                        rolledLegend = legendNames[rolled]
                        rolledImage = rolledLegend
                    }) {
                        Text("Generate Random Legend")
                            .font(.title3.bold())
                    }
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button(action: {
                        resetPlayer1()
                    }) {
                        Text("Reset P1")
                            .font(.title3.bold())
                    }
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
    init() {
        _buttonPlayerSelections = State(initialValue: Array(repeating: 0, count: legendNames.count))
        _buttonHighlights = State(initialValue: Array(repeating: Color.clear, count: legendNames.count))
    }
}

#Preview {
    LegendSelect()
}
