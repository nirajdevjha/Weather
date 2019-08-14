//
//  AddWeatherViewController.swift
//  Weather
//
//  Created by Niraj Jha on 12/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

//
//  AddWeatherViewController.swift
//  Weather
//
//  Created by Niraj Jha on 09/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate: class {
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind {
                self.addCityViewModel.city = $0
            }
        }
    }
    @IBOutlet weak var stateNameTextField: BindingTextField! {
        didSet {
            stateNameTextField.bind {
                self.addCityViewModel.state = $0
            }
        }
    }
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind {
                self.addCityViewModel.zipCode = $0
            }
        }
    }
    
    weak var delegate: AddWeatherDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveCityButtonPressed(_ sender: UIButton) {
        
        if let city = cityNameTextField.text {
            
            // get the default settings for temperature
            let userDefaults = UserDefaults.standard
            var unit = ""
            if let value = userDefaults.value(forKey: "unit") as? String {
                unit = value
            }
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=7d2dd8c9c5578b741c7735ad3f0d39ea&units=\(unit)")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM!
            }
            
            Webservice().load(resource: weatherResource) { [weak self] result in
                if let weatherVM = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true)
        
    }
}
