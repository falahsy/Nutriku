//
//  ViewController.swift
//  Nutriku
//
//  Created by Syamsul Falah on 18/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import UIKit
import CoreData

class FoodListVC: UITableViewController {

    var listFood = [String]()
    
    var food: Food?
    var retrivedFood: Food?
    
    let segueIdToDetailFood = "toDetailFoodSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveDataFood()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFood.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodListCell", for: indexPath)
        cell.textLabel?.text = listFood[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createDataFood(foodName: String, energy: Int, sugar: Double, sfa: Double, sodium: Int, fruit: Int, fiber: Double, protein: Double) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let foodEntity = NSEntityDescription.entity(forEntityName: "FoodEntity", in: manageContext)!
        
        let food = NSManagedObject(entity: foodEntity, insertInto: manageContext)
        
        food.setValue(protein, forKey: "protein")
        food.setValue(energy, forKey: "energy")
        food.setValue(fiber, forKey: "fiber")
        food.setValue(foodName, forKey: "foodName")
        food.setValue(fruit, forKey: "fruit")
        food.setValue(sfa, forKey: "sfa")
        food.setValue(sodium, forKey: "sodium")
        food.setValue(sugar, forKey: "sugar")
        
        do {
           try manageContext.save()
        } catch let error as NSError {
            print("Could't save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveDataFood() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodEntity")
        
        do {
            let result = try manageContext.fetch(fetchRequest)
            listFood.removeAll()
            
            for data in result as! [NSManagedObject] {
                listFood.append(data.value(forKey: "foodName") as! String)
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func retrieveDetailDataFood(foodNameRetrievedTo: String) -> Food {
        var retrievedFood: Food!
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return retrievedFood }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodEntity")
        
        do {
            let result = try manageContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "foodName") as! String == foodNameRetrievedTo {
                    let foodName = data.value(forKey: "foodName") as! String
                    let energy = data.value(forKey: "energy") as! Int
                    let sugar = data.value(forKey: "sugar") as! Double
                    let sfa = data.value(forKey: "sfa") as! Double
                    let sodium = data.value(forKey: "sodium") as! Int
                    let fruit = data.value(forKey: "fruit") as! Int
                    let fiber = data.value(forKey: "fiber") as! Double
                    let protein = data.value(forKey: "protein") as! Double
                    
                    retrievedFood = Food(foodName: foodName, energy: energy, sugar: sugar, sfa: sfa, sodium: sodium, fruitAndVege: fruit, fibers: fiber, proteins: protein)
                }
            }
        } catch {
            print("Failed")
        }
        return retrievedFood
    }
    
    func updateDataFood(){
        
    }
    
    func deleteDataFood(){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdToDetailFood {
            let destinationVc = segue.destination as? DetailFoodVC
            let foodIndex = tableView.indexPathForSelectedRow?.row
            
            retrivedFood = retrieveDetailDataFood(foodNameRetrievedTo: listFood[foodIndex!])
            
            destinationVc?.foodName = retrivedFood?.foodName
            destinationVc?.energy = retrivedFood?.energy
            destinationVc?.sugar = retrivedFood?.sugar
            destinationVc?.sfa = retrivedFood?.sfa
            destinationVc?.sodium = retrivedFood?.sodium
            destinationVc?.fruit = retrivedFood?.fruitAndVege
            destinationVc?.fiber = retrivedFood?.fibers
            destinationVc?.protein = retrivedFood?.proteins
        }
    }
    
    
    @IBAction func unwindToListFood(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        if sourceViewController is AddNewFoodVC {
            if let senderVc = sourceViewController as? AddNewFoodVC {
                let newFood = senderVc.food
                
                createDataFood(foodName: newFood!.foodName, energy: newFood!.energy, sugar: newFood!.sugar, sfa: newFood!.sfa, sodium: newFood!.sodium, fruit: newFood!.fruitAndVege, fiber: newFood!.fibers, protein: newFood!.proteins)
                retrieveDataFood()
            }
        }
        tableView.reloadData()
    }
}
