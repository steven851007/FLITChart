//
//  ViewController.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import UIKit

public class InvestmenReturnsViewController: UIViewController {

    @IBOutlet weak var initialInvestmentTextField: UITextField!
    @IBOutlet weak var chartView: LineChart!
    @IBOutlet weak var monthlyContributionTextField: UITextField!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        let model = InvestmentReturnsModel(initialInvestment: 10000, monthlyContribution: 500, annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
        
        let viewModel = InvestmentReturnsPresenter.map(model)
        display(viewModel)
        
        
    }
    func editingChanged() {
        guard let initialInvestmentText = initialInvestmentTextField.text,
              let initialInvestment = currencyFormatter.number(from: initialInvestmentText) else {
                  print("not valid")
                  return
              }
        
        print("valid")
        
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        let model = InvestmentReturnsModel(initialInvestment: NSDecimalNumber(decimal: initialInvestment.decimalValue), monthlyContribution: NSDecimalNumber(decimal: 500), annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
        
        let viewModel = InvestmentReturnsPresenter.map(model)
        display(viewModel)
    }
    
    
    
    private var currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.alwaysShowsDecimalSeparator = false
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencySymbol = ""
        currencyFormatter.generatesDecimalNumbers = false
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter
    }()
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let initialInvestmentText = initialInvestmentTextField.text,
              let initialInvestment = currencyFormatter.number(from: initialInvestmentText) else {
            return
        }
        
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        let model = InvestmentReturnsModel(initialInvestment: NSDecimalNumber(decimal: initialInvestment.decimalValue), monthlyContribution: NSDecimalNumber(decimal: 500), annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
        
        let viewModel = InvestmentReturnsPresenter.map(model)
        display(viewModel)
    }
    
    public func display(_ investmentReturns: InvestmentReturnsViewModel) {
        initialInvestmentTextField.text = investmentReturns.initialInvestmentValue
        monthlyContributionTextField.text = investmentReturns.monthlyContributionValue
        
        chartView.clean()
        chartView.addDataEntry(investmentReturns.returnsWorstCase, entry2: investmentReturns.returnsAverageBottomCase, entry3: investmentReturns.returnsAverageTopCase, entry4: investmentReturns.returnsBestCase)
    }
}

extension InvestmenReturnsViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let text: NSString = (textField.text ?? "") as NSString
            let finalString = text.replacingCharacters(in: range, with: string)

            // 'currency' is a String extension that doews all the number styling
            initialInvestmentTextField.text = finalString.currency

            // returning 'false' so that textfield will not be updated here, instead from styling extension
            editingChanged()
            return false
        }
}

extension String {
    var currency: String {
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")

        let styler = NumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 0
        styler.currencySymbol = "$"
        styler.numberStyle = .currency

        if let result = NumberFormatter().number(from: stringWithoutComma) {
            return NumberFormatter.chartCurrencyFormatter.string(from: result)!
        }

        return self
    }
}
