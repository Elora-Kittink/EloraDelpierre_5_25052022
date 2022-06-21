//
//  CalculatorTest.swift
//  P5 - CountOnMeTests
//
//  Created by Elora on 31/05/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import P5___CountOnMe

class ControllerSpy: CalculationDelegate {
    var expectedResult: String = ""
    var expectedError: String = ""
    
    func updateScreen(result: String) {
        expectedResult = result
    }
    
    func showError() {
        expectedError = "erreur"
    }
}

class CalculatorTest: XCTestCase {
    
    func testGivenNewCalculation_WhenAddind2Plus2_ThenResultShouldBe4() {

        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "2")
        sut.addOperator(element: "+")
        sut.addNumber(element: "2")
        sut.calculation()
        
        XCTAssertEqual(controller.expectedResult, "2+2=4")
    }
    
    func testGivenNewCalculation_WhenAddind2Plus2Plus2_ThenResultShouldBe6() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "2")
        sut.addOperator(element: "+")
        sut.addNumber(element: "2")
        sut.addOperator(element: "+")
        sut.addNumber(element: "2")
        sut.calculation()
        
        XCTAssertEqual(controller.expectedResult, "2+2+2=6")
    }
    func testGivenNewCalculation_WhenSubtracting4Minus2_ThenResultShouldBe2() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.addOperator(element: "-")
        sut.addNumber(element: "4")
        sut.calculation()

        XCTAssertEqual(controller.expectedResult, "4-4=0")
    }
    func testGivenNewCalculation_WhenMultiply2By2_ThenResultShouldBe4() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "2")
        sut.addOperator(element: "X")
        sut.addNumber(element: "2")
        sut.calculation()

        XCTAssertEqual(controller.expectedResult, "2X2=4")
    }
    func testGivenNewCalculation_WhenDividing4By2_ThenResultShouldBe2() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.addOperator(element: "/")
        sut.addNumber(element: "2")
        sut.calculation()

        XCTAssertEqual(controller.expectedResult, "4/2=2")
    }
    func testGivenNewCheck_WhenExpressionEndsWithOperator_ThenShouldReturnFalse() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.addOperator(element: "+")
        sut.addNumber(element: "2")
        sut.addOperator(element: "-")
        sut.calculation()

        XCTAssertEqual(controller.expectedError, "erreur")
        }
    func testGivenNewCheck_WhenExpressionDoesntHaveEnoughElements_ThenShouldReturnError() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.calculation()

        XCTAssertEqual(controller.expectedError, "erreur")
    }
    func testGivenNewCheck_WhenAResultIsDisplayed_ThenShouldDeletePreviousResult() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.addOperator(element: "+")
        sut.addNumber(element: "2")
        sut.calculation()
        XCTAssertEqual(controller.expectedResult, "4+2=6")
        sut.addNumber(element: "5")
        sut.addOperator(element: "-")

        XCTAssertEqual(controller.expectedResult, "5-")
    }
    func testGivenAnErrorMessageDisplayed_WhenIStartTappingNewCalc_ThenTextViewTextShouldBeBlanked() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "4")
        sut.addOperator(element: "+")
        sut.calculation()
        XCTAssertEqual(controller.expectedError, "erreur")
        sut.addNumber(element: "5")
        sut.addOperator(element: "-")

        XCTAssertEqual(controller.expectedResult, "5-")
    }
    func testGivenAddingA5_WhenThereIsA0_ThenShouldntAdd5() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "0")
        sut.addNumber(element: "5")

        XCTAssertEqual(controller.expectedResult, "0")
    }
    func testGivenAddingANumber_WhenThereIsAlreadyA2_ThenShoulReturnTrue() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "2")
        sut.addNumber(element: "5")

        XCTAssertEqual(controller.expectedResult, "25")
    }

    func testGivenNewCalculation_WhenTryingToDivide8ByZero_ThenCheckReturn() {
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "8")
        sut.addOperator(element: "/")
        sut.addNumber(element: "0")
        sut.calculation()

        XCTAssertEqual(controller.expectedError, "erreur")
    }
    func testGivenAddingComma_WhenLastElementIs5_ThenShouldAddComma() {
        
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "5")
        sut.addComma(element: ".")

        XCTAssertEqual(controller.expectedResult, "5.")
    }
    func testGivenClearTheElementsArray_WhenThereIsA5_ThenShouldEmptyTheArray() {
        
        let (sut, controller) = makeSUT()
        
        sut.addNumber(element: "5")
        sut.cleanTextView()

        XCTAssertEqual(controller.expectedResult, "")
    }
    
    func makeSUT() -> (model: Calculation, controller: ControllerSpy) {
        let sut = Calculation()
        let controller = ControllerSpy()
        sut.delegate = controller
        return (sut, controller)
    }
}
