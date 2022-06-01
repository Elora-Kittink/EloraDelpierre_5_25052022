//
//  Checks.swift
//  P5 - CountOnMe
//
//  Created by Elora on 31/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Checks {
    
    
    func expressionDontEndWhithOperator(elements: [String]) -> Bool {
        elements.last != "+" && elements.last != "-"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        elements.count >= 3
    }
    // ajouter le mot erreur pour remettre a blanc après une erreur 
    func expressionShouldBeBlanked(textViewText: String) -> Bool {
        textViewText.contains("=") || textViewText.lowercased().contains("erreur")
    }
    
    func divideByZero(textViewText: String) -> Bool {
        textViewText.lowercased().contains("/0")
    }
}
