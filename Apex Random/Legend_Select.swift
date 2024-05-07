//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

struct LegendButton: View {
    let legendNumber:Int
    let toggleLegend: (Int, Bool) -> Void
    let size: CGFloat
    var legendName: String
    @Binding var highlight: Color
    
    func tap() {
        toggleLegend(legendNumber, false)
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
    let playerColors = [Color.yellow, Color.blue, Color.green]
    @State var nextPlayer = 1
    @State var buttonHighlights: [Color]
    @State var playerSelections: [Int] = [-1,-1,-1]
    
    // Add hidden and optional "allowP1Set" paramet that defaults to false to allow random button to set p1
    func toggleLegend(legendNumber: Int, allowP1Set: Bool = false) {
        if let alreadySelected = playerSelections.firstIndex(of: legendNumber) {
            playerSelections[alreadySelected] = -1
            buttonHighlights[legendNumber] = Color.clear
        } else {
            if playerSelections[0] == -1 && allowP1Set {
                playerSelections[0] = legendNumber
                buttonHighlights[legendNumber] = playerColors[0]
            } else if playerSelections[1] == -1 {
                playerSelections[1] = legendNumber
                buttonHighlights[legendNumber] = playerColors[1]
            } else if playerSelections[2] == -1 {
                playerSelections[2] = legendNumber
                buttonHighlights[legendNumber] = playerColors[2]
            }
        }
    }
    /*func toggleLegend(legendNumber: Int, allowP1Set: Bool = false) {
        
    }*/

    func resetPlayer(_ player:Int) {
        if playerSelections[player] != -1 {
            buttonHighlights[playerSelections[player]] = Color.clear
            playerSelections[player] = -1
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
                    
                    Image({
                        playerSelections[0] == -1 ? "apexlogo" : legendNames[playerSelections[0]]
                    }())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width/3, maxHeight: geometry.size.width/3)
                    
                    Text({
                            playerSelections[0] == -1 ? " " : legendNames[playerSelections[0]]
                        }())
                        .font(.title)

                    Button(action: {
                        var rolled = Int.random(in:0..<legendNames.count)
                        while playerSelections.contains(rolled) {
                            rolled = Int.random(in:0..<legendNames.count)
                        }
                        resetPlayer(0)
                        toggleLegend(legendNumber: rolled, allowP1Set: true)
                    }) {
                        Text(" Random ")
                            .font(.title3.bold())
                    }
                    .padding(14)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom)
                    
                    Button(action: {
                        resetPlayer(0)
                        resetPlayer(1)
                        resetPlayer(2)
                    }) {
                        Text("Clear Selections")
                            .font(.title3.bold())
                    }
                    .padding(5)
                    .background(Color.teal.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
    init() {
        _buttonHighlights = State(initialValue: Array(repeating: Color.clear, count: legendNames.count))
    }
}

#Preview {
    LegendSelect()
}
