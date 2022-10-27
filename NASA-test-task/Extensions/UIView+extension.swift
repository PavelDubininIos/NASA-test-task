//
//  UIView+extension.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 14.10.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    func makeShadowUnderView() {
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
    }
}
