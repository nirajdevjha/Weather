//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Niraj Jha on 12/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    let units = Unit.allCases
    private var _selectedUnit: Unit = Unit.fahrenheit
    
    var selectedUnit: Unit {
        get {
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: "unit") as? String {
                return Unit(rawValue: value)!
            }
            
            return _selectedUnit
        }
        set {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newValue.rawValue, forKey: "unit")
        }
    }
    
}
