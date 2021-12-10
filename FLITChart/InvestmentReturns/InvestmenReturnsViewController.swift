//
//  ViewController.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import UIKit

class ChartGradientView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setGradientBackground(colorTop: .systemBlue, colorBottom: .systemBackground)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradientBackground(colorTop: .systemBlue, colorBottom: .systemBackground)
    }
    
    private var gradientLayer = CAGradientLayer()
    
    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
            gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds

            layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

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
        
        initialInvestmentTextField.leftView = UIImageView(image: UIImage(named: "email.png"))
        initialInvestmentTextField.leftViewMode = .always
    }
    func editingChanged() {
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
