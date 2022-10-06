//
//  DataBase.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 02.10.2022.
//

import Foundation

let dataBase = DataBase()

class DataBase {
    
    var nasaKey: String {
        return "hoRDDsmcBdUntxwQLytzQqrKAbTtCfoy6mtdvMW7"
    }
    
    var dateFormate: String {
        return "yyyy-MM-dd"
    }
    
    fileprivate init() {}
}
