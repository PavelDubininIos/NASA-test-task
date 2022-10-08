//
//  Methods.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 02.10.2022.
//

import Foundation

enum HTTPMethods: String {
    case get
    case post
    case delete
    case put
}

extension HTTPMethods {
    var method: String {
        rawValue.uppercased()
    }
}
