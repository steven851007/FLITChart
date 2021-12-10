//
//  ChartGradientView.swift
//  FLITChart
//
//  Created by Istvan Balogh on 10.12.21.
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
