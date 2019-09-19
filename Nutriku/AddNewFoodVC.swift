//
//  AddNewFoodVC.swift
//  Nutriku
//
//  Created by Syamsul Falah on 18/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import UIKit

class AddNewFoodVC: UIViewController {

    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var energyTextField: UITextField!
    @IBOutlet weak var sugarTextField: UITextField!
    @IBOutlet weak var sfaTextField: UITextField!
    @IBOutlet weak var sodiumTextField: UITextField!
    @IBOutlet weak var fruitTextField: UITextField!
    @IBOutlet weak var fiberTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    
    var foodName: String!
    var energy, sugar, sfa, sodium, fruit, fiber, protein: Int!
    var food: Food!
    
    var flagIsTextFillCompleted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            sugar = Int(newSugar)
        }
        if let newSfa = sfaTextField.text {
            sfa = Int(newSfa)
        }
        if let newSodium = sodiumTextField.text {
            sodium = Int(newSodium)
        }
        if let newFruit = fruitTextField.text {
            fruit = Int(newFruit)
        }
        if let newFiber = fiberTextField.text {
            fiber = Int(newFiber)
        }
        if let newProtein = proteinTextField.text {
            protein = Int(newProtein)
        }
        food = Food(foodName: foodName, energy: energy, sugar: sugar, sfa: sfa, sodium: sodium, fruitAndVege: fruit, fibers: fiber, proteins: protein)
    }
}
