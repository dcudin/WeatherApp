//
//  WeatherHourListViewController.swift
//  WeatherApp
//
//  Created by Dogukan Cudin on 1.11.2018.
//  Copyright © 2018 Dogukan Cudin. All rights reserved.
//

import UIKit

class WeatherHourListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var weatherDataObjectArray:[WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return weatherDataObjectArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CELL_ID = "HourCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? WeatherHourCell
        
        cell?.labelHourInterval.text = weatherDataObjectArray[indexPath.row].dt_text
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "DetailSegue", sender: weatherDataObjectArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier == "DetailSegue") {
            
            let weatherDataObject = sender as! WeatherData
            
            let viewController:WeatherDetailViewController = segue.destination as! WeatherDetailViewController
            
            viewController.dt_text = weatherDataObject.dt_text
            viewController.humidity = weatherDataObject.humidity
            viewController.windSpeed = weatherDataObject.windSpeed
            viewController.pressure = weatherDataObject.pressure
            viewController.temp = weatherDataObject.temp
            viewController.temp_max = weatherDataObject.temp_max
            viewController.temp_min = weatherDataObject.temp_min
            viewController.weatherMain = weatherDataObject.weatherMain
            viewController.weatherDescription = weatherDataObject.weatherDescription
            
           // viewController.weatherDataObjectArray = [WeatherData] ()
          //  viewController.weatherDataObjectArray = sender as! [WeatherData]
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
