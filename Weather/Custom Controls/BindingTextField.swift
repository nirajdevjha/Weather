//
//  BindingTextField.swift
//  Weather
//
//  Created by Niraj Jha on 13/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChangeClosure: (String) -> () = {_ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            textChangeClosure(text)
        }
    }
}
