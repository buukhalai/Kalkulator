//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Mamadaminova Buukhalai on 17/7/22.
//

import SwiftUI

struct CalculatorButton: View {
    @EnvironmentObject var calculator: Calculator
    var label: String
    var color: Color
    var body: some View {
        Button(action: {
            calculator.buttonPressed(label: label)
        }, label: {
            ZStack{
                Circle().fill(color)
                
                Text(label)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
        })
        .accentColor(.white)
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1", color: .gray)
            .previewLayout(.fixed(width: 100, height: 100))
            .environmentObject(Calculator())
    }
}
