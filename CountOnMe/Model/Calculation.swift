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
    
     weak var delegate: CalculationDelegate?
    
    // tableau des éléments de la ligne décomposée
    var elements: [String] = [] {
        didSet {
            delegate?.updateScreen(result: stringElements)
        }
    }
    var stringElements: String {
        "\(elements.joined()) "
    }
    
    // on doit split avant et après chaque opérateur
    
    func addNumber(element: String) {
        if expressionShouldBeBlanked(elements: elements) {
            elements = []
            delegate?.updateScreen(result: stringElements)
        }
        if addNumberAfterNumber(elements: elements) {
            guard let firstNumber = elements.last else {
                return
            }
            let secondNumber = element
            print(firstNumber)
            print(secondNumber)
            elements[elements.count - 1] = ("\(firstNumber)\(secondNumber)")
        } else {
            if elements.last == "0" {
                return
            }
            elements.append(element)
        }
        delegate?.updateScreen(result: stringElements)
    }
    
    func addOperator(element: String) {
            if expressionDontEndWhithOperator(elements: elements)
            && !elements.isEmpty
            && !expressionShouldBeBlanked(elements: elements) {
            self.elements.append(element)
        }
        delegate?.updateScreen(result: stringElements)
    }
    
    // vérifier que le dernier element n'est pas un opérateur, qu'il n'y a pas de résultat affiché, qu'il n'y a pas déjà un virgule au nombre en question, que le tableau ne soit pas vide
    
    func addComma(element: String) {

            if expressionDontEndWhithOperator(elements: elements)
            && !expressionShouldBeBlanked(elements: elements)
            && expressionDontEndWithComma(elements: elements)
            && !elements.isEmpty {
            guard let lastElement = elements.last else { return }
            elements[elements.count - 1] = "\(lastElement)\(element)"
        }
        delegate?.updateScreen(result: stringElements)
    }
    
    func cleanTextView() {
        elements = []
        delegate?.updateScreen(result: stringElements)
    }
    
    func calculation() {
        if divideByZero(elements: elements) {
            elements = ["erreur"]
            delegate?.showError()
        } else {
            if expressionDontEndWhithOperator(elements: elements) && expressionHaveEnoughElement(elements: elements) {
                var copyElements = elements
                while copyElements.count >= 3 {
                    let result: Double
                    if let left = Double(copyElements[0]), let right = Double(copyElements[2]) {
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
                        copyElements = Array(copyElements.dropFirst(3))
                        // et ajouter le résultat de l'opération au début du tableau
                        copyElements.insert("\(result)", at: 0)
                        // on reste dans la boucle tant qu'il reste des opération après les trois premières
                    }
                }
                elements.append("=")
                if String(copyElements[0].suffix(2)) == ".0" {
                    copyElements[0] = String(copyElements[0].dropLast(2))
                }
                
                elements.append(copyElements[0])
                delegate?.updateScreen(result: stringElements)
            } else {
                elements = ["erreur"]
                delegate?.showError()
            }
        }
    }
    
    func expressionDontEndWithComma(elements: [String]) -> Bool {
        elements.last != "."
    }
    
    func expressionDontEndWhithOperator(elements: [String]) -> Bool {
        elements.last != "+" && elements.last != "-" && elements.last != "X"
        && elements.last != "/"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        elements.count >= 3
    }
    // ajouter le mot erreur pour remettre a blanc après une erreur
    func expressionShouldBeBlanked(elements: [String]) -> Bool {
        elements.contains("=") || elements.contains("erreur")
    }
    
    func addNumberAfterNumber(elements: [String]) -> Bool {
        let numberArray: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
        
        guard let lastElement = elements.last?.last else {
            return false
        }
        return numberArray.contains(lastElement)
    }
    
    func divideByZero(elements: [String]) -> Bool {
       stringElements.lowercased().contains("/0 ")
    }
}
