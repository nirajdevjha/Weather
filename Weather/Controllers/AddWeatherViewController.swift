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
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    weak var delegate: AddWeatherDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveCityButtonPressed(_ sender: UIButton) {
        
        if let city = cityNameTextField.text {
            let weatherURL = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a9222962f206793991a79916d30883f2&units=imperial")!
            
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
