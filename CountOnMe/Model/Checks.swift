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
        return elements.last != "+" && elements.last != "-"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    // ajouter le mot erreur pour remettre a blanc après une erreur 
    func expressionHaveResult(textViewText: String) -> Bool {
        return textViewText.firstIndex(of: "=") != nil
    }
}
