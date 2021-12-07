//
//  InvestmentReturnsPresenter.swift
//  FLITChart
//
//  Created by Istvan Balogh on 03.12.21.
//

import Foundation

public final class InvestmentReturnsPresenter {
    
    private static var currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter
    }()
    
    public class func map(_ investmentReturnsModel: InvestmentReturnsModel) -> InvestmentReturnsViewModel {

        let initialInvestmentValue = currencyFormatter.string(from: investmentReturnsModel.initialInvestment)!
        let monthlyContributionValue = currencyFormatter.string(from: investmentReturnsModel.monthlyContribution)!
        
        return InvestmentReturnsViewModel(initialInvestmentValue: initialInvestmentValue, monthlyContributionValue: monthlyContributionValue)
    }
}
