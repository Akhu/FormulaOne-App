//
//  FOApi.swift
//  FormulaOne
//
//  Created by Anthony Da Cruz on 15/02/2024.
//

import Foundation
struct FormulaAPI {
    static let host = "ergast.com"
    static let scheme = "https"
    
    static let feedPath = "/api/f1/2024.json"
    
    func thisYearSeason() -> URL? {
        var components = URLComponents()
        components.host = FormulaAPI.host
        components.scheme = FormulaAPI.scheme
        components.path = FormulaAPI.feedPath
        return components.url
    }
    
}
