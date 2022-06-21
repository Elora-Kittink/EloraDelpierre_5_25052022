//
//  Calculator.swift
//  P5 - CountOnMe
//
//  Created by Elora on 25/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

public class Calculation {
    
    public weak var delegate: CalculationDelegate?
    
    // array of elements display on the calculator, updated at each change
    var elements: [String] = [] {
        didSet {
            delegate?.updateScreen(result: elements.joined())
        }
    }
    
    // MARK: - checkings
    
    private func lastElementDontContainComma() -> Bool {
        !(elements.last?.contains(".") ?? true)
    }
    
    private func expressionDontEndWhithOperator() -> Bool {
        elements.last != "+" && elements.last != "-" && elements.last != "X"
        && elements.last != "/"
    }
    
    private func expressionHaveEnoughElement() -> Bool {
        elements.count >= 3
    }
    
    func expressionContainEqualOrError() -> Bool {
        elements.contains("=") || elements.contains("erreur")
    }
    
    // concatene unless the last element is part of the list in the array
    func concatenateWithElementBefore(lastElement: String) -> Bool {
        let array: [String] = ["-", "+", "X", "/", "0"]
        return !array.contains(lastElement)
    }
    
    private func divideByZero() -> Bool {
        self.elements
            .enumerated()
            .contains { index, value in
                value == "/" && self.elements[index + 1] == "0"
            }
    }
    
    // MARK: - functions called in the IBActions
    
    // add concatenated to previous number or alone if not possible, cant add a number right after 0
    public func addNumber(element: String) {
        if expressionContainEqualOrError() {
            cleanTextView()
        }
        if let firstNumber = elements.last,
           concatenateWithElementBefore(lastElement: firstNumber) {
            let secondNumber = element
            elements[elements.count - 1] = ("\(firstNumber)\(secondNumber)")
        } else {
            if elements.last == "0" {
                return
            }
            elements.append(element)
        }
    }
    
    // make some checks before adding the operator to the element array
    public func addOperator(element: String) {
        guard expressionDontEndWhithOperator()
                && !elements.isEmpty
                && !expressionContainEqualOrError() else { return }
        elements.append(element)
    }
    
    // make some checks before to add comma concatenated with previous number
    public func addComma(element: String) {
        if expressionDontEndWhithOperator()
            && !expressionContainEqualOrError()
            && lastElementDontContainComma()
            && !elements.isEmpty {
            guard let lastElement = elements.last else { return }
            elements[elements.count - 1] = "\(lastElement)\(element)"
        }
    }
    
    public func cleanTextView() {
        elements = []
    }
    
    // MARK: - calculating functions
    
    // make some checks, launch the calculation, cleans up unnecessary commas
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
    
    // makes a loop that does the calculation of the first three elements,
    // until arriving at the final result
    private func calculLoop() -> [String] {
        var operationReducedByPriority = priorityManagement()
        while operationReducedByPriority.count >= 3 {
            let result: Double
            if let left = Double(operationReducedByPriority[0]), let right = Double(operationReducedByPriority[2]) {
                let operand = operationReducedByPriority[1]
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "X": result = left * right
                case "/": result = left / right
                default: return []
                }
                operationReducedByPriority = Array(operationReducedByPriority.dropFirst(3))
                operationReducedByPriority.insert("\(result)", at: 0)
            }
        }
        return operationReducedByPriority
    }
    
    func priorityManagement() -> [String] {
        var copyElements = elements
        while copyElements.contains("X") || copyElements.contains("/") {
            if let index = copyElements.firstIndex(where: { $0 == "X" || $0 == "/" }) {
                if let left = Float(copyElements[index - 1]), let right = Float(copyElements[index + 1]) {
                    let operand = copyElements[index]
                    let result: Float
                    switch operand {
                    case "X": result = left * right
                    case "/": result = left / right
                    default: return []
                    }
                    copyElements[index - 1] = "\(result)"
                    copyElements.remove(at: index + 1)
                    copyElements.remove(at: index)
                }
            }
        }
        return copyElements
    }
}
