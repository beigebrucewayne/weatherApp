override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    forecastTbl.delegate = self
    forecastTbl.dataSource = self
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
        locationManager.requestWhenInUseAuthorization()
        // After requesting, viewDidLoad() will exit and then nothing happens until the user allows location services
    } else {
        getLocationAndWeather()
    }
}

func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    locationManager.startMonitoringSignificantLocationChanges()
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        getLocationAndWeather()
    }
}

func getLocationAndWeather() {
    currentLocation = locationManager.location
    Location.sharedInstance.latitude = currentLocation.coordinate.latitude
    Location.sharedInstance.longitude = currentLocation.coordinate.longitude
    self.currentWeather.downloadWeather {
        // Once weather has been downloaded, download forecast
        print("Downloaded today's weather successfully")
        self.forecast.downloadForecast {
            print("Downloaded forecast successfully")
            // Set UI to new weather and forecast data
            self.updateWeatherUI()
            self.forecastTbl.reloadData()
        }
        
    }
} 