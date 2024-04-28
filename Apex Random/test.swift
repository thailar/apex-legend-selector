//
//  test.swift
//  Apex Random
//
//  Created by Tyler Gibbons on 4/23/24.
//

import SwiftUI

let array = {
    var test:[Int] = []
    for i in 1...10 {
        test.append(i)
    }
    return test
}()

let fiveLegends = {
    array.filter{
        ![6,8,9,10].contains($0)
    }
}()

struct Test: View {
    var body: some View {
        ForEach(Array(fiveLegends.enumerated()), id: \.element){ index, name in
            Text("\(name)")
        }
    }
}

#Preview {
    Test()
}

