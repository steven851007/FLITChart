//
//  InvestmentReturnsViewModel.swift
//  FLITChart
//
//  Created by Istvan Balogh on 03.12.21.
//

import Foundation
import UIKit

public struct PointEntry {
    public let value: Int
    public let label: String
    
    public init(value: Int, label: String) {
        self.value = value
        self.label = label
    }
}

extension PointEntry: Comparable {
    public static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    public static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value && lhs.label == rhs.label
    }
}

public struct InvestmentReturnsViewModel {
    public let initialInvestmentValue: String
    public let initialInvestmentText = "Initial Investment"
    public let monthlyContributionValue: String
    public let monthlyContributionText = "Monthly Contribution"
    
    public let returnsWorstCase: [PointEntry]
}
