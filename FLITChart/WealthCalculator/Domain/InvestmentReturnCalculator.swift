//
//  InvestmentReturnPresenter.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import Foundation
import Darwin

public final class InvestmentReturnCalculator {
    
    public class func calcualteInvestmentOverTime(investmentAttributes: InvestmentAttributes) -> [NSDecimalNumber] {
        guard investmentAttributes.lengthOfInvestmentInMonths > 0 else {
            return [investmentAttributes.initialInvestment]
        }
        
        let annualReturnPercentage = investmentAttributes.annualReturn.dividing(by: 100)
        let number = 1 + annualReturnPercentage.doubleValue
        let power: Double = 1/12
        
        let monthlyReturn = NSDecimalNumber(value: pow(number, power)).subtracting(1)
        
        var wealthOverMonths = [NSDecimalNumber](repeating: investmentAttributes.initialInvestment, count: Int(investmentAttributes.lengthOfInvestmentInMonths))
        
        for index in 1..<wealthOverMonths.count {
            wealthOverMonths[index] = monthlyReturn.adding(1).multiplying(by: wealthOverMonths[index - 1]).adding(investmentAttributes.monthlyContribution)
        }
        
        return wealthOverMonths
    }
}
