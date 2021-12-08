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
        
        let expectedReturns = [PointEntry(value: 10000, label: "2020")]
        XCTAssertEqual(viewModel.returnsWorstCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsAverageBottomCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsAverageTopCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsBestCase, expectedReturns)
    }
    
    func test_map_investmentReturnsIsCorrectForOneMonth() {
        let investmentReturnsModel = defaultInvestmentReturnsModel(1)

        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)
        
        let expectedReturns = [PointEntry(value: 10000, label: "2020")]
        XCTAssertEqual(viewModel.returnsWorstCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsAverageBottomCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsAverageTopCase, expectedReturns)
        XCTAssertEqual(viewModel.returnsBestCase, expectedReturns)
    }
    
    func test_map_createsViewModelWithCorrectInvestmentReturnsForWorstCaseForTwentyFiveYears() {
        let investmentReturnsModel = defaultInvestmentReturnsModel(12*26)
        
        let viewModel = InvestmentReturnsPresenter.map(investmentReturnsModel, startDate: year2020)
        
        let expectedReturnsWorstCase = [
            PointEntry(value: 10000, label: "2020"),
            PointEntry(value: 42748, label: "2025"),
            PointEntry(value: 79170, label: "2030"),
            PointEntry(value: 119681, label: "2035"),
            PointEntry(value: 164737, label: "2040"),
            PointEntry(value: 214850, label: "2045")
        ]
        
        let expectedReturnsAverageBottomCase = [
            PointEntry(value: 10000, label: "2020"),
            PointEntry(value: 47102, label: "2025"),
            PointEntry(value: 95135, label: "2030"),
            PointEntry(value: 157319, label: "2035"),
            PointEntry(value: 237824, label: "2040"),
            PointEntry(value: 342047, label: "2045")
        ]
        
        let expectedReturnsAverageTopCase = [
            PointEntry(value: 10000, label: "2020"),
            PointEntry(value: 52304, label: "2025"),
            PointEntry(value: 116561, label: "2030"),
            PointEntry(value: 214167, label: "2035"),
            PointEntry(value: 362425, label: "2040"),
            PointEntry(value: 587625, label: "2045")
        ]
        
        let expectedReturnsBestCase = [
            PointEntry(value: 10000, label: "2020"),
            PointEntry(value: 53563, label: "2025"),
            PointEntry(value: 122143, label: "2030"),
            PointEntry(value: 230103, label: "2035"),
            PointEntry(value: 400057, label: "2040"),
            PointEntry(value: 667607, label: "2045")
        ]
        
        XCTAssertEqual(viewModel.returnsWorstCase, expectedReturnsWorstCase)
        XCTAssertEqual(viewModel.returnsAverageBottomCase, expectedReturnsAverageBottomCase)
        XCTAssertEqual(viewModel.returnsAverageTopCase, expectedReturnsAverageTopCase)
        XCTAssertEqual(viewModel.returnsBestCase, expectedReturnsBestCase)
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
