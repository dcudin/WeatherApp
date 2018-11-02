//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dogukan Cudin on 1.11.2018.
//  Copyright © 2018 Dogukan Cudin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var textFieldCityName: UITextField!
    @IBOutlet weak var tableviewCity: UITableView!
    
    @IBAction func buttonGetWeather(_ sender: Any) {
        
        loadWeatherDataByCityName(cityName: textFieldCityName.text!)
        
    }
    
    var cityArray:[String] = []
    
    
    var weatherDataObjectArray:[WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        let  savedArray = defaults.object(forKey: "CheckedCities") as? [String] ?? [String]()
        if(savedArray.count>0)
        {
            cityArray = savedArray
            tableviewCity.reloadData()
        }
        
        
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return cityArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CELL_ID = "CityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? WeatherHourCell
        
        cell?.labelHourInterval.text = cityArray[indexPath.row]
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        loadWeatherDataByCityName(cityName: cityArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        if (segue.identifier == "HourListSegue") {
            
            let viewController:WeatherHourListViewController = segue.destination as! WeatherHourListViewController
            viewController.weatherDataObjectArray = [WeatherData] ()
            viewController.weatherDataObjectArray = sender as! [WeatherData]
        }
        
    }


    
    func loadWeatherDataByCityName(cityName:String)
    {
        weatherDataObjectArray = [WeatherData] ()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "HH:mm      dd/MM/yyyy"
        
        
        let urlAsString = "https://api.openweathermap.org/data/2.5/forecast?q="+cityName+"&units=metric&APPID=8827fbf408dc7e1418f3c1e84596334c"
        
        let url:URL = URL(string: urlAsString)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        
        let task = session.dataTask(with: request as URLRequest) {data, response, error in
            
           // Constants.alkolJSONList = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
            
            
            //     let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //     print(dataString!)
            
            let json = try! JSONSerialization.jsonObject(with: data!, options: [])
          //  print(json)
            
            let dictApiData = (json as! NSDictionary) as NSDictionary
            
            if let arrayAllWeatherData = dictApiData["list"] as? NSArray
            {
                for item in arrayAllWeatherData {
                    
                    var temp = Double()
                    var temp_min = Double()
                    var temp_max = Double()
                    var pressure = Double()
                    var humidity = Double()
                    var weatherMain = String()
                    var weatherDescription = String()
                    var windSpeed = Double()
                    var dt_text = String()
                    
                    let dictionaryWeatherTopics = item as! NSDictionary
                    
                    let dictionaryMain = dictionaryWeatherTopics["main"] as! NSDictionary
                    
                    if let temperatureData = dictionaryMain["temp"] as? Double
                    {
                        temp = temperatureData
                    }
                    
                    if let temperature_minData = dictionaryMain["temp_min"] as? Double
                    {
                        temp_min = temperature_minData
                    }
                    
                    if let temperature_maxData = dictionaryMain["temp_max"] as? Double
                    {
                        temp_max = temperature_maxData
                    }
                    
                    if let pressureData = dictionaryMain["pressure"] as? Double
                    {
                        pressure = pressureData
                    }
                    
                    if let humidityData = dictionaryMain["humidity"] as? Double
                    {
                        humidity = humidityData
                    }
                    
                    let arrayDictionaryWeather = dictionaryWeatherTopics["weather"] as! NSArray
                    
                    let dictionaryWeather = arrayDictionaryWeather[0] as? NSDictionary
                    
                    if let weatherMainData = dictionaryWeather?["main"] as? String
                    {
                        weatherMain = weatherMainData
                    }
                    
                    if let weatherDescriptionData = dictionaryWeather?["description"] as? String
                    {
                        weatherDescription = weatherDescriptionData
                        print(weatherDescription)
                    }
                    
                    let dictionaryWind = dictionaryWeatherTopics["wind"] as! NSDictionary
                    
                    if let windData = dictionaryWind["speed"] as? Double
                    {
                        windSpeed = windData
                    }
                    
                    if let weatherTime = dictionaryWeatherTopics["dt_txt"] as? String
                    {
                        let yourDate = formatter.date(from: weatherTime)
                        dt_text = formatter2.string(from: yourDate!)
                    }
                    
                    let weatherDataObject = WeatherData(temp: temp, temp_min: temp_min, temp_max: temp_max, pressure: pressure, humidity: humidity, weatherMain: weatherMain, weatherDescription: weatherDescription, windSpeed: windSpeed,dt_text:dt_text)
                    
                    self.weatherDataObjectArray.append(weatherDataObject)
                    if(!self.cityArray.contains(self.textFieldCityName.text!))
                    {
                        self.cityArray.append(self.textFieldCityName.text!)
                        let defaults = UserDefaults.standard
                        defaults.set(self.cityArray, forKey: "CheckedCities")
                        
                        self.tableviewCity.reloadData()
                    }
                    else
                    {
                        print("no")
                    }
                    
                    
                }
            }
            else
            {
                DispatchQueue.main.async(execute: {
                    
                    print("city not found")
                    let alert = UIAlertController(title: "Alert", message: "City not found!!!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                    
                })
                
                
            }
            
            
           
            
            

            
            DispatchQueue.main.async(execute: {
                
                self.performSegue(withIdentifier: "HourListSegue", sender: self.weatherDataObjectArray)
                
                /*
                let defaults = UserDefaults.standard
                defaults.set(Constants.alkolJSONList, forKey: "alkolData")
                print("checked alcoholList")
 */
                
            })
            
            
        }
        
        task.resume()
    }

}

