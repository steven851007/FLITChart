//
//  ViewController.swift
//  FLITChart
//
//  Created by Istvan Balogh on 02.12.21.
//

import UIKit

public class InvestmenReturnsViewController: UIViewController {

    @IBOutlet weak var chartView: LineChart!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let annualReturns = AnnualReturnPercentages(worstCase: 2.15, averageWorstCase: 5.3, averageBestCase: 8.72, bestCase: 9.5)
        let model = InvestmentReturnsModel(initialInvestment: 10000, monthlyContribution: 500, annualReturns: annualReturns, lengthOfInvestmentInMonths: 12*31)
        
        let viewModel = InvestmentReturnsPresenter.map(model)
        display(viewModel)
    }
    
    public func display(_ investmentReturns: InvestmentReturnsViewModel) {
        chartView.addDataEntry(investmentReturns.returnsWorstCase, entry2: investmentReturns.returnsAverageBottomCase, entry3: investmentReturns.returnsAverageTopCase, entry4: investmentReturns.returnsBestCase)
    }


    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<10 {
            let value = Int(arc4random() % 500)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            
            result.append(PointEntry(value: value, label: formatter.string(from: date)))
        }
        return result
    }
}

