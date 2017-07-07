//
//  DayInfo.swift
//  UA-Pedometer
//
//  Created by Daniel Medina Sada on 6/30/17.
//  Copyright © 2017 Daniel Medina Sada. All rights reserved.
//

import Foundation


class Day : NSObject {
    
    private var _date: Date!
    private var _steps: Int!
    private var _distance: Int!
    private var _avgPace: Double!
    
    var steps: Int {
        get{
            return _steps
        }
        
        set{
            if newValue > 0{
                _steps =  newValue
            }
        }
    }
    
    
    var distance: Int {
        get{
            return _distance
        }
        set{
            if newValue > 0 {
                _distance = newValue
            }
        }
    }
    
    var avgPace: Double{
        get{
            return _avgPace
        }
        set{
            _avgPace = round( newValue * 100 ) / 100    //Round to 2 decimals
        }
    }
    
    var date: Date{
        get{
            return _date
        }
    }
    
        override init() {
            super.init()
            self._date = Date()
            self.steps = 0
            self._steps = 0
            self._distance = 0
            self._avgPace = 0
        }
        
    init(date: Date, steps: Int, dist: Int, avgPace: Double){
            super.init()
            self._date = date
            self.steps = steps
            self._distance = dist
            self._avgPace = avgPace
        }
    
    func addSteps(newSteps: Int){
        self.steps += newSteps
    }
    
    func addDistance(newDistance: Int){
        self.distance += newDistance
    }
    
    
    func distanceInKilometers() -> Double{
        let kms = Double(self.distance) / 1000.0
        return round( kms * 100 ) / 100
    }
    
    func dateAsString() -> String{
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        
        return df.string(from: self.date)
    }
    
}
