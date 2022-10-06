//
//  Model.swift
//  NASA-test-task
//
//  Created by Павел Дубинин on 07.10.2022.
//

import Foundation

struct NasaModel: Decodable {
    let links: Links?
    let near_earth_objects: [String: [Asteroid]]?
}

struct Links: Decodable {
    let next: String?
    let previous: String?
    let selfLink: String?
    
    enum CodingKeys: String, CodingKey {
        case next, previous
        case selfLink = "self"
    }
}

struct Asteroid: Decodable {
    let links: Links?
    let id: String?
    let name: String?
    let estimated_diameter: Diameter?
    let is_sentry_object: Bool?
    let close_approach_data: [CloseApproachData]?
}

struct Diameter: Decodable {
    let kilometers: DiameterValue?
    let meters: DiameterValue?
}

struct DiameterValue: Decodable {
    let estimated_diameter_min: Double?
    let estimated_diameter_max: Double?
}

struct CloseApproachData: Decodable {
    let close_approach_date: String?
    let miss_distance: MissDistance?
}

struct MissDistance: Decodable {
    let kilometers: String?
}
