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
        let dataEntries = generateRandomEntries()
        
        chartView.dataEntries = dataEntries
        chartView.isCurved = true
    }


    private func generateRandomEntries() -> [PointEntry] {
        var result: [PointEntry] = []
        for i in 0..<100 {
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
