//
//  InvestmentReturnPresenterTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 03.12.21.
//

import XCTest
import FLITChart

class InvestmentReturnPresenterTests: XCTestCase {
    
    func test_map_createsViewModelWithCorrectLabels() {
        let investmentReturnsModel = defaultInvestmentReturnsModel()

        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)

        XCTAssertEqual(viewModel.initialInvestmentText, "Initial Investment")
        XCTAssertEqual(viewModel.initialInvestmentValue, "$10,000.00")
        
        XCTAssertEqual(viewModel.monthlyContributionText, "Monthly Contribution")
        XCTAssertEqual(viewModel.monthlyContributionValue, "$500.00")
    }
    
    func test_map_investmentReturnsIsCorrectForZeroMonth() {
        let investmentReturnsModel = defaultInvestmentReturnsModel(0)

        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)
        
        let returnsWorstCase = [PointEntry(value: 10000, label: "2020")]
        XCTAssertEqual(viewModel.returnsWorstCase, returnsWorstCase)
    }
    
    func test_map_investmentReturnsIsCorrectForOneMonth() {
        let investmentReturnsModel = defaultInvestmentReturnsModel(1)

        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)
        
        let returnsWorstCase = [PointEntry(value: 10000, label: "2020")]
        XCTAssertEqual(viewModel.returnsWorstCase, returnsWorstCase)
    }
    
    func test_map_createsViewModelWithCorrectInvestmentReturnsForWorstCaseForTwentyFiveYears() {
        let investmentReturnsModel = defaultInvestmentReturnsModel(12*25)
        
        
        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)
        
        let returnsWorstCase = [
            PointEntry(value: 10000, label: "2020"),
            PointEntry(value: 42748, label: "2025"),
            PointEntry(value: 79170, label: "2030"),
            PointEntry(value: 119681, label: "2035"),
            PointEntry(value: 164737, label: "2040")
        ]
        XCTAssertEqual(viewModel.returnsWorstCase, returnsWorstCase)
    }
    
    private func year2020() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 4
        dateComponents.day = 1
        dateComponents.timeZone = TimeZone(abbreviation: "JST")
        dateComponents.hour = 0
        dateComponents.minute = 0

        let userCalendar = Calendar(identifier: .gregorian)
        return userCalendar.date(from: dateComponents)!
    }
    
    private func defaultInvestmentReturnsModel(_ lengthOfInvestmentInMonths: UInt = 10) -> InvestmentReturnsModel {
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        return InvestmentReturnsModel(initialInvestment: 10000, monthlyContribution: 500, annualReturns: annualReturns, lengthOfInvestmentInMonths: lengthOfInvestmentInMonths)
    }
    
}
