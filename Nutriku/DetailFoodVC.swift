//
//  DetailFoodVC.swift
//  Nutriku
//
//  Created by Syamsul Falah on 19/09/19.
//  Copyright © 2019 Falah. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

class DetailFoodVC: UIViewController {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var sfaLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var fruitLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var buttonAddToHealthData: UIButton!
    @IBOutlet weak var nutriScoreImageView: UIImageView!
    
    var nutriScorePoint: Int!
    var foodName: String!
    var energy, sodium, fruit: Int!
    var sugar, sfa, fiber, protein: Double!
    
    var healthStore: HKHealthStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAddToHealthData.layer.cornerRadius = 10
        requestPermitionHealthKit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        foodNameLabel.text = ": \(foodName!)"
        energyLabel.text = ": \(String(energy)) kkal"
        sugarLabel.text = ": \(String(sugar)) gram"
        sfaLabel.text = ": \(String(sfa)) gram"
        sodiumLabel.text = ": \(String(sodium)) miligram"
        fruitLabel.text = ": \(String(fruit)) %"
        fiberLabel.text = ": \(String(fiber)) gram"
        proteinLabel.text = ": \(String(protein)) gram"
        
        getLabelNutriSocre()
    }
    
    func requestPermitionHealthKit(){
        healthStore = HKHealthStore()
        
        let requestType = Set([HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
                               HKObjectType.quantityType(forIdentifier: .dietarySugar)!,
                               HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)!,
                               HKObjectType.quantityType(forIdentifier: .dietarySodium)!,
                               HKObjectType.quantityType(forIdentifier: .dietaryFiber)!,
                               HKObjectType.quantityType(forIdentifier: .dietaryProtein)!])
        
        healthStore?.requestAuthorization(toShare: requestType, read: requestType, completion: { (inAuthorized, error) in
            if inAuthorized {
                print("You're in authorize")
            } else {
                fatalError("Fatal error is not Authorized")
            }
        })
    }

    
    @IBAction func addNutritionDataToHealthData(_ sender: UIButton) {
        saveDietaryEnergy(energyValue: energy)
        saveDietarySugar(sugarValue: sugar)
        saveDietaryFatSaturated(fatValue: sfa)
        saveDietarySodium(sodiumValue: sodium)
        saveDietaryFiber(fiberValue: fiber)
        saveDietaryProtein(proteinValue: protein)
        
        let alert = UIAlertController(title: "Success", message: "Nutrition data has been saved to health data", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveDietaryEnergy(energyValue: Int) {
        guard let energyType = HKSampleType.quantityType(forIdentifier: .dietaryEnergyConsumed) else { return }
        let unit = HKUnit.kilocalorie()
        let quantity = HKQuantity(unit: unit, doubleValue: Double(energyValue))
        let today = Date()
        
        let energyQuantitySample = HKQuantitySample(type: energyType, quantity: quantity, start: today, end: today)
        healthStore?.save(energyQuantitySample, withCompletion: { (success, error) in
            print("Energy data has been saved")
        })
    }
    
    func saveDietarySugar(sugarValue: Double) {
        guard let sugarType = HKSampleType.quantityType(forIdentifier: .dietarySugar) else { return }
        let unit = HKUnit.gram()
        let quantity = HKQuantity(unit: unit, doubleValue: sugarValue)
        let today = Date()
        
        let sugarQuantitySample = HKQuantitySample(type: sugarType, quantity: quantity, start: today, end: today)
        healthStore?.save(sugarQuantitySample, withCompletion: { (success, error) in
            print("Sugar data has been saved")
        })
    }
    
    func saveDietaryFatSaturated(fatValue: Double) {
        guard let fatSaturatedType = HKSampleType.quantityType(forIdentifier: .dietaryFatSaturated) else { return }
        let unit = HKUnit.gram()
        let quantity = HKQuantity(unit: unit, doubleValue: fatValue)
        let today = Date()
        
        let fatSaturatedQuantitySample = HKQuantitySample(type: fatSaturatedType, quantity: quantity, start: today, end: today)
        healthStore?.save(fatSaturatedQuantitySample, withCompletion: { (success, error) in
            print("Fat saturated data has been saved")
        })
    }
    
    func saveDietarySodium(sodiumValue: Int) {
        guard let sodiumType = HKSampleType.quantityType(forIdentifier: .dietarySodium) else { return }
        let unit = HKUnit.gramUnit(with: .milli)
        let quantity = HKQuantity(unit: unit, doubleValue: Double(sodiumValue))
        let today = Date()
        
        let sodiumQuantitySample = HKQuantitySample(type: sodiumType, quantity: quantity, start: today, end: today)
        healthStore?.save(sodiumQuantitySample, withCompletion: { (success, error) in
            print("Sodium data has been saved")
        })
    }
    
    func saveDietaryFiber(fiberValue: Double) {
        guard let fiberType = HKSampleType.quantityType(forIdentifier: .dietaryFiber) else { return }
        let unit = HKUnit.gram()
        let quantity = HKQuantity(unit: unit, doubleValue: fiberValue)
        let today = Date()
        
        let fiberQuantitySample = HKQuantitySample(type: fiberType, quantity: quantity, start: today, end: today)
        healthStore?.save(fiberQuantitySample, withCompletion: { (success, error) in
            print("Fiber data has been saved")
        })
    }
    
    func saveDietaryProtein(proteinValue: Double) {
        guard let proteinType = HKSampleType.quantityType(forIdentifier: .dietaryProtein) else { return }
        let unit = HKUnit.gram()
        let quantity = HKQuantity(unit: unit, doubleValue: proteinValue)
        let today = Date()
        
        let proteinQuantitySample = HKQuantitySample(type: proteinType, quantity: quantity, start: today, end: today)
        healthStore?.save(proteinQuantitySample, withCompletion: { (success, error) in
            print("Protein data has been saved")
        })
    }
    
    func getLabelNutriSocre() {
        
        let energyPoint = getEnergyPoint(energyValue: energy)
        let sugarPoint = getSugarPoint(sugarValue: Double(sugar))
        let sfaPoint = getSfaPoint(sfaValue: Double(sfa))
        let sodiumPoint = getSodiumPoint(sodiumValue: sodium)
        
        let fruitPoint = getFruitValue(fruitValue: fruit)
        let fiberPoint = getFiberValue(fiberValue: Double(fiber))
        let proteinPoint = getProteinValue(proteinValue: Double(protein))
        
        let redZone = energyPoint + sugarPoint + sfaPoint + sodiumPoint
        let greenZone = fruitPoint + fiberPoint + proteinPoint
        
        nutriScorePoint = redZone - greenZone
        
        switch nutriScorePoint! {
        case (-15)...(-1):
            nutriScoreImageView.image = UIImage(named: "nutriScoreA")
        case 0...2:
            nutriScoreImageView.image = UIImage(named: "nutriScoreB")
        case 3...10:
            nutriScoreImageView.image = UIImage(named: "nutriScoreC")
        case 11...18:
            nutriScoreImageView.image = UIImage(named: "nutriScoreD")
        default:
            nutriScoreImageView.image = UIImage(named: "nutriScoreE")
        }
    }
    
    // Nilai Zona MERAH
    func getEnergyPoint(energyValue: Int) -> Int {
        let energyKJ = Double(energyValue) * 4.2
        
        switch energyKJ {
        case 0 ... 335:
            return 0
        case 336 ... 670:
            return 1
        case 671 ... 1005:
            return 2
        case 1006 ... 1340:
            return 3
        case 1341 ... 1675:
            return 4
        case 1676 ... 2010:
            return 5
        case 2011 ... 2345:
            return 6
        case 2346 ... 2680:
            return 7
        case 2681 ... 3015:
            return 8
        case 3016 ... 3350:
            return 9
        default:
            return 10
        }
    }
    
    // Nilai Zona MERAH
    func getSugarPoint(sugarValue: Double) -> Int {
        switch sugarValue {
        case 0 ... (4.5):
            return 0
        case 4.6 ..< 9:
            return 1
        case 9 ..< (13.5):
            return 2
        case 13,5 ..< 18:
            return 3
        case 18 ..< (22.5):
            return 4
        case 22,5 ..< 27:
            return 5
        case 27 ..< 31:
            return 6
        case 31 ..< 36:
            return 7
        case 36 ..< 40:
            return 8
        case 40 ..< 45:
            return 9
        default:
            return 10
        }
    }
    
    // Nilai Zona MERAH
    func getSfaPoint(sfaValue: Double) -> Int {
        switch sfaValue {
        case 0 ... 1:
            return 0
        case 1.1 ... 2:
            return 1
        case 2.1 ... 3:
            return 2
        case 3.1 ... 4:
            return 3
        case 4.1 ... 5:
            return 4
        case 5.1 ... 6:
            return 5
        case 6.1 ... 7:
            return 6
        case 7.1 ... 8:
            return 7
        case 8.1 ... 9:
            return 8
        case 9.1 ... 10:
            return 9
        default:
            return 10
        }
    }
    
    // Nilai Zona MERAH
    func getSodiumPoint(sodiumValue: Int) -> Int {
        switch sodiumValue {
        case 0 ... 90:
            return 0
        case 91 ... 180:
            return 1
        case 181 ... 270:
            return 2
        case 271 ... 360:
            return 3
        case 361 ... 450:
            return 4
        case 451 ... 540:
            return 5
        case 541 ... 630:
            return 6
        case 631 ... 720:
            return 7
        case 721 ... 810:
            return 8
        case 811 ... 900:
            return 9
        default:
            return 10
        }
    }

    //Nilai Zona Hijau
    func getFruitValue(fruitValue: Int) -> Int {
        switch fruitValue {
        case 0 ... 40:
            return 0
        case 41 ... 60:
            return 1
        case 61 ... 80:
            return 2
        default:
            return 5
        }
    }
    
    //Nilai Zona Hijau
    func getFiberValue(fiberValue: Double) -> Int {
        switch fiberValue {
        case 0 ... 0.9:
            return 0
        case 1 ... 1.9:
            return 1
        case 2 ... 2.8:
            return 2
        case 2.9 ... 3.7:
            return 3
        case 3.8 ... 4.7:
            return 4
        default:
            return 5
        }
    }
    
    func getProteinValue(proteinValue: Double) -> Int {
        switch proteinValue {
        case 0 ... 1.6:
            return 0
        case 1.7 ... 3.2:
            return 1
        case 3.3 ... 4.8:
            return 2
        case 4.9 ... 6.4:
            return 3
        case 6.5 ... 8.0:
            return 4
        default:
            return 5
        }
    }
}
