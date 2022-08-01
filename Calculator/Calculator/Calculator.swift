//
//  Calculator.swift
//  Calculator
//
//  Created by Mamadaminova Buukhalai on 17/7/22.
//

import Foundation

class Calculator: ObservableObject {
    
    @Published var displayValue  =  "0  "
    
    var currentOp: Operator?
    
    var currentNumber: Double? = 0
    
    var previousNumber: Double?
    
    var equaled = false
    
    var decimalPlace = 0
    
    func buttonPressed(label: String){
        if label == "CE"{
            displayValue  = "0"
            reset()
            
        }else if label == "="{
            equalClicked()
            
        }else if label == "."{
            decimalClicked()
            
        }else if let value  = Double(label){
            numberPressed(value: value)
        }else{
            operatorPressed(op: Operator(label))
        }
    }
    func setDisplayValue(number: Double) {
        if number == floor(number){
            displayValue = "\(Int(number))"
        }else{
           // let decimalPlaces = 10
            displayValue  = "\(round(number * pow(10, 10)) / pow(10, 10))"
        }
    }
    
    func reset(){
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
    }
    func checkForDivision() -> Bool{
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0){
            displayValue = "Error"
            reset()
            return true
        }
        return false
    }
    func equalClicked(){
        if currentOp != nil{
            decimalPlace = 0
            
            //quard for division by 0
            if checkForDivision(){return}
            
            // check if we have at least one operand
            if currentNumber != nil || previousNumber != nil {
                
                //COMPUTE THE TOTAL
                let total  = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // update first number
                if currentNumber == nil{
                    currentNumber = previousNumber
                }
                //update second number
                previousNumber = total
                
                //Set equaled operand
                equaled = true
                
                //Update the UI
                setDisplayValue(number: total)
            }
        }
        
    }
    
    func decimalClicked(){
        // if equaled was pressed, reset the current number
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled  = false
        }
             
        // if "." pressed first, set the current number
        if currentNumber == nil{
            currentNumber = 0
        }
        //Set the decimal place
        decimalPlace =  1
        //Update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    func numberPressed(value: Double){
        if equaled{
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        if currentNumber == nil{
            currentNumber = value / pow(10, Double(decimalPlace))
        }else{
            if decimalPlace == 0{
                currentNumber = currentNumber! * 10 + value
            }else{
                currentNumber = currentNumber! + value / pow(10, Double(decimalPlace))
                decimalPlace+=1
            }
        }
        
        setDisplayValue(number: currentNumber!)
    }
    
    func operatorPressed(op: Operator){
        decimalPlace = 0
        
        if equaled{
            currentNumber = nil
            equaled = false
        }
        // if we have two numbers, compute them
        if currentNumber != nil && previousNumber != nil {
            if checkForDivision(){return}
            let total = currentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            setDisplayValue(number: total)
        }
        // if only one number has been given, move it to secon operand
        else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        currentOp = op
    }
    
}
