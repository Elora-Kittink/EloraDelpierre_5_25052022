//
//  Calculator.swift
//  P5 - CountOnMe
//
//  Created by Elora on 25/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

public class Calculation {
    
    public weak var delegate: CalculationDelegate?
    
    // tableau des éléments de la ligne décomposée
    var elements: [String] = [] {
        didSet {
            print(elements)
            delegate?.updateScreen(result: stringElements)
        }
    }
    private var stringElements: String {
        "\(elements.joined()) "
    }
    
    // on doit split avant et après chaque opérateur
    
    public func addNumber(element: String) {
        if expressionHaveResult() {
            elements = []
        }
        if let firstNumber = elements.last,
           addNumberAfterNumber(lastElement: firstNumber) {
            
            let secondNumber = element
            elements[elements.count - 1] = ("\(firstNumber)\(secondNumber)")
        } else {
            if elements.last == "0" {
                return
            }
            elements.append(element)
        }
    }
    
    public func addOperator(element: String) {
        guard expressionDontEndWhithOperator()
            && !elements.isEmpty
                && !expressionHaveResult() else { return }
            elements.append(element)
    }
    
    
    
    public func addComma(element: String) {
        
        if expressionDontEndWhithOperator()
            && !expressionHaveResult()
            && expressionDontEndWithComma()
            && !elements.isEmpty {
            guard let lastElement = elements.last else { return }
            elements[elements.count - 1] = "\(lastElement)\(element)"
        }
    }
    
    public func cleanTextView() {
        elements = []
    }
    
   private func calculLoop() -> [String] {
        var copyElements = elements
        while copyElements.count >= 3 {
            let result: Double
            if let left = Double(copyElements[0]), let right = Double(copyElements[2]) {
                let operand = copyElements[1]
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "X": result = left * right
                case "/": result = left / right
                default: return []
                }
                copyElements = Array(copyElements.dropFirst(3))
                copyElements.insert("\(result)", at: 0)
            }
        }
        return copyElements
    }
    
    public func calculation() {
       if divideByZero() {
            elements = ["erreur"]
            delegate?.showError()
        }
            if expressionDontEndWhithOperator() && expressionHaveEnoughElement() {
                var copyElements = calculLoop()
                elements.append("=")
                if String(copyElements[0].suffix(2)) == ".0" {
                    copyElements[0] = String(copyElements[0].dropLast(2))
                }
                elements.append(copyElements[0])
            } else {
                elements = ["erreur"]
                delegate?.showError()
            }
    }
    
    private func expressionDontEndWithComma() -> Bool {
        elements.last != "."
    }
    
    private func expressionDontEndWhithOperator() -> Bool {
        elements.last != "+" && elements.last != "-" && elements.last != "X"
        && elements.last != "/"
    }
    
    private func expressionHaveEnoughElement() -> Bool {
        elements.count >= 3
    }
    // ajouter le mot erreur pour remettre a blanc après une erreur
     func expressionHaveResult() -> Bool {
        elements.contains("=") || elements.contains("erreur")
    }
// je veux que ça retourne true si on peut concaténer, et on peut concaténer si le lastElement est différent de + - X / 
     func addNumberAfterNumber(lastElement: String) -> Bool {
        let array: [String] = ["-", "+", "X", "/", "0"]
        return !array.contains(lastElement)
    }
    
    private func divideByZero() -> Bool {
        stringElements.lowercased().contains("/0 ")
    }
}
