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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.textColor = .tertiarySystemGroupedBackground
        label.text = "  $"
        leftView = label
        leftView?.tintColor = .tertiarySystemGroupedBackground
        leftViewMode = .always
    }
}
