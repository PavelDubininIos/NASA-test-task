//
//  Date+extension.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import Foundation

extension Date {
    
    func toStringFormate(_ formateTo: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formateTo
        return dateFormatter.string(from: self)
    }    
}
