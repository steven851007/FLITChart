//
//  FLITChartTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 02.12.21.
//

import XCTest
import FLITChart

import Darwin

class InvestmentReturnCalculatorTests: XCTestCase {
    
    func test_wealthCalculator_returnsInitialInvestmentForZeroMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 0)
        
        let investmentReturns = InvestmentReturnCalculator.calcualteInvestmentOverTime(investmentAttributes: investmentAttributes)
        
        XCTAssertEqual(investmentReturns, [initialInvestment])
    }
    
    func test_wealthCalculator_returnsInitialInvestmentForOneMonth() {
        let initialInvestment: NSDecimalNumber = 10000
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 1)
        
        let investmentReturns = InvestmentReturnCalculator.calcualteInvestmentOverTime(investmentAttributes: investmentAttributes)
        
        XCTAssertEqual(investmentReturns, [initialInvestment])
    }
    
    func test_wealthCalculator_calculatesCorrectReturnsForTwoMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 2)
        
        let investmentReturns = InvestmentReturnCalculator.calcualteInvestmentOverTime(investmentAttributes: investmentAttributes)
        
        XCTAssertEqual(investmentReturns, [initialInvestment, NSDecimalNumber(string: "10517.742500619853824")])
    }
    
    func test_wealthCalculator_calculatesCorrectReturnsForTenMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 10)
        
        let investmentReturns = InvestmentReturnCalculator.calcualteInvestmentOverTime(investmentAttributes: investmentAttributes)
        
        let expectedReturns: [NSDecimalNumber] = [
            initialInvestment,
            NSDecimalNumber(string: "10517.742500619853824"),
            NSDecimalNumber(string: "11036.4036059035248905328858763127422976"),
            NSDecimalNumber(string: "11555.9849456853949174025827369263892514"),
            NSDecimalNumber(string: "12076.4881526915793752017367033975964032"),
            NSDecimalNumber(string: "12597.9148625450581461018455215754323153"),
            NSDecimalNumber(string: "13120.2667137708152857150655874084454901"),
            NSDecimalNumber(string: "13643.5453478009879041788208739717185224"),
            NSDecimalNumber(string: "14167.7524089800241826429953812456616138"),
            NSDecimalNumber(string: "14692.8895445698505413681977087232102403")
        ]
        
        XCTAssertEqual(investmentReturns, expectedReturns)
    }
    
    private func createSUT(initialInvestment: NSDecimalNumber, lengthInMonths: UInt) -> InvestmentAttributes {
        return InvestmentAttributes(initialInvestment: initialInvestment, monthlyContribution: 500, annualReturn: 2.15, lengthOfInvestmentInMonths: lengthInMonths)
    }
}
