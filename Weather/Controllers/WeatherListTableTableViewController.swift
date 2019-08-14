//
//  WeatherListTableTableViewController.swift
//  Weather
//
//  Created by Niraj Jha on 09/08/19.
//  Copyright © 2019 Niraj Jha. All rights reserved.
//

import UIKit

class WeatherListTableTableViewController: UITableViewController {
    
     private var weatherListViewModel = WeatherListViewModel()
     private var lastUnitSelection: Unit!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.lastUnitSelection = Unit(rawValue: value)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddWeatherViewController" {
            prepareSegueForAddWeatherCityViewController(segue: segue)
            
        } else if segue.identifier == "SettingsTableViewController" {
            prepareSegueForSettingstableViewController(segue: segue)
        } else if segue.identifier == "WeatherDetailsViewController" {
            prepareSegureForWeatherDetailsViewController(segue: segue)
        }
        
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let addWeatherVC = nav.viewControllers.first as? AddWeatherViewController else {
            fatalError("AddWeatherView controller not found")
        }
        
        addWeatherVC.delegate = self
    }
    
    private func prepareSegueForSettingstableViewController(segue: UIStoryboardSegue) {
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("Navigation controller not found")
        }
        
        guard let settingsTVC = nav.viewControllers.first as? SettingsTableViewController else {
            fatalError("AddWeatherView controller not found")
        }
        
        settingsTVC.delegate = self
    }
    
    private func prepareSegureForWeatherDetailsViewController(segue: UIStoryboardSegue) {
        guard let weatherDetailsVC = segue.destination as? WeatherDetailsViewController,
        let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        weatherDetailsVC.weatherViewModel = weatherVM
    }

}

extension WeatherListTableTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as! WeatherCell
        let weatherVM = weatherListViewModel.modelAt(indexPath.row)
        cell.configure(weatherVM)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}

extension WeatherListTableTableViewController : AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel) {
        weatherListViewModel.addWeatherViewmodel(vm)
        tableView.reloadData()
    }
}

extension WeatherListTableTableViewController: SettingsDelegate {
    func settingsDone(vm: SettingsViewModel) {
        if self.lastUnitSelection.rawValue != vm.selectedUnit.rawValue {
            weatherListViewModel.updateUnit(to: vm.selectedUnit)
            tableView.reloadData()
            self.lastUnitSelection = Unit(rawValue: vm.selectedUnit.rawValue)
        }
       
    }
}
