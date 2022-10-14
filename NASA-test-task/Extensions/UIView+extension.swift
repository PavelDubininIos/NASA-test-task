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
}
