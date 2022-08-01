//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Mamadaminova Buukhalai on 17/7/22.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}
