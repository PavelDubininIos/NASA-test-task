//
//  API.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 02.10.2022.
//

import Foundation

enum API {
    
    case asteroids(startDate: String, endDate: String?)
}

extension API {
    
    var method: String {
        switch self {
        case .asteroids:
            return HTTPMethods.get.method
        }
    }
    
    var url: String {
        switch self {
        case .asteroids:
            return ServerModel.connect.url
        }
    }
    
    var path: String {
        switch self {
        case .asteroids(let startDate, let endDate):
            let endDate = endDate == nil ? "" : "&end_date=\(endDate!)"
            return url + "neo/rest/v1/feed?api_key=" + dataBase.nasaKey + "&start_date=\(startDate)" + endDate
        }
    }
}
