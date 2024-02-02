//
//  ViewController.swift
//  Weather
//
//  Created by white4ocolate on 01.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!

    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter City", message: nil, style: .alert)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
    }


}

