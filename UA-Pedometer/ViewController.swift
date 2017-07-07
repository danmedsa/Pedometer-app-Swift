//
//  ViewController.swift
//  UA-Pedometer
//
//  Created by Daniel Medina Sada on 6/30/17.
//  Copyright © 2017 Daniel Medina Sada. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!

    let pedometer = CMPedometer()
    let DaysOfInfo = 8
    var days: [Day] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        accessPedometerdata()         // Retrieve information from Pedometer
    }
    
    override func viewDidAppear(_ animated: Bool) {

        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? DayInfoCell
        
        let day = days[indexPath.row]
        
        cell?.configureCell(day: day)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        detailVC?.day = day
        detailVC?.title = day.dateAsString()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.pushViewController(detailVC!,animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func simulate(){
        //Simulation if no Pedometer Available

        for i in 0...DaysOfInfo{
            let dTemp: Day = Day(date: getDate(ago: i), steps: Int(arc4random() % 5000) + 1000, dist: Int(arc4random() % 5000) + 1000, avgPace: Double(arc4random() % 10) + 5.0)
            days.append(dTemp)
        }
    }
    
    func setMidnight(day: Date) -> Date{
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.month, .day, .year], from: day)
        components.hour = 19 //TimeZone Difference
        components.minute = 0
        components.second = 0
        return calendar.date(from: components)!
    }
    
    func getDate(ago: Int) -> Date{
        var date = Calendar.current.date(byAdding: .day, value: -ago, to: Date())
        date = setMidnight(day: date!)
        return date!
    }
    
    func createDay(day: Day, data: CMPedometerData!){
        if data != nil{
            day.steps = Int(data.numberOfSteps)
            day.distance = data.distance as! Int
            day.avgPace = data.averageActivePace as! Double
            self.days.append(day)
            tableView.reloadData()
        }
    }
    
    func accessPedometerdata(){
        if(CMPedometer.isStepCountingAvailable()){
            
            for i in 0...DaysOfInfo-1 {
                self.pedometer.queryPedometerData(from: getDate(ago: i+1), to: getDate(ago: i), withHandler: { (data : CMPedometerData!, error) -> Void in
                    if let dat = data {
                        let day = Day(date: self.getDate(ago: i), steps: 0, dist: 0, avgPace: 0)
                        self.createDay(day: day, data: dat)
                    }
                    
                })
            }
        }else{
            simulate()
        }
    }
    
    @IBAction func refreshData(_ sender: Any) {
        days = []
        accessPedometerdata()
        tableView.reloadData()
    }
    
}

