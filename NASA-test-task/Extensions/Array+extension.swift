//
//  Array+extension.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 11.10.2022.
//

import UIKit

extension Array {
    
    func removeConstraints() {
        self.forEach {
            ($0 as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

