//
//  ContentView.swift
//  AssmentTaskDemo
//
//  Created by Sameer on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CityViewModel()
    @State private var expandedStates: Set<String> = []
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.citiesByState, id: \ .key) { state, cities in
                    Section(header: Text(state).onTapGesture {
                        toggleExpansion(for: state)
                    }) {
                        if expandedStates.contains(state) {
                            ForEach(cities) { city in
                                HStack {
                                    Text(city.city)
                                    Spacer()
                                    Text(city.population)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Australian Cities")
            .toolbar {
                Button("Reverse List") {
                    viewModel.toggleOrder()
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
        //.preferredColorScheme(.automatic)
    }
    
    private func toggleExpansion(for state: String) {
        if expandedStates.contains(state) {
            expandedStates.remove(state)
        } else {
            expandedStates.insert(state)
        }
    }
}
