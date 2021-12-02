//
//  FLITChartTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 02.12.21.
//

import XCTest
import FLITChart

import Darwin

class WealthCalculator {
    private let investmentAttributes: InvestmentAttributes
    
    init(investmentAttributes: InvestmentAttributes) {
        self.investmentAttributes = investmentAttributes
    }
    
    func calcualteInvestmentOverTime() -> [NSDecimalNumber] {
        guard investmentAttributes.lengthOfInvestmentInMonths > 0 else {
            return [investmentAttributes.initialInvestment]
        }
        
        let annualReturnPercentage = investmentAttributes.annualReturn.dividing(by: 100)
        let number = 1 + annualReturnPercentage.doubleValue
        let power: Double = 1/12
        
        let monthlyReturn = NSDecimalNumber(value: pow(number, power)).subtracting(1)
        
        var wealthOverMonths = [NSDecimalNumber](repeating: investmentAttributes.initialInvestment, count: Int(investmentAttributes.lengthOfInvestmentInMonths))
        
        for index in 1..<wealthOverMonths.count {
            wealthOverMonths[index] = monthlyReturn.adding(1).multiplying(by: wealthOverMonths[index - 1]).adding(investmentAttributes.monthlyContribution)
        }
        
        return wealthOverMonths
    }
}

class FLITChartTests: XCTestCase {
    
    func test_wealthCalculator_returnsInitialInvestmentForZeroMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let wealthCalculator = createSUT(initialInvestment: initialInvestment, lengthInMonths: 0)
        
        let investmentReturns = wealthCalculator.calcualteInvestmentOverTime()
        
        XCTAssertEqual(investmentReturns, [initialInvestment])
    }
    
    func test_wealthCalculator_returnsInitialInvestmentForOneMonth() {
        let initialInvestment: NSDecimalNumber = 10000
        let wealthCalculator = createSUT(initialInvestment: initialInvestment, lengthInMonths: 1)
        
        let investmentReturns = wealthCalculator.calcualteInvestmentOverTime()
        
        XCTAssertEqual(investmentReturns, [initialInvestment])
    }
    
    func test_wealthCalculator_calculatesCorrectReturnsForTwoMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let wealthCalculator = createSUT(initialInvestment: initialInvestment, lengthInMonths: 2)
        
        let investmentReturns = wealthCalculator.calcualteInvestmentOverTime()
        
        XCTAssertEqual(investmentReturns, [initialInvestment, NSDecimalNumber(string: "10517.742500619853824")])
    }
    
    func test_wealthCalculator_calculatesCorrectReturnsForTenMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        let wealthCalculator = createSUT(initialInvestment: initialInvestment, lengthInMonths: 10)
        
        let investmentReturns = wealthCalculator.calcualteInvestmentOverTime()
        
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
    
    private func createSUT(initialInvestment: NSDecimalNumber, lengthInMonths: UInt) -> WealthCalculator {
        let investmentAttributes = InvestmentAttributes(initialInvestment: initialInvestment, monthlyContribution: 500, annualReturn: 2.15, lengthOfInvestmentInMonths: lengthInMonths)
        return WealthCalculator(investmentAttributes: investmentAttributes)
    }
}
