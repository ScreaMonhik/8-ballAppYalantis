//
//  SettingsViewController.swift
//  8-ballAppYalantis
//
//  Created by Dima Sunko on 13.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var ballYes: UIButton!
    @IBOutlet weak var ballDoesnt: UIButton!
    @IBOutlet weak var ballNotWorth: UIButton!
    @IBOutlet weak var ballDoIt: UIButton!
    @IBOutlet weak var ballChangeMind: UIButton!
    
    var testArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballYes.layer.cornerRadius = 10
        ballDoesnt.layer.cornerRadius = 10
        ballDoIt.layer.cornerRadius = 10
        ballNotWorth.layer.cornerRadius = 10
        ballChangeMind.layer.cornerRadius = 10
        
        testButtonSave(buttonName: ballYes)
        testButtonSave(buttonName: ballDoesnt)
        testButtonSave(buttonName: ballDoIt)
        testButtonSave(buttonName: ballNotWorth)
        testButtonSave(buttonName: ballChangeMind)
        
        
    }
    
    // MARK: - Actions
    
    @IBAction func ballYesTap(_ sender: Any) {
        buttonStatementChange(buttonName: ballYes)
    }
    
    @IBAction func ballDoesntTap(_ sender: Any) {
        buttonStatementChange(buttonName: ballDoesnt)
    }
    
    @IBAction func ballNotWorthTap(_ sender: Any) {
        buttonStatementChange(buttonName: ballNotWorth)
    }
    
    @IBAction func ballDoItTap(_ sender: Any) {
        buttonStatementChange(buttonName: ballDoIt)
    }
    
    @IBAction func ballChangeMindTap(_ sender: Any) {
        buttonStatementChange(buttonName: ballChangeMind)
    }
    
    
    // MARK: - Functions
    func buttonStatementChange(buttonName: UIButton) {
        
        if buttonName.alpha == 0.5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                buttonName.alpha = 1
                self.testArray.append((buttonName.titleLabel?.text)!)
                print(self.testArray)
            }
        } else {
                buttonName.alpha = 0.5
        
            for i in testArray {
                if i == buttonName.titleLabel?.text {
                    testArray = testArray.filter(){$0 != i}
                }
            }
        }
        
    }
    
    func testButtonSave(buttonName: UIButton) {
        for i in testArray {
            if i == buttonName.titleLabel?.text {
                buttonName.alpha = 1
            }
        }
    }
    
    
    
}
