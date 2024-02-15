//
//  HomeState.swift
//  FormulaOne
//
//  Created by Anthony Da Cruz on 15/02/2024.
//

import Foundation
import SwiftUI

class HomeState: ObservableObject {
    
    @MainActor @Published var races: [Race]?
    
    @MainActor @Published var loadingError: Error?
    
    @MainActor func handleResult<T>(result: Result<T, Error>, storeIn: inout T?) {
        do {
            storeIn = try result.get()
        } catch let error as DecodingError {
            loadingError = error
            switch error {
            case .typeMismatch(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .valueNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .keyNotFound(let key, let value):
                print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
            case .dataCorrupted(let key):
                print("error \(key), and ERROR: \(error.localizedDescription)")
            default:
                print("ERROR: \(error.localizedDescription)")
            }
        } catch {
            loadingError = error
        }
    }
    

    func loadSeason() async {
        guard let feedUrl = FormulaAPI().thisYearSeason() else { return }
        
        let fetchTask = Task { () -> [Race] in
            let (data, _) = try await URLSession.shared.data(from: feedUrl)
            let response = try JSONDecoder().decode(F1ApiResponse.self, from: data)
            return response.mrData.raceTable.races
        }
        
        let result = await fetchTask.result
        
        await MainActor.run {
            handleResult(result: result, storeIn: &races)
        }
    }
}
