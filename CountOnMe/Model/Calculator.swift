//
//  Calculator.swift
//  P5 - CountOnMe
//
//  Created by Elora on 25/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    func calculation(elements: [String]) -> Double {
        var elements = elements
        while elements.count >= 3 {
            let left = Int(elements[0])!
            let operand = elements[1]
            let right = Int(elements[2])!
            // faire l'opération des trois premiers éléments
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            //Pour gérer les opération à plus de trois éléments
            // une fois que les trois premiers éléments sont traités, les retirer de la phrase
            elements = Array(elements.dropFirst(3))
            // et ajouter le résultat de l'opération au début du tableau
            elements.insert("\(result)", at: 0)
            // on reste dans la boucle tant qu'il reste des opération après les trois premières
        }

        return Double(elements[0]) ?? 0
    }
}
