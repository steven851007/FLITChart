//
//  InvestmenReturnsSnapshotTests.swift
//  FLITChartTests
//
//  Created by Istvan Balogh on 05.12.21.
//

import XCTest
import FLITChart

class InvestmenReturnsSnapshotTests: XCTestCase {

    func test_feedWithContent() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light)), named: "INVESTMENTRETURNS_WITH_CONTENT_light")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .dark)), named: "INVESTMENTRETURNS_WITH_CONTENT_dark")
        assert(snapshot: sut.snapshot(for: .iPhone13(style: .light, contentSize: .extraExtraExtraLarge)), named: "INVESTMENTRETURNS_WITH_CONTENT_light_extraExtraExtraLarge")
    }
    
    private func makeSUT() -> InvestmenReturnsViewController {
        let bundle = Bundle(for: InvestmenReturnsViewController.self)
        let storyboard = UIStoryboard(name: "InvestmentReturns", bundle: bundle)
        let controller = (storyboard.instantiateInitialViewController() as! UINavigationController).viewControllers.first! as! InvestmenReturnsViewController
        controller.loadViewIfNeeded()
        return controller
    }
}
