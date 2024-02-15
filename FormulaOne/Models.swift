//
//  Models.swift
//  FormulaOne
//
//  Created by Anthony Da Cruz on 15/02/2024.
//

import Foundation
struct F1ApiResponse: Decodable {
    let mrData: MRData
    
    private enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct MRData: Decodable {
    let raceTable: RaceTable
    
    private enum CodingKeys: String, CodingKey {
        case raceTable = "RaceTable"
    }
}

struct RaceTable: Decodable {
    let season: String
    let races: [Race]
    
    private enum CodingKeys: String, CodingKey {
        case season = "season"
        case races = "Races"
    }
}

struct Race: Decodable {
    let season: String
    let round: String
    let url: String
    let raceName: String
    let circuit: Circuit
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case season = "season"
        case round = "round"
        case url = "url"
        case raceName = "raceName"
        case circuit = "Circuit"
        case date = "date"
    }
}

struct Circuit: Decodable {
    let circuitId: String
    let url: String
    let circuitName: String
    let location: Location
    
    private enum CodingKeys: String, CodingKey {
        case circuitId = "circuitId"
        case url = "url"
        case circuitName = "circuitName"
        case location = "Location"
    }
}

struct Location: Decodable {
    let lat: String
    let long: String
    let locality: String
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case long = "long"
        case locality = "locality"
        case country = "country"
    }
}
