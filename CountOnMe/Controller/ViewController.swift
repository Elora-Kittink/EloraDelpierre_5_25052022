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
    
//    // Error check computed variables
//    // vérifie que le dernier élément de la phrase ne soit pas un opérateur
//    var expressionDontEndWhithOperator: Bool {
//        return elements.last != "+" && elements.last != "-"
//    }
//
//    // vérifie que la phrase contienne au moins 3 éléments
//    var expressionHaveEnoughElement: Bool {
//        return elements.count >= 3
//    }
//
//
//    // vérifie qu'il n'y a pas de = dans la phrase?
//    var expressionHaveResult: Bool {
//        return textView.text.firstIndex(of: "=") != nil
//    }
    
    var calcul = Calculation()
    var checks = Checks()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // affiche le numéro tapé dans l'écran de la calculette
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        // si un résultat d'opération est affiché (avec =) alors vider l'affichage
        if checks.expressionHaveResult(textViewText: textView.text) {
            textView.text = ""
        }
        // afficher le numéro tapé
        textView.text.append(numberText)
    }
    
    
    @IBAction  func tappedOperandButton(_ sender: UIButton){
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
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        
        // si la phrase ne finit pas par un opérateur
        guard checks.expressionDontEndWhithOperator(elements: elements) else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        // si la phrase contient au moins 3 éléments
        guard checks.expressionHaveEnoughElement(elements: elements) else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        let elementsToReduce = elements
        
        
        let result = self.calcul.calculation(elements: elementsToReduce)
        
        // quand il ne reste plus qu'un résultat on l'affiche c'est le resultat final
        textView.text.append(" = \(result )")
    }
    
}

//  faire une seule fonction pour tous les opérateurs
