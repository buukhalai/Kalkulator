//
//  CalculatorRow.swift
//  Calculator
//
//  Created by Mamadaminova Buukhalai on 17/7/22.
//

import SwiftUI

let columnCount = 4

struct CalculatorRow: View {
    var labels = ["", "", "", ""]
    var colors: [Color] = [.gray, .gray, .gray, .orange]
    var body: some View {
        HStack(spacing: 10){
            ForEach(0..<columnCount){index in
                CalculatorButton(label: labels[index], color: colors[index])
            }
        }
    }
}

struct CalculatorRow_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorRow(labels: ["1", "2", "3", "+"]).previewLayout(.fixed(width: 300, height: 100))
    }
}
