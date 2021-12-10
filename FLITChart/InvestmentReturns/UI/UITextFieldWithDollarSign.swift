//
//  UITextFieldWithDollarSign.swift
//  FLITChart
//
//  Created by Istvan Balogh on 10.12.21.
//

import UIKit

class UITextFieldWithDollarSign: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDollarSign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addDollarSign()
    }
    
    private func addDollarSign() {
        let largeConfig = UIImage.SymbolConfiguration(scale: .large)
        leftView = UIImageView(image: UIImage(systemName: "dollarsign.square", withConfiguration: largeConfig))
        leftView?.tintColor = .tertiarySystemGroupedBackground
        leftViewMode = .always
    }
}
