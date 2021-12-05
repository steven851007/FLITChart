//
//  InvestmentReturnPresenterTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 03.12.21.
//

import XCTest
import FLITChart

class InvestmentReturnPresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let investmentReturnsModel = defaultInvestmentReturnsModel()

        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel)

        XCTAssertEqual(viewModel.initialInvestmentText, "Initial Investment")
        XCTAssertEqual(viewModel.initialInvestmentValue, "$10,000.00")
        
        XCTAssertEqual(viewModel.monthlyContributionText, "Monthly Contribution")
        XCTAssertEqual(viewModel.monthlyContributionValue, "$500.00")
    }
    
    private func defaultInvestmentReturnsModel() -> InvestmentReturnsModel {
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        return InvestmentReturnsModel(initialInvestment: 10000, monthlyContribution: 500, annualReturns: annualReturns, lengthOfInvestmentInMonths: 10)
    }
    
}
