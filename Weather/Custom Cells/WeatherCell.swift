//
//  WeatherCell.swift
//  Weather
//
//  Created by Niraj Jha on 09/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.cityNameLabel?.text = vm.name.value
        self.temperatureLabel?.text = "\(vm.currentTemperature.temperature.value.formatAsDegree)"
    }
    
}
