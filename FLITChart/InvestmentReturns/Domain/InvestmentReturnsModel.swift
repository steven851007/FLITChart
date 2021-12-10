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
    public let returnsBestCase: [NSDecimalNumber]
}

public struct InvestmentReturnsModel {
    public let initialInvestment: NSDecimalNumber
    public let monthlyContribution: NSDecimalNumber
    public let annualReturns: AnnualReturnPercentages
    public let lengthOfInvestmentInMonths: UInt
    public let investmentReturnsOverTime: InvestmentReturnsOverTime
    
    public init(initialInvestment: NSDecimalNumber, monthlyContribution: NSDecimalNumber, annualReturns : AnnualReturnPercentages, lengthOfInvestmentInMonths: UInt) {
        self.initialInvestment = initialInvestment
        self.monthlyContribution = monthlyContribution
        self.annualReturns = annualReturns
        self.lengthOfInvestmentInMonths = lengthOfInvestmentInMonths
        self.investmentReturnsOverTime = InvestmentReturnCalculator.calcualteInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturns, lengthOfInvestmentInMonths: lengthOfInvestmentInMonths)
    }
    
    public static var initiallModel: InvestmentReturnsModel {
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        return InvestmentReturnsModel(initialInvestment: 10000, monthlyContribution: 500, annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
    }
}
