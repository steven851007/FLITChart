//
//  FLITChartTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 02.12.21.
//

import XCTest
import FLITChart

import Darwin

class InvestmentReturnsModelTests: XCTestCase {
    
    func test_wealthCalculator_returnsInitialInvestmentForZeroMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 0)
        
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsWorstCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageBottomCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageTopCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.retunrsBestCase, [initialInvestment])
    }
    
    func test_wealthCalculator_returnsInitialInvestmentForOneMonth() {
        let initialInvestment: NSDecimalNumber = 10000
        
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 1)
        
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsWorstCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageBottomCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageTopCase, [initialInvestment])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.retunrsBestCase, [initialInvestment])
    }

    func test_wealthCalculator_calculatesCorrectReturnsForTwoMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 2)

        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsWorstCase, [initialInvestment, NSDecimalNumber(string: "10517.742500619853824")])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageBottomCase, [initialInvestment, NSDecimalNumber(string: "10543.128765598298112")])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageTopCase, [initialInvestment, NSDecimalNumber(string: "10569.914589154562048")])
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.retunrsBestCase, [initialInvestment, NSDecimalNumber(string: "10575.915342905823232")])
    }

    func test_wealthCalculator_calculatesCorrectReturnsForTenMonths() {
        let initialInvestment: NSDecimalNumber = 10000
        
        let investmentAttributes = createSUT(initialInvestment: initialInvestment, lengthInMonths: 10)
        
        let expectedWorstCaseReturns: [NSDecimalNumber] = [
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

        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsWorstCase, expectedWorstCaseReturns)
        
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageBottomCase.last, NSDecimalNumber(string: "14973.3411333898221269606572187074476376"))
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.returnsAverageTopCase.last, NSDecimalNumber(string: "15275.0393025000881417633928250980507972"))
        XCTAssertEqual(investmentAttributes.investmentReturnsOverTime.retunrsBestCase.last, NSDecimalNumber(string: "15343.453022656763791030527302041959774"))
    }
    
    private func createSUT(initialInvestment: NSDecimalNumber, lengthInMonths: UInt) -> InvestmentReturnsModel {
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        return InvestmentReturnsModel(initialInvestment: initialInvestment, monthlyContribution: 500, annualReturn: annualReturns, lengthOfInvestmentInMonths: lengthInMonths)
    }
}
