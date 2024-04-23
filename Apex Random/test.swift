//
//  test.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/23/24.
//

import SwiftUI

struct test: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 25, height: 25) // Align circle to the trailing edge
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    test()
}
