//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

let legendNames = [
    "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith", "Mirage", "Ash"
]

struct LegendButton: View {
    let legendName:String
    let size: CGFloat
    var selector: selectionController
    @State var highlight = Color.clear
    @State var selectedByPlayer = 0
    
    func tap() {
        //highlight if not selected, deselect if already selected
        
        if selectedByPlayer == 0 /*&& selector.nextPlayer != 0  */{
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
    
    var body: some View {
        Button(action: tap) {
            Image(legendName)
                .resizable()
                .background(Color.gray)
                .frame(maxWidth: size, maxHeight: size)
                .border(highlight, width: 4)
        }
    }
    init(legendName: String, selector: selectionController, size: CGFloat = 50.0) {
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
    
    let legendRowStartingPoints:[Int] = {
        var lRows:[Int] = []
        for i in 0...legendNames.count-1 {
            if i % 5 == 0 {
                lRows.append(i)
            }
        }
        return lRows
    }()

    @State var chosenLegend = " "
    @State var legendImage = "apexlogo"
    @State var legendPadding = 50.0
    var selector = selectionController()
    
    func rollLegend() {
        if let rolled = legendNames.randomElement() {
            chosenLegend = rolled
            legendImage = rolled
            legendPadding = 0.0
            //selector.changeNextPlayer()
        }
        else {
            chosenLegend = " "
            legendImage = "apexlogo"
            legendPadding = 150.0
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Button creation and layout
                VStack (alignment: .leading) {
                    ForEach(legendRowStartingPoints, id: \.self) { row in
                        let last = (row + 5) < (legendNames.count) ? (row + 5):(legendNames.count)
                        let tail = legendNames.count - last
                        let shift: Edge.Set = row % 2 == 0 ? .trailing : .leading
                        HStack {
                            ForEach(legendNames.indices.dropFirst(row).dropLast(tail), id: \.self) { index in
                                LegendButton(legendName: legendNames[index], selector: selector, size:60)
                            }
                        }
                        .padding(shift)
                    }
                }
                .padding()
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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Image("banner")
                .resizable()
                .scaledToFill()
                        )
            .background(Color.gray.opacity(0.35).ignoresSafeArea())
        }
    }
}

#Preview {
    LegendSelect()
}
