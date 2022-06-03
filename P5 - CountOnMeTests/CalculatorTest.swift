//
//  CalculatorTest.swift
//  P5 - CountOnMeTests
//
//  Created by Elora on 31/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import P5___CountOnMe

class CalculatorTest: XCTestCase {

    func testGivenNewCalculation_WhenAddind2Plus2_ThenResultShouldBe4() {
         let newCalculation = Calculation()

        XCTAssertEqual(newCalculation.calculation(elements: ["2", "+", "2"]), 4)
    }
    func testGivenNewCalculation_WhenSubtracting4Minus2_ThenResultShouldBe2() {
         let newCalculation = Calculation()

        XCTAssertEqual(newCalculation.calculation(elements: ["4", "-", "2"]), 2)
    }
    func testGivenNewCalculation_WhenMultiply2By2_ThenResultShouldBe4() {
         let newCalculation = Calculation()

        XCTAssertEqual(newCalculation.calculation(elements: ["2", "X", "2"]), 4)
    }
    func testGivenNewCalculation_WhenDividing4By2_ThenResultShouldBe2() {
         let newCalculation = Calculation()

        XCTAssertEqual(newCalculation.calculation(elements: ["4", "/", "2"]), 2)
    }
    func testGivenNewCheck_WhenExpressionEndsWithOperator_ThenShouldReturnFalse() {
        let newCalculation = Calculation()
        XCTAssertFalse(newCalculation.expressionDontEndWhithOperator(elements: ["4", "+", "2", "-" ]))
        }
    func testGivenNewCheck_WhenExpressionDoesntHaveEnoughElements_ThenShouldReturnFalse() {
        let newCalculation = Calculation()
        XCTAssertFalse(newCalculation.expressionHaveEnoughElement(elements: ["4"]))
    }
    func testGivenNewCheck_WhenAResultIsDisplayed_ThenShouldReturnTrue() {
        let newCalculation = Calculation()
        XCTAssertTrue(newCalculation.expressionShouldBeBlanked(textViewText: "4 + 2 = 6"))
    }
    func testGivenAnErrorMessageDisplayed_WhenIStartTappingNewCalc_ThenTextViewTextShouldBeBlanked() {

        let newCalculation = Calculation()
        
        XCTAssertTrue(newCalculation.expressionShouldBeBlanked(textViewText: "Erreur unit test "))
    }
    func testGivenNewCalculation_TryingToDivide8ByZero_ThenCheckReturnTrue() {
        let newCalculation = Calculation()
        XCTAssertTrue(newCalculation.divideByZero(textViewText: "8/0"))
    }
}
