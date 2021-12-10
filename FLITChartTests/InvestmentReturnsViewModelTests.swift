//
//  InvestmentReturnsViewModelTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 10.12.21.
//

import XCTest
import FLITChart

class InvestmentReturnsViewModelTests: XCTestCase {

    func test_currencyFormatting() {
        let sut = InvestmentReturnsPresenter.map(InvestmentReturnsModel.initiallModel)
        
        XCTAssertEqual(sut.currencyFormattedString(from: "500000"), "500,000")
    }

}
