//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

let legendNames = [
    "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith", "Alter"
]

struct LegendButton: View {
    let legendName: String
    let size: CGFloat
    @Binding var nextPlayer: Int
    @Binding var playerSelected: [Bool]
    
    @State var highlight = Color.clear
    @State var selectedByPlayer = 0
    
    func changeNextPlayer() {
        switch selectedByPlayer {
        case 1: playerSelected[0].toggle()
        case 2: playerSelected[1].toggle()
        case 3: playerSelected[2].toggle()
        default: return
        }
        
        if !playerSelected[0] {
            nextPlayer = 1
        }
        else if !playerSelected[1] {
            nextPlayer = 2
        }
        else if !playerSelected[2] {
            nextPlayer = 3
        }
        else {
            nextPlayer = 0
        }
    }
    
    func tap() {
        //highlights if not selected, deselect if already selected
        if selectedByPlayer == 0 {
            selectedByPlayer = nextPlayer
            changeNextPlayer()
        }
        else {
            changeNextPlayer()
            selectedByPlayer = 0
        }
        switch selectedByPlayer {
            case 1: highlight = Color.yellow
            case 2: highlight = Color.blue
            case 3: highlight = Color.green
            default: highlight = Color.clear
        }
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

    @State var chosenLegend = " "
    @State var legendImage = " "
    @State var legendPadding = 50.0
    @State var playerSelected = [false, false, false]
    @State var nextPlayer = 1
    
    func rollLegend() {
        if let rolled = legendNames.randomElement() {
            chosenLegend = rolled
        }
        else {
            chosenLegend = " "
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
                        ForEach(Array(legendNames.enumerated()), id: \.element) { index, name in
                            if index % 5 == 0 {
                                HStack {
                                    ForEach(Array(legendNames[index...].enumerated()), id: \.element) { column, name in
                                        if column < 5 {
                                            LegendButton(legendName: name, size:60, nextPlayer: $nextPlayer, playerSelected: $playerSelected)
                                        }
                                    }
                                }
                                .padding(index % 2 == 0 ? .trailing : .leading)
                            }
                        }
                    }

                    Spacer()
                    Image(legendImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width/3, maxHeight: geometry.size.width/3)
                    Text(chosenLegend)
                        .font(.title)
                    Button(action: {
                        if let rolled = legendNames.randomElement() {
                            chosenLegend = rolled
                            legendImage = chosenLegend
                        }
                    }) {
                        Text("Generate Random Legend")
                            .font(.title3.bold())
                    }
                    .padding()
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                    Button(action: {
                        chosenLegend = " "
                        legendImage = "apexlogo"
                    }) {
                        Text("Clear Selection")
                            .font(.title3.bold())
                    }
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    LegendSelect()
}
