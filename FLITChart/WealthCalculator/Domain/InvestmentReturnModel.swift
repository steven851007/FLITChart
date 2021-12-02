//
//  InvestmentReturnModel.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import Foundation

public struct InvestmentReturnModel {
    public let initialInvestment: NSDecimalNumber
    public let monthlyContribution: NSDecimalNumber
    public let annualReturns25thPercentile: [NSDecimalNumber]
    public let annualReturns40thPercentile: [NSDecimalNumber]
    public let annualReturns60thPercentile: [NSDecimalNumber]
    public let annualReturns75thPercentile: [NSDecimalNumber]
    public let lengthOfInvestmentInMonths: UInt
}
