//
//  AddNewFoodVC.swift
//  Nutriku
//
//  Created by Syamsul Falah on 18/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import UIKit

class AddNewFoodVC: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var sugarTextField: UITextField!
    @IBOutlet weak var sfaTextField: UITextField!
    @IBOutlet weak var sodiumTextField: UITextField!
    @IBOutlet weak var fruitTextField: UITextField!
    @IBOutlet weak var fiberTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    
    var foodName: String!
    var energy, sodium, fruit: Int!
    var sugar, sfa, fiber, protein: Double!
    var food: Food!
    
    var flagIsTextFillCompleted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proteinTextField.delegate = self
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.hideKeyboardWhenTapArround()
    }
    
    deinit {
        //Stop listening for keyboard event
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -55
        } else {
            view.frame.origin.y = 0
        }
    }
    
    
    @IBAction func saveFoodToList(_ sender: UIBarButtonItem) {
        if foodNameTextField.text != "" && energyTextField.text != "" && sugarTextField.text != "" && sfaTextField.text != "" && sodiumTextField.text != "" && fruitTextField.text != "" && fiberTextField.text != "" && proteinTextField.text != "" {
            
            performSegue(withIdentifier: "unwindToFoodList", sender: self)
        } else {
            let alert = UIAlertController(title: "Warning", message: "All Field must be filled in", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newFoodName = foodNameTextField.text {
            foodName = newFoodName
        }
        if let newEnergy = energyTextField.text {
            energy = Int(newEnergy)
        }
        if let newSugar = sugarTextField.text  {
            sugar = Double(newSugar)
        }
        if let newSfa = sfaTextField.text {
            sfa = Double(newSfa)
        }
        if let newSodium = sodiumTextField.text {
            sodium = Int(newSodium)
        }
        if let newFruit = fruitTextField.text {
            fruit = Int(newFruit)
        }
        if let newFiber = fiberTextField.text {
            fiber = Double(newFiber)
        }
        if let newProtein = proteinTextField.text {
            protein = Double(newProtein)
        }
        food = Food(foodName: foodName, energy: energy, sugar: sugar, sfa: sfa, sodium: sodium, fruitAndVege: fruit, fibers: fiber, proteins: protein)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTapArround() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
