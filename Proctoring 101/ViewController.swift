//
//  ViewController.swift
//  Proctoring 101
//
//  Created by Krishi Tripuraneni on 5/22/20.
//  Copyright © 2020 Krishi Tripuraneni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel: UILabel!
    
    struct colors {
        static let darkBlue = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        static let offWhite = UIColor(red: 237/255.0, green: 234/255.0, blue: 229/255.0, alpha: 1.0)
        static let gray     = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        static let eggBlue  = UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0)
    }
    
    struct designColors {
        static var primaryColor     = colors.eggBlue
        static var secondaryColor   = colors.darkBlue
        static var accentColor      = colors.gray
        
    }
    
    
    @objc func goToSAT() {
        performSegue(withIdentifier: "satSegue", sender: self)
    }
    
    @objc func goToACT() {
        performSegue(withIdentifier: "actSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel = UILabel()
        titleLabel.font=UIFont(name: "Spartan-Black", size: 50)
        titleLabel.text=" iProctor "
        titleLabel.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        titleLabel.sizeToFit()
        titleLabel.center=CGPoint(x: self.view.bounds.width/2, y: 225)
        
        
        
        let sat = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        sat.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        sat.setTitle("SAT", for: .normal)
        sat.addTarget(self, action: #selector(goToSAT), for: .touchUpInside)
        sat.center=CGPoint(x: self.view.bounds.width*(1/3), y: 600)
        sat.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 50)
        
        
        let act = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        act.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        act.setTitle("ACT", for: .normal)
        act.addTarget(self, action: #selector(goToACT), for: .touchUpInside)
        act.center=CGPoint(x: self.view.bounds.width*(2/3), y: 600)
        act.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 50)
            
        
        view.backgroundColor = UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0)
        view.addSubview(titleLabel)
        self.view.addSubview(sat)
        self.view.addSubview(act)
        
        
        
    }
    

}
