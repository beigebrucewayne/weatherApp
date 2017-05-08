//
//  Location.swift
//  weatherApp
//
//  Created by WOLVERINE on 5/8/17.
//  Copyright © 2017 WOLVERINE. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
