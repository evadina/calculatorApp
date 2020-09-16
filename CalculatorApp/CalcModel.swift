//
//  CalcModel.swift
//  CalculatorApp
//
//  Created by Madina Tazhiyeva on 9/15/20.
//  Copyright © 2020 Madina Tazhiyeva. All rights reserved.
//

import Foundation

enum Operations{
    case constant(Double)
    case unaryOperation((Double)->Double)
    case binaryOperation((Double, Double)->Double)
    case equals
    case clear
    case negative
}


func concat(op1: Double, op2: Double)-> Double{
    let op1string = String(op1)
    let op2string = String(op2)
    let fullNumberWithDotInString = op1string + "." + op2string
    let fullNumberWithDotInDouble = Double(fullNumberWithDotInString)
    return fullNumberWithDotInDouble!
}


struct CalculatorModel{
    
    var my_operations: Dictionary<String,Operations> =
        [
            "+/-":  Operations.negative,
            "+":    Operations.binaryOperation({$0+$1}),
            "-":    Operations.binaryOperation({$0-$1}),
            "×":    Operations.binaryOperation({$0*$1}),
            "÷":    Operations.binaryOperation({$0/$1}),
            ".":    Operations.binaryOperation(concat),
            "=":    Operations.equals,
            "C":    Operations.clear,
    ]
    
    private var global_value: Double?
    
    mutating func setOperand(_ operand: Double){
        global_value = operand
    }
    
    
    mutating func performOPeration(_ operation: String){
        let symbol = my_operations[operation]!
        switch symbol{
            
        case .constant(let value):
            global_value = value
            
        case .unaryOperation(let function):
            global_value = function(global_value!)
            
        case .binaryOperation(let function):
            saving = SaveFirstOperandAndOperation(firstOperand: global_value!, operation: function)
            
        case .equals:
            if global_value != nil {
                global_value = saving?.performOperationWith(secondOperand: global_value!)
            }
        case .clear:
            global_value = 0
            
        case .negative:
            global_value = global_value!*(-1)
            
      //  case .concat:
      //      global_value = global_value! +
        }
    }
    
    func doubleChecker()->Bool{
        
        return true
    }
    
    
    
    var result: Double? {
        get{
            return global_value
        }
    }
    
    private var saving: SaveFirstOperandAndOperation?
    
    struct SaveFirstOperandAndOperation{
        var firstOperand: Double
        var operation: (Double, Double)-> Double
        
        
        func performOperationWith(secondOperand op2: Double)-> Double{
            return operation(firstOperand,op2)
            
        }
    }
    
    
    
    
}
