//
//  ModelCity.swift
//  AssmentTaskDemo
//
//  Created by Sameer on 07/02/25.
//

import Foundation
import SwiftUI

// Model for City
struct City: Identifiable, Codable {
    let id = UUID()
    let city: String
    let admin_name: String
    let population: String
    
    enum CodingKeys: String, CodingKey {
        case city, admin_name, population
    }
}


// ViewModel following MVVM
class CityViewModel: ObservableObject {
    @Published var citiesByState: [(key: String, value: [City])] = []
        @Published var reversed = false
    
    init() {
        loadCities()
    }
    
    func loadCities() {
           if let url = Bundle.main.url(forResource: "au_cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedCities = try? JSONDecoder().decode([City].self, from: data) {
               
               let groupedCities = Dictionary(grouping: decodedCities, by: { $0.admin_name })
               citiesByState = groupedCities.sorted { $0.key < $1.key }
           }
       }
    
    func toggleOrder() {
            reversed.toggle()
            citiesByState = citiesByState.map { (key: $0.key, value: reversed ? $0.value.reversed() : $0.value) }
            citiesByState.reverse()
        }
}
