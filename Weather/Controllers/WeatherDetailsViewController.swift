//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Niraj Jha on 13/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var citynamelabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemplabel: UILabel!
    @IBOutlet weak var minTemplabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let weatherViewModel = weatherViewModel {
//            self.citynamelabel.text = weatherViewModel.name.value
//            self.currentTemperatureLabel.text = weatherViewModel.currentTemperature.temperature.value.formatAsDegree
//            self.maxTemplabel.text = weatherViewModel.currentTemperature.temperatureMin.value.formatAsDegree
//            self.minTemplabel.text = weatherViewModel.currentTemperature.temperatureMax.value.formatAsDegree
//        }
        
        setupVMBindings()
    }
    
    private func setupVMBindings() {
        if let weatherViewModel = weatherViewModel {
            weatherViewModel.name.bind { self.citynamelabel.text = $0 }
            weatherViewModel.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree}
        }
        
        //Change the value after few secs
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.weatherViewModel?.name.value = "Boston"
            
        }
    }

}
