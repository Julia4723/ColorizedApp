//
//  MainViewController.swift
//  HW 2
//
//  Created by user on 21.03.2024.
//  Copyright © 2024 Alexey Efimov. All rights reserved.
//

import UIKit

//MARK: - Protocol

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

//MARK: - Class
final class StartViewController: UIViewController, SettingsViewControllerDelegate {

    
  //Надо передать данные о цвете во вью на другом экране
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SettingsViewController
        settingsVC?.colorViewItem = self.view.backgroundColor
        settingsVC?.delegate = self

    }
    
    func setColor(_ color: UIColor) {
        self.view.backgroundColor = color
        
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        let settingsVC = segue.source as? SettingsViewController
        settingsVC?.delegate = self
        setColor(view.backgroundColor ?? .black)
    }

}



