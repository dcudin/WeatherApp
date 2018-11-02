//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Dogukan Cudin on 1.11.2018.
//  Copyright © 2018 Dogukan Cudin. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    var temp = Double()
    var temp_min=Double()
    var temp_max=Double()
    var pressure=Double()
    var humidity=Double()
    var weatherMain=String()
    var weatherDescription=String()
    var windSpeed=Double()
    var dt_text=String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        labelTime.text = dt_text
        labelTemperature.text = "\(temp) C   Min: \(temp_min) C   Max: \(temp_max) C"
        labelDescription.text = "\(weatherMain)   -   \(weatherDescription)"
        labelHumidity.text = "Humidity :\(humidity) Pressure: \(pressure) Wind: \(windSpeed)"
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
