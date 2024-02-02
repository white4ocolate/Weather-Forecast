//
//  ViewController+alertController.swift
//  Weather
//
//  Created by white4ocolate on 02.02.2024.
//

import Foundation
import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { textField in
            let cities = ["Kyiv", "Warsaw", "New York", "London"]
            textField.placeholder = cities.randomElement()
        }
        let searchAction = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            print("textField?.text = \(textField?.text)")
            if !cityName.isEmpty {
                print("Searching info for City \(cityName)........")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
