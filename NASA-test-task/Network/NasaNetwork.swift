//
//  NasaNetwork.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 02.10.2022.
//

import Foundation

extension Network {
    
    func getAsteroids(startDate: String, endDate: String?, completion: @escaping (NasaModel?, Error?) -> Void) {
        let api = API.asteroids(startDate: startDate, endDate: endDate)
        var request = URLRequest(url: URL(string: api.path)!)
        request.httpMethod = api.method
        request.timeoutInterval = 30
        let task = URLSession.shared.dataTask(with: request) { data, response, erorr in
            guard let data = data, let value = try? JSONDecoder().decode(NasaModel.self, from: data) else {
                return completion(nil, erorr) }
            return completion(value, nil)
            }
        task.resume()
    }
}
