//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

struct Legend: Identifiable {
    let legendName: String
    var selectedByPlayer = 0
    var P1Selected = false
    var P2Selected = false
    var P3Selected = false
    var selectionColor = Color.clear
    var id:String
    init (name: String) {
        self.legendName = name
        self.id = name
    }
    
    mutating func tap() {
        print("tapped \(legendName)")
        if selectedByPlayer < 3 {
            selectedByPlayer = selectedByPlayer + 1
        }
        else {
            selectedByPlayer = 0
        }
        switch selectedByPlayer {
        case 1:
            selectionColor = Color.green
        case 2:
            selectionColor = Color.blue
        case 3:
            selectionColor = Color.yellow
        default:
            selectionColor = Color.clear
        }
    }
}

let legendNames = [
    "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith", "Mirage"
]

struct LegendButton: View {
    var action: () -> ()
    var imageName: String
    var size: CGFloat
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(Color.blue)
                .frame(maxWidth: size, maxHeight: size)
        }
    }
    init(action: @escaping () -> Void, imageName: String, size: CGFloat = 50.0) {
        self.action = action
        self.imageName = imageName
        self.size = size
    }
}

struct LegendSelect: View {
    
    @State var legends:[Legend] = {
        var legendsCollection:[Legend] = []
        for i in legendNames {
            legendsCollection.append(Legend(name: i))
        }
        return legendsCollection
    }()
    
    let legendRowStartingPoints:[Int] = {
    var lRows:[Int] = []
        for i in 0...legendNames.count-1 {
            if i % 5 == 0 {
                lRows.append(i)
            }
        }
        print(lRows)
        return lRows
    }()
    
    @State var chosenLegend = " "
    @State var legendImage = "apexlogo"
    @State var legendPadding = 50.0
    
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
    // need to implement button action in view or better yet, button struct.
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //All Legends display/select
                VStack (alignment: .leading, spacing: 10.0) {
                    ForEach(legendRowStartingPoints, id: \.self) { row in
                        let last = (row + 5) < (legends.count) ? (row + 5):(legends.count)
                        let tail = legends.count - last
                        let shift: Edge.Set = row % 2 == 0 ? .trailing : .leading
                        HStack (spacing: 10.0) {
                            ForEach(legends.indices.dropFirst(row).dropLast(tail), id: \.self) { index in
                                LegendButton(action: {print("action")}, imageName: "Ash")
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
                //.padding(legendPadding)
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
        .background(Image("banner")
            .resizable()
            .scaledToFill()
        )
        .background(Color.gray.opacity(0.35).ignoresSafeArea())
    }
        
}

#Preview {
    LegendSelect()
}
