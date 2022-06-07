//
//  Calculator.swift
//  P5 - CountOnMe
//
//  Created by Elora on 25/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

class Calculation {
    
     weak var delegate: ViewDelegate?
    
    // tableau des éléments de la ligne décomposée
    var elements: [String] = []
    
    func addNumber(element: String) {
        if expressionShouldBeBlanked(elements: elements) {
            elements = []
        }
        if addNumberAfterNumber(elements: elements) {
            guard let firstNumber = elements.last else {
                return
            }
            let secondNumber = element
            elements[elements.count - 1] = ("\(firstNumber)\(secondNumber)")
        } else {
            elements.append(element)
        }
        delegate?.updateScreen()
    }
    
    func addOperator(element: String) {
        if expressionDontEndWhithOperator(elements: elements) {
            elements.append(element)
        }
        delegate?.updateScreen()
    }
    
    func calculation() {
        if divideByZero(elements: elements) {
            elements = ["erreur"]
        } else {
            if expressionDontEndWhithOperator(elements: elements) && expressionHaveEnoughElement(elements: elements) {
                var copyElements = elements
                while copyElements.count >= 3 {
                    let result: Int
                    if let left = Int(copyElements[0]), let right = Int(copyElements[2]) {
                        let operand = copyElements[1]
                        // faire l'opération des trois premiers éléments
                        switch operand {
                        case "+": result = left + right
                        case "-": result = left - right
                        case "X": result = left * right
                        case "/": result = left / right
                        default: return
                        }
                        //Pour gérer les opération à plus de trois éléments
                        // une fois que les trois premiers éléments sont traités, les retirer de la phrase
                        copyElements = Array(elements.dropFirst(3))
                        // et ajouter le résultat de l'opération au début du tableau
                        copyElements.insert("\(result)", at: 0)
                        // on reste dans la boucle tant qu'il reste des opération après les trois premières
                    }
                }
                elements.append("=")
                elements.append("\(copyElements[0])")
            } else {
                elements = ["erreur"]
            }
        }
        print(elements)
        delegate?.updateScreen()
    }
    
    func expressionDontEndWhithOperator(elements: [String]) -> Bool {
        elements.last != "+" && elements.last != "-"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        elements.count >= 3
    }
    // ajouter le mot erreur pour remettre a blanc après une erreur
    func expressionShouldBeBlanked(elements: [String]) -> Bool {
        elements.contains("=") || elements.contains("erreur")
    }
    
    func addNumberAfterNumber(elements: [String]) -> Bool {
        let numberArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        guard let lastElement = elements.last else {
            return false
        }
        return numberArray.contains(lastElement)
    }
    
    func divideByZero(elements: [String]) -> Bool {
       let textViewText = elements.joined()
       return textViewText.lowercased().contains("/0")
    }
}
