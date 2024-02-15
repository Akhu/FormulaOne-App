//
//  ContentView.swift
//  FormulaOne
//
//  Created by Anthony Da Cruz on 15/02/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeState = HomeState()
    
    func daysUntil(dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let targetDate = dateFormatter.date(from: dateString) else {
            print("Erreur de formatage de la date")
            return nil
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let currentDateOnly = calendar.date(from: currentDateComponents)!
        let components = calendar.dateComponents([.day], from: currentDateOnly, to: targetDate)
        
        return components.day
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if let races = homeState.races {
                    List(races, id: \.self.url) { race in
                        VStack(alignment: .leading) {
                            Text("Round \(race.round)")
                                .font(.caption)
                            Text("\(daysUntil(dateString: race.date) ?? 0) days until the race")
                                .font(.caption)
                            Text(race.raceName)
                                .fontWeight(.heavy)
                                .fontWidth(.expanded)
                            Text(race.season)
                        }
                    }
                } else {
                    ProgressView()
                }
            }.navigationTitle("Formula One 🏎️")
        }.onAppear(perform: {
            Task {
                await homeState.loadSeason()
            }
        })
    }
}

#Preview {
    ContentView()
}
