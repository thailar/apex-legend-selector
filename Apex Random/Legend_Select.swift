//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI
// add button photos back and mask images inside
struct Legend: Identifiable {
    let legendName: String
    var selectedByPlayer = 0
    var selectionColor = Color.clear
    var id:String
    
    mutating func tap() {
        selectedByPlayer += 1
        print("tapped \(legendName), selection moved to \(selectedByPlayer)")
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
    
    init (name: String) {
        self.legendName = name
        self.id = name
    }
}

let legendNames = [
    "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith", "Mirage"
]

struct LegendButton: View {
    let legend:Legend
    let imageName: String
    let size: CGFloat
    @State var highlight = Color.clear
    @State var selectedByPlayer = 0
    
    func tap() {
        selectedByPlayer = (selectedByPlayer + 1) % 4
        switch selectedByPlayer {
            case 1: highlight = Color.yellow
            case 2: highlight = Color.blue
            case 3: highlight = Color.green
            default: highlight = Color.clear
        }
    }
    
    var body: some View {
        Button(action: tap) {
            ZStack {
                Image(imageName)
                    .resizable()
                    .background(Color.gray)
                    .frame(maxWidth: size, maxHeight: size)
                    .border(highlight, width: 3.5)
            }
        }
    }
    init(legend: Legend, size: CGFloat = 50.0) {
        self.legend = legend
        self.size = size
        self.imageName = legend.legendName
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

    var body: some View {
        GeometryReader { geometry in
            VStack {
                //All Legends display/select
                VStack (alignment: .leading) {
                    ForEach(legendRowStartingPoints, id: \.self) { row in
                        let last = (row + 5) < (legends.count) ? (row + 5):(legends.count)
                        let tail = legends.count - last
                        let shift: Edge.Set = row % 2 == 0 ? .trailing : .leading
                        HStack {
                            ForEach(legends.indices.dropFirst(row).dropLast(tail), id: \.self) { index in
                                LegendButton(legend: legends[index], size:60)
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
                    .frame(maxWidth: geometry.size.width/2, maxHeight: geometry.size.width/2)
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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        /*.background(Image("banner")
            .resizable()
            .scaledToFill()
        )
        .background(Color.gray.opacity(0.35).ignoresSafeArea())*/
    }
}

#Preview {
    LegendSelect()
}
