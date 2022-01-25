//
//  settingsViewController.swift
//  Proctoring 101
//
//  Created by Krishi Tripuraneni on 6/3/20.
//  Copyright © 2020 Krishi Tripuraneni. All rights reserved.
//

import UIKit

class SATsettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var titleLabel: UILabel!
    var smallTime: UILabel!
    var bigTime: UILabel!
    var normalTime: UILabel!
    
    var smallSwitch: UISwitch!
    var bigSwitch: UISwitch!
    var normalSwitch: UISwitch!
    
    
    // MARK: - Function Creations
    @objc func changeNormalTime() {
        if(satViewController.timings.isSmallExtendedTime == true) {
            satViewController.timings.isSmallExtendedTime = false
            smallSwitch.setOn(false, animated: true)
            
        }
        else if(satViewController.timings.isBigExtendedTime == true) {
            satViewController.timings.isSmallExtendedTime = false
            bigSwitch.setOn(false, animated: true)
        }
        else {
            normalSwitch.setOn(true, animated: true)
        }
        savePreferences()
    }
    
    @objc func changeSmallTime() {
        if(satViewController.timings.isSmallExtendedTime == false) {
            satViewController.timings.isSmallExtendedTime = true
            satViewController.timings.isBigExtendedTime = false
            bigSwitch.setOn(false, animated: true)
            normalSwitch.setOn(false, animated: true)
        }
        else {
            satViewController.timings.isSmallExtendedTime = false
            normalSwitch.setOn(true, animated: true)
        }
        savePreferences()
    }
    
    @objc func changeBigTime() {
        if(satViewController.timings.isBigExtendedTime == false) {
            satViewController.timings.isBigExtendedTime = true
            satViewController.timings.isSmallExtendedTime = false
            smallSwitch.setOn(false, animated: true)
            normalSwitch.setOn(false, animated: true)
        }
        else {
            satViewController.timings.isBigExtendedTime = false
            normalSwitch.setOn(true, animated: true)
        }
        savePreferences()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkForDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: - Content Creation
        titleLabel = UILabel()
         titleLabel.font=UIFont(name: "Spartan-Black", size: 50)
         titleLabel.text=" Settings "
         titleLabel.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
         titleLabel.sizeToFit()
         titleLabel.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/5))
         
         normalSwitch = UISwitch()
         normalSwitch.center=CGPoint(x: self.view.bounds.width*(2/3), y: self.view.bounds.height*(5/10))
         normalSwitch.addTarget(self, action: #selector(changeSmallTime), for: .primaryActionTriggered)
         
         normalTime = UILabel()
         normalTime.font=UIFont(name: "Spartan-Black", size: 20)
         normalTime.text=" Standard Time  "
         normalTime.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
         normalTime.sizeToFit()
         normalTime.center=CGPoint(x: self.view.bounds.width/3, y: self.view.bounds.height*(5/10))
         
         smallSwitch = UISwitch()
         smallSwitch.center=CGPoint(x: self.view.bounds.width*(2/3), y: self.view.bounds.height*(6/10))
         smallSwitch.addTarget(self, action: #selector(changeSmallTime), for: .primaryActionTriggered)
         
         smallTime = UILabel()
         smallTime.font=UIFont(name: "Spartan-Black", size: 20)
         smallTime.text=" 1.5 Extra Time:  "
         smallTime.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
         smallTime.sizeToFit()
         smallTime.center=CGPoint(x: self.view.bounds.width/3, y: self.view.bounds.height*(6/10))
         
         
         bigSwitch = UISwitch()
         bigSwitch.center=CGPoint(x: self.view.bounds.width*(2/3), y: self.view.bounds.height*(7/10))
         bigSwitch.addTarget(self, action: #selector(changeBigTime), for: .primaryActionTriggered)
        
         
         bigTime = UILabel()
         bigTime.font=UIFont(name: "Spartan-Black", size: 20)
         bigTime.text=" 2.0 Extra Time:  "
         bigTime.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
         bigTime.sizeToFit()
         bigTime.center=CGPoint(x: self.view.bounds.width/3, y: self.view.bounds.height*(7/10))
        
        
        
        view.backgroundColor = UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0)
        self.view.addSubview(titleLabel)
        self.view.addSubview(smallSwitch)
        self.view.addSubview(bigSwitch)
        self.view.addSubview(normalSwitch)
        self.view.addSubview(normalTime)
        self.view.addSubview(smallTime)
        self.view.addSubview(bigTime)
        
        
        checkForDefaults()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @objc func savePreferences() {
        defaults.set(satViewController.timings.isBigExtendedTime, forKey: "wantedSATBigTime")
        defaults.set(satViewController.timings.isSmallExtendedTime, forKey: "wantedSATSmallTime")
    }
    
    @objc func checkForDefaults() {
        let stillWantBigTime = defaults.bool(forKey: "wantedSATBigTime")
        let stillWantSmallTime = defaults.bool(forKey: "wantedSATSmallTime")
        
        if(stillWantBigTime) {
            bigSwitch.setOn(true, animated: true)
        }
        
        if(stillWantSmallTime) {
            smallSwitch.setOn(true, animated: true)
        }
    }
    
    
    
    
}
