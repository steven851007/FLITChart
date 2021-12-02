//
//  InvestmentAttributes.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import Foundation

public struct InvestmentAttributes {
    public let initialInvestment: NSDecimalNumber
    public let monthlyContribution: NSDecimalNumber
    public let annualReturn: NSDecimalNumber
    public let lengthOfInvestmentInMonths: UInt
    
    public init(initialInvestment: NSDecimalNumber, monthlyContribution: NSDecimalNumber, annualReturn: NSDecimalNumber, lengthOfInvestmentInMonths: UInt) {
        self.initialInvestment = initialInvestment
        self.monthlyContribution = monthlyContribution
        self.annualReturn = annualReturn
        self.lengthOfInvestmentInMonths = lengthOfInvestmentInMonths
    }
}
