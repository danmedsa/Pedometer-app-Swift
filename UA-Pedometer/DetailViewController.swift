//
//  DetailViewController.swift
//  UA-Pedometer
//
//  Created by Daniel Medina Sada on 6/30/17.
//  Copyright © 2017 Daniel Medina Sada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var stepsLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var avgPaceLbl: UILabel!
    
    var day: Day!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
                
        if let thisDay = day{
            stepsLbl.text = "Steps: \(thisDay.steps)"
            distanceLbl.text = "Distance: \(thisDay.distanceInKilometers()) Kms"
            avgPaceLbl.text = "Average Pace: \(thisDay.avgPace)"
        }
    }

}
