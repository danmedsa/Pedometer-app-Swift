//
//  DayInfoCell.swift
//  UA-Pedometer
//
//  Created by Daniel Medina Sada on 6/30/17.
//  Copyright © 2017 Daniel Medina Sada. All rights reserved.
//

import Foundation
import UIKit

class DayInfoCell : UITableViewCell {
    
    @IBOutlet weak var stepsImg: UIImageView!
    @IBOutlet weak var distImg: UIImageView!
    @IBOutlet weak var paceImg: UIImageView!
    @IBOutlet weak var stepLbl: UILabel!
    @IBOutlet weak var distLbl: UILabel!
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    func configureCell(day: Day){
        self.stepLbl.text = "Steps:\(day.steps)"
        self.distLbl.text = "Dist:\(day.distanceInKilometers())Kms"
        self.paceLbl.text = "Pace:\(day.avgPace)"
        self.dateLbl.text = day.dateAsString()
    }
    
}
