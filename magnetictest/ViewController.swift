//
//  ViewController.swift
//  magnetictest
//
//  Created by 相場智也 on 2022/08/17.
//

import UIKit

class ViewController: UIViewController, MotionSensorDelegate {

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let magneticmodel = MotionSensor()
        magneticmodel.delegate = self
        
        magneticmodel.start()
        
    }
    
    func UpdateView(x: String, y: String, z: String) {
        xLabel.text = x
        yLabel.text = y
        zLabel.text = z
    }
}

