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
    let legendName:String
    let size: CGFloat
    var selector: selectionController
    @State var highlight = Color.clear
    @State var selectedByPlayer = 0
    
    func tap() {
        //highlight if not selected, deselect if already selected
        
        if selectedByPlayer == 0 {
            selectedByPlayer = selector.nextPlayer
            selector.changeNextPlayer(toggledPlayer: selectedByPlayer)
        }
        else {
            selector.changeNextPlayer(toggledPlayer: selectedByPlayer)
            selectedByPlayer = 0
        }
        switch selectedByPlayer {
            case 1: highlight = Color.yellow
            case 2: highlight = Color.blue
            case 3: highlight = Color.green
            default: highlight = Color.clear
        }
    }
    // make color array for background button colors?
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
    init(legendName: String, selector: selectionController, size: CGFloat) {
        self.size = size
        self.legendName = legendName
        self.selector = selector
    }
}

class selectionController {
    var p1Selected = false
    var p2Selected = false
    var p3Selected = false
    var nextPlayer = 1
    
    func changeNextPlayer(toggledPlayer:Int) {
        
        switch toggledPlayer {
        case 1: p1Selected.toggle()
        case 2: p2Selected.toggle()
        case 3: p3Selected.toggle()
        default: return
        }
        
        if !p1Selected {
            nextPlayer = 1
        }
        else if !p2Selected {
            nextPlayer = 2
        }
        else if !p3Selected {
            nextPlayer = 3
        }
        else {
            nextPlayer = 0
        }
    }
}

struct LegendSelect: View {

    @State var chosenLegend = " "
    @State var legendImage = "apexlogo"
    @State var legendPadding = 50.0
    var shiftRowLeft = false
    var shift:Edge.Set { shiftRowLeft ? .trailing : .leading }
    var selector = selectionController()
    
    func rollLegend() {
        if let rolled = legendNames.randomElement() {
            chosenLegend = rolled
            legendImage = rolled
            legendPadding = 0.0
        }
        else {
            chosenLegend = " "
            legendImage = "apexlogo"
            legendPadding = 150.0
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
                                            LegendButton(legendName: name, selector: selector, size:60)
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
                        rollLegend()
                    }) {
                        Text("Generate Random Legend")
                            .font(.title3.bold())
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding()
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
