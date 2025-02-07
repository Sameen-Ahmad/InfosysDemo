//
//  AssmentTaskDemoTests.swift
//  AssmentTaskDemoTests
//
//  Created by Sameer on 07/02/25.
//

import XCTest
@testable import AssmentTaskDemo

    class AssmentTaskDemoTests: XCTestCase {
        
        func testToggleOrder() {
            let viewModel = CityViewModel()
            viewModel.citiesByState = [
                StateCities(key: "State1", value: [
                    City(city: "CityA", admin_name: "State1", population: "1000"),
                    City(city: "CityB", admin_name: "State1", population: "2000")
                ]),
                StateCities(key: "State2", value: [
                    City(city: "CityC", admin_name: "State2", population: "3000")
                ])
            ]

            let originalOrder = viewModel.citiesByState
            viewModel.toggleOrder()

            // Ensure the order has been reversed correctly
            XCTAssertEqual(viewModel.citiesByState, originalOrder.reversed(), "Toggle order should reverse the citiesByState array")
        }

        func testToggleOrderPerformance() {
            let viewModel = CityViewModel()
            viewModel.citiesByState = (1...1000).map { index in
                StateCities(key: "State\(index)", value: [
                    City(city: "City\(index)A", admin_name: "State\(index)", population: "\(index * 1000)"),
                    City(city: "City\(index)B", admin_name: "State\(index)", population: "\(index * 2000)")
                ])
            }
            
            measure {
                viewModel.toggleOrder()
            }
        }
    }


struct StateCities: Equatable {
    static func == (lhs: StateCities, rhs: StateCities) -> Bool {
        <#code#>
    }
    
    let key: String
    let value: [City]
}

class CityViewModel {
    var citiesByState: [StateCities] = []
    
    func toggleOrder() {
        citiesByState.reverse()
    }
}
