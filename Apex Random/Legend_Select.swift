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

var legendNames = [
    "Ash", "Ballistic", "Bangalore", "Bloodhound", "Catalyst", "Caustic", "Conduit", "Crypto", "Fuse", "Gibraltar", "Horizon", "Lifeline", "Loba", "Mad Maggie", "Mirage", "Newcastle", "Octane", "Pathfinder", "Rampart", "Revenant", "Seer", "Valkyrie", "Vantage", "Wattson", "Wraith"
]

struct Legend_Select: View {
    @State var legends:[Legend] = {
        var legendsCollection:[Legend] = []
        for i in legendNames {
            legendsCollection.append(Legend(name: i))
        }
        return legendsCollection
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
    
    func buildLegendsRow(first: Int) -> some View {
        return HStack {
            ForEach(first...first+4, id: \.self) { legend in
                Button(action: {
                    legends[legend].tap()
                }) {
                    Image(legends[legend].legendName)
                        .resizable()
                }
                .scaledToFit()
                .background(Rectangle().fill(Color.gray))
                .background(Rectangle().stroke(lineWidth: 10).fill(legends[legend].selectionColor))
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    //All Legends display/select
                    /*ForEach(legends) { legend in
                        /*@START_MENU_TOKEN@*/Text(legend.legendName)/*@END_MENU_TOKEN@*/
                    }*/     // Pick up here now that Legends are Identifiable
                    buildLegendsRow(first: 0).padding(.trailing)
                    buildLegendsRow(first: 5).padding(.leading)
                    buildLegendsRow(first: 10).padding(.trailing)
                    buildLegendsRow(first: 15).padding(.leading)
                    buildLegendsRow(first: 20).padding(.trailing)
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
        }
        .background(Image("banner")
            .resizable()
            .scaledToFill()
        )
        .background(Color.gray.opacity(0.35))
    }
        
}

#Preview {
    Legend_Select()
}
