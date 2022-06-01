//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    // tableau des éléments de la ligne décomposée
    var elements: [String] {
         textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var calcul = Calculation()
    var checks = Checks()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // affiche le numéro tapé dans l'écran de la calculette
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // si un résultat d'opération est affiché (avec =) alors vider l'affichage
        if checks.expressionShouldBeBlanked(textViewText: textView.text) {
            textView.text = ""
        }
        // afficher le numéro tapé
        textView.text.append(numberText)
    }
    
    
    @IBAction private func tappedOperandButton(_ sender: UIButton) {
        guard let operand = sender.title(for: .normal) else { return }
        if checks.expressionDontEndWhithOperator(elements: elements) {
            switch operand {
            case "+": textView.text.append(" + ")
            case "-": textView.text.append(" - ")
            case "X": textView.text.append(" X ")
            case "/": textView.text.append(" / ")
            default: textView.text.append(" erreur ")
            }
        } else {
            
            textView.text = "Erreur expressionDontEndWhithOperator"
        }
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        
        // si la phrase ne finit pas par un opérateur
        guard checks.expressionDontEndWhithOperator(elements: elements)
        else {
            
            textView.text = "Erreur expressionDontEndWhithOperator"
            return
        }
        // si la phrase contient au moins 3 éléments
        guard checks.expressionHaveEnoughElement(elements: elements) else {
            
            textView.text = "Erreur expressionHaveEnoughElement"
            return
        }
        
        guard checks.divideByZero(textViewText: textView.text) else {
            textView.text = "Erreur impossible de diviser par zero"
            return
        }
        
        // Create local copy of operations
        let elementsToReduce = elements
        
        
        // quand il ne reste plus qu'un résultat on l'affiche c'est le resultat final
        if let result = self.calcul.calculation(elements: elementsToReduce) {
            textView.text.append(" = \(result )")
        } else {
            textView.text = "Erreur case nil"
        }
    }
}

//  faire une seule fonction pour tous les opérateurs
