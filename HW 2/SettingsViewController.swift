//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.

import UIKit


//MARK: - Class
final class SettingsViewController: UIViewController {
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var colorViewItem: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true //скрываем кнопку назад

        
        colorView.layer.cornerRadius = 15

        setColor()

        redLabel.text = string(from: redSlider) // Получаем значение слайдера
        greenLabel.text = string(from: greenSlider) // Получаем значение слайдера
        blueLabel.text = string(from: blueSlider) // Получаем значение слайдера
        colorView.backgroundColor = colorViewItem
        
        redTF.text = string(from: redSlider)
        greenTF.text = string(from: greenSlider)
        blueTF.text = string(from: blueSlider)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
    }
    
    
    //По тапу на кнопку Done передаем цвет инициализируем передачу цвета
    @IBAction func DoneButtonDidTapped() {
        delegate?.setColor(colorView.backgroundColor ?? .black)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTF.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTF.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTF.text = string(from: blueSlider)
        }
    }
    
    
    
    // метод передает цвет, который берет из слайдера
    internal func setColor() {
        colorView.backgroundColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1
           
        )
    }
    
    // метод округляет значение слайдера
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}


//MARK: - Extentions


extension Float {
    func cgFloat() -> CGFloat {
        CGFloat(self)
    }
}

extension SettingsViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        colorViewItem = color
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
            case redTF:
                redSlider.value = currentValue
            case greenTF:
                greenSlider.value = currentValue
            default:
                blueSlider.value = currentValue
            }
            
            setColor()
            
        } else {
           showAlert(withTitle: "Wrong value", andMessage: "Wrong value")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.returnKeyType = .done
        return true
        
    }
    
}



extension SettingsViewController {
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alert.addAction(okAction)
    }
    
}



