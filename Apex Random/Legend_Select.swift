//
//  Legend_Select.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/19/24.
//

import SwiftUI

struct Legend_Select: View {
    
    @State var chosenLegend = " "
    @State var legendImage = "apexlogo"
    @State var legendPadding = 50.0
    @State var ashSelected = false
    @State var ashColor = Color.clear // need to set array for these, rename to P1color and create func to pass in the legends in the buttons
    
    var legends:[String] = [
        "Ash", "Ballistic", "Bangalore", "Bloodhound",
        "Catalyst", "Caustic", "Conduit", "Crypto",
        "Fuse", "Gibraltar", "Horizon", "Lifeline",
        "Loba", "Mad Maggie", "Mirage", "Newcastle",
        "Octane", "Pathfinder", "Rampart", "Revenant",
        "Seer", "Valkyrie", "Vantage", "Wattson",
        "Wraith"
    ]
    
    func rollLegend() {
        if let rolled = legends.randomElement() {
            chosenLegend = rolled
            legendImage = rolled
            legendPadding = 0.0
        }
        else {
            chosenLegend = " "
            legendImage = "apexlogo"
            legendPadding = 50.0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                    .clipped()
                VStack {
                    //All Legends display/select
                    HStack {
                        Button(action: {
                            ashSelected.toggle()
                            if ashSelected {
                                ashColor = Color.green
                            }
                            else {
                                ashColor = Color.clear
                            }
                        }) {
                            Image("Ash")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width/5)
                        }
                        .background(Rectangle().fill(Color.gray))
                        .background(Rectangle().stroke(lineWidth: 10).fill(ashColor))
                    }
                    HStack {
                        
                    }
                    Image(legendImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                        .padding(legendPadding)
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
    Legend_Select()
}
