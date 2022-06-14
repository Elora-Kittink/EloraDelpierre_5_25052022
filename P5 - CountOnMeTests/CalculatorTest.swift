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
    let newCalculation = Calculation()
    
    func testGivenNewCalculation_WhenAddind2Plus2_ThenResultShouldBe4() {

        newCalculation.elements = ["2", "+", "2"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements.last, "4")
    }
    func testGivenNewCalculation_WhenAddind2Plus2Plus2_ThenResultShouldBe6() {

        newCalculation.elements = ["2", "+", "2", "+", "2"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements.last, "6")
    }
    func testGivenNewCalculation_WhenSubtracting4Minus2_ThenResultShouldBe2() {
        newCalculation.elements = ["4", "-", "2"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements.last, "2")
    }
    func testGivenNewCalculation_WhenMultiply2By2_ThenResultShouldBe4() {
        newCalculation.elements = ["2", "X", "2"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements.last, "4")
    }
    func testGivenNewCalculation_WhenDividing4By2_ThenResultShouldBe2() {
        newCalculation.elements = ["4", "/", "2"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements.last, "2")
    }
    func testGivenNewCheck_WhenExpressionEndsWithOperator_ThenShouldReturnFalse() {
        newCalculation.elements = ["4", "+", "2", "-"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements[0], "erreur")
        XCTAssertTrue(newCalculation.expressionHaveResult())
        }
    func testGivenNewCheck_WhenExpressionDoesntHaveEnoughElements_ThenShouldReturnFalse() {
        newCalculation.elements = ["4"]
        newCalculation.calculation()
        XCTAssertEqual(newCalculation.elements[0], "erreur")
        XCTAssertFalse(newCalculation.expressionHaveResult())
    }
    func testGivenNewCheck_WhenAResultIsDisplayed_ThenShouldReturnTrue() {
        newCalculation.elements = ["4", "+", "2", "=", "6"]
        XCTAssertTrue(newCalculation.expressionHaveResult())
    }
    func testGivenAnErrorMessageDisplayed_WhenIStartTappingNewCalc_ThenTextViewTextShouldBeBlanked() {
        newCalculation.elements = ["erreur"]
        XCTAssertTrue(newCalculation.expressionHaveResult())
    }
    func testGivenAddingA5_WhenThereIsAlreadyA4Plus_ThenShouldAdd5AfterThePlus() {
        newCalculation.elements = ["4", "+"]
        newCalculation.addNumber(element: "5")
        XCTAssertEqual(newCalculation.elements.last, "5")
    }
    func testGivenAddingAPlus_WhenThereIsAlreadyA5_ThenShouldAddPusAfterThe4() {
        newCalculation.elements = ["5"]
        newCalculation.addOperator(element: "+")
        XCTAssertEqual(newCalculation.elements.last, "+")
    }
    func testGivenAddingA5_WhenThereIsAlreadyA1_ThenShouldAdd15() {
        newCalculation.elements = ["1"]
        newCalculation.addNumber(element: "5")
        XCTAssertEqual(newCalculation.elements.last, "15")
    }
    func testGivenAddingA5_WhenThereIsAlreadyAResult_ThenShouldDeleteResult() {
        newCalculation.elements = ["1", "+", "1", "=", "2"]
        newCalculation.addNumber(element: "5")
        XCTAssertEqual(newCalculation.elements, ["5"])
    }
    func testGivenAddingANumber_WhenThereIsAlreadyA2_ThenShoulReturnTrue() {
        newCalculation.elements = ["2"]
        XCTAssertTrue(newCalculation.addNumberAfterNumber(lastElement: newCalculation.elements.last ?? "2"))
    }

    func testGivenNewCalculation_TryingToDivide8ByZero_ThenCheckReturn() {
        newCalculation.elements = ["4", "/", "0"]
        newCalculation.calculation()
    }
}
