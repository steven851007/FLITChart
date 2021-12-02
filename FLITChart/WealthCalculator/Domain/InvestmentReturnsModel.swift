//
//  InvestmentAttributes.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import Foundation
import Darwin

public struct AnnualReturnPercentages {
    public let worstCase: NSDecimalNumber
    public let averageWorstCase: NSDecimalNumber
    public let averageBestCase: NSDecimalNumber
    public let bestCase: NSDecimalNumber
    
    public init (worstCase: NSDecimalNumber, averageWorstCase: NSDecimalNumber, averageBestCase: NSDecimalNumber, bestCase: NSDecimalNumber) {
        self.worstCase = worstCase
        self.averageWorstCase = averageWorstCase
        self.averageBestCase = averageBestCase
        self.bestCase = bestCase
    }
}

public struct InvestmentReturnsOverTime {
    public let returnsWorstCase: [NSDecimalNumber]
    public let returnsAverageBottomCase: [NSDecimalNumber]
    public let returnsAverageTopCase: [NSDecimalNumber]
    public let retunrsBestCase: [NSDecimalNumber]
}

public struct InvestmentReturnsModel {
    public let initialInvestment: NSDecimalNumber
    public let monthlyContribution: NSDecimalNumber
    public let annualReturn: AnnualReturnPercentages
    public let lengthOfInvestmentInMonths: UInt
    public let investmentReturnsOverTime: InvestmentReturnsOverTime
    
    public init(initialInvestment: NSDecimalNumber, monthlyContribution: NSDecimalNumber, annualReturn: AnnualReturnPercentages, lengthOfInvestmentInMonths: UInt) {
        self.initialInvestment = initialInvestment
        self.monthlyContribution = monthlyContribution
        self.annualReturn = annualReturn
        self.lengthOfInvestmentInMonths = lengthOfInvestmentInMonths
        self.investmentReturnsOverTime = InvestmentReturnCalculator.calcualteInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturn, lengthOfInvestmentInMonths: lengthOfInvestmentInMonths)
    }
}
