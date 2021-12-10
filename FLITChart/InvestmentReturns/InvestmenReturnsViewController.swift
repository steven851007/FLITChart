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
    
    func textfieldValuesChanged() {
        guard let initialInvestmentText = initialInvestmentTextField.text,
              let initialInvestment = NumberFormatter.chartCurrencyFormatter.number(from: initialInvestmentText),
              let monthlyContributionText = monthlyContributionTextField.text,
              let monthlyContribution = NumberFormatter.chartCurrencyFormatter.number(from: monthlyContributionText) else {
                  return
              }
        
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        let model = InvestmentReturnsModel(initialInvestment: NSDecimalNumber(decimal: initialInvestment.decimalValue), monthlyContribution: NSDecimalNumber(decimal: monthlyContribution.decimalValue), annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
        
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
            textField.text = finalString.currency

            // returning 'false' so that textfield will not be updated here, instead from styling extension
            textfieldValuesChanged()
            return false
        }
}

extension String {
    var currency: String {
        // removing all characters from string before formatting
        let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
        let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")

        if let result = NumberFormatter().number(from: stringWithoutComma) {
            return NumberFormatter.chartCurrencyFormatter.string(from: result)!
        }

        return self
    }
}
