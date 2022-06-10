//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

public protocol CalculationDelegate: AnyObject {
    func updateScreen(result: String)
    func showError()
}

class ViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    // tableau des éléments de la ligne décomposée
//    var elements: [String] {
//        textView.text.split(separator: " ").map { "\($0)" }
//    }
    
    var calcul = Calculation()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateSetup()
    }
    
    func delegateSetup() {
        calcul.delegate = self
    }
    
    // affiche le numéro tapé dans l'écran de la calculette
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        if let elementToAdd = sender.title(for: .normal) {
            calcul.addNumber(element: elementToAdd)
        }
    }
    
    @IBAction private func tappedPlusButton() {
        calcul.addOperator(element: "+")
    }
    @IBAction private func tappedMinusButton() {
        calcul.addOperator(element: "-")
    }
    
    @IBAction private func tappedMultiplyButton() {
        calcul.addOperator(element: "X")
    }
    
    @IBAction private func tappedDivideButton() {
        calcul.addOperator(element: "/")
    }
    
    @IBAction private func tappedEqualButton() {
        calcul.calculation()
    }
    @IBAction private func tappedACButton() {
        calcul.cleanTextView()
    }
    @IBAction private func tappedButton() {
        calcul.addComma(element: ".")
    }
}

extension ViewController: CalculationDelegate {
    
    
    public func updateScreen(result: String) {
        textView.text = result
    }
    
    public func showError() {
        print("erreur")
        textView.text = "erreur"
    }
}
