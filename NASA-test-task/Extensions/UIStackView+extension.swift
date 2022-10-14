//
//  UIStackView+extension.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 12.10.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(_ axis: NSLayoutConstraint.Axis,
                               _ distribution:UIStackView.Distribution,
                               _ alignment: UIStackView.Alignment,
                               _ spacing: CGFloat,
                               _ arrangedSubviews: [UIView] ) {
            self.init(arrangedSubviews: arrangedSubviews)
            self.axis = axis
            self.distribution = distribution
            self.alignment = alignment
            self.spacing = spacing
            self.backgroundColor = .clear
        }
}


