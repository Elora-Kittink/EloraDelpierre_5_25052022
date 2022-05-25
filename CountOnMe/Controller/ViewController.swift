//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // tableau des éléments de la ligne décomposée
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    // vérifie que le dernier élément de la phrase ne soit pas un opérateur
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    // vérifie que la phrase contienne au moins 3 éléments
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    // exactement pareil que expressionIsCorrect ???
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    // vérifie qu'il n'y a pas de = dans la phrase?
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // affiche le numéro tapé dans l'écran de la calculette
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // si un résultat d'opération est affiché (avec =) alors vider l'affichage
        if expressionHaveResult {
            textView.text = ""
        }
        // afficher le numéro tapé
        textView.text.append(numberText)
    }
    
    // si la phrase ne finit pas déjà par un opérateur, affiche +
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // si la phrase ne finit pas déjà par un opérateur, affiche -
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        // si la phrase ne finit pas par un opérateur
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        // si la phrase contient au moins 3 éléments
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        // WTF ici?
        while operationsToReduce.count >= 3 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            // faire l'opération des trois premiers éléments
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            //Pour gérer les opération à plus de trois éléments
            // une fois que les trois premiers éléments sont traités, les retirer de la phrase
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            // et ajouter le résultat de l'opération au début du tableau
            operationsToReduce.insert("\(result)", at: 0)
            // on reste dans la boucle tant qu'il reste des opération après les trois premières
        }
        // quand il ne reste plus qu'un résultat on l'affiche c'est le resultat final
        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

