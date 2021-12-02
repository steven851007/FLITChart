//
//  InvestmentReturnPresenter.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import Foundation
import Darwin

final class InvestmentReturnCalculator {
    
    class func calcualteInvestmentOverTime(initialInvestment: NSDecimalNumber, monthlyContribution: NSDecimalNumber, annualReturn: AnnualReturnPercentages, lengthOfInvestmentInMonths: UInt) -> InvestmentReturnsOverTime {
        guard lengthOfInvestmentInMonths > 0 else {
            
            return InvestmentReturnsOverTime(
                returnsWorstCase: [initialInvestment],
                returnsAverageBottomCase: [initialInvestment],
                returnsAverageTopCase: [initialInvestment],
                retunrsBestCase: [initialInvestment])
        }
        
        let returnsWorstCase = self.calculateInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturn.worstCase, investmentLength: lengthOfInvestmentInMonths)
        
        let returnsAverageBottomCase = self.calculateInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturn.averageWorstCase, investmentLength: lengthOfInvestmentInMonths)
        
        let returnsAverageTopCase = self.calculateInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturn.averageBestCase, investmentLength: lengthOfInvestmentInMonths)
        
        let returnsBestCase = self.calculateInvestmentOverTime(initialInvestment: initialInvestment, monthlyContribution: monthlyContribution, annualReturn: annualReturn.bestCase, investmentLength: lengthOfInvestmentInMonths)
        
        return InvestmentReturnsOverTime(
            returnsWorstCase: returnsWorstCase,
            returnsAverageBottomCase: returnsAverageBottomCase,
            returnsAverageTopCase: returnsAverageTopCase,
            retunrsBestCase: returnsBestCase)
        
    }
    
    private class func calculateInvestmentOverTime(initialInvestment: NSDecimalNumber, monthlyContribution: NSDecimalNumber, annualReturn: NSDecimalNumber, investmentLength: UInt) -> [NSDecimalNumber] {
        
        let annualReturnPercentage = annualReturn.dividing(by: 100)
        let number = 1 + annualReturnPercentage.doubleValue
        let power: Double = 1/12
        
        let monthlyReturn = NSDecimalNumber(value: pow(number, power)).subtracting(1)
        
        var wealthOverMonths = [NSDecimalNumber](repeating: initialInvestment, count: Int(investmentLength))
        
        for index in 1..<wealthOverMonths.count {
            wealthOverMonths[index] = monthlyReturn.adding(1).multiplying(by: wealthOverMonths[index - 1]).adding(monthlyContribution)
        }
        
        return wealthOverMonths
    }
}
