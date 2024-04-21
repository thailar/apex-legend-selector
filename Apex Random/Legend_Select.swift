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
        chosenLegend = legends.randomElement() ?? ""
        if !chosenLegend.isEmpty {
            legendImage = chosenLegend
            legendPadding = 0
        }
        else
        {
            legendImage = "apexlogo"
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
