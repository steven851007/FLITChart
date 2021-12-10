//
//  InvestmentReturnsPresenter.swift
//  FLITChart
//
//  Created by Istvan Balogh on 03.12.21.
//

import Foundation

extension NumberFormatter {
    static var chartCurrencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.alwaysShowsDecimalSeparator = false
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = ""
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter
    }()
}

public final class InvestmentReturnsPresenter {
    
    public class func map(_ investmentReturnsModel: InvestmentReturnsModel, startDate: () -> Date = Date.init) -> InvestmentReturnsViewModel {

        let initialInvestmentValue = NumberFormatter.chartCurrencyFormatter.string(from: investmentReturnsModel.initialInvestment)!
        let monthlyContributionValue = NumberFormatter.chartCurrencyFormatter.string(from: investmentReturnsModel.monthlyContribution)!
        
        let worstCaseEntires = generateEntries(investmentReturnsModel.investmentReturnsOverTime.returnsWorstCase, startDate: startDate)
        let returnsAverageBottomCase = generateEntries(investmentReturnsModel.investmentReturnsOverTime.returnsAverageBottomCase, startDate: startDate)
        let returnsAverageTopCase = generateEntries(investmentReturnsModel.investmentReturnsOverTime.returnsAverageTopCase, startDate: startDate)
        let returnsBestCase = generateEntries(investmentReturnsModel.investmentReturnsOverTime.returnsBestCase, startDate: startDate)
        
        return InvestmentReturnsViewModel(
            initialInvestmentValue: initialInvestmentValue,
            monthlyContributionValue: monthlyContributionValue,
            returnsWorstCase: worstCaseEntires,
            returnsAverageBottomCase: returnsAverageBottomCase,
            returnsAverageTopCase: returnsAverageTopCase,
            returnsBestCase: returnsBestCase)
    }
    
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    private static let decimalNumberHandler = NSDecimalNumberHandler(roundingMode: .plain, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    
    private class func generateEntries(_ numbers: [NSDecimalNumber], startDate: () -> Date) -> [PointEntry] {
        
        var result: [PointEntry] = []
        
        for (month, value) in numbers.enumerated() {
            guard month % (12*5) == 0 else {
                // Only add valuse every 5 years
                continue
            }
            
            let roundedIntValue = value.rounding(accordingToBehavior: decimalNumberHandler).intValue
            result.append(PointEntry(value: roundedIntValue, label: dateFormatter.string(from: startDate().adding(months: month))))
        }
        return result
    }
}

extension Date {
    func adding(months: Int, calendar: Calendar = Calendar(identifier: .gregorian)) -> Date {
        return calendar.date(byAdding: .month, value: months, to: self)!
    }
}

