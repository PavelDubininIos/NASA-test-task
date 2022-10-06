//
//  ServerModel.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 02.10.2022.
//

import Foundation

enum ServerModel {
    
    case prod
    case test
}

extension ServerModel {
    
    static var connect: ServerModel {
        return .prod
    }
    
    var url: String {
        switch self {
        case .prod:
            return "https://api.nasa.gov/"
        case .test:
            return String()
        }
    }
}
