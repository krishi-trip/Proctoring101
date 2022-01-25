//
//  satViewController.swift
//  Proctoring 101
//
//  Created by Krishi Tripuraneni on 6/2/20.
//  Copyright © 2020 Krishi Tripuraneni. All rights reserved.
//

import UIKit
import AVFoundation

class satViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    var audioPlayer = AVAudioPlayer()
    
    // Look at bottom
    var titleLabel: UILabel!
    
    var reading: UILabel!
    var writing: UILabel!
    var mathnc: UILabel!
    var mathc: UILabel!
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    var label4: UILabel!
    
    var scrollView: UIScrollView!
    
    var timeReading=0
    var timeWriting=0
    var timeMathnc=0
    var timeMathc=0
    
    var timerReading = Timer()
    var timerWriting = Timer()
    var timerMathnc = Timer()
    var timerMathc = Timer()
    
    var isReadingTimerRunning = false
    var isWritingTimerRunning = false
    var isMathncTimerRunning = false
    var isMathcTimerRunning = false
    
    struct timings {
        static var isBigExtendedTime = false
        static var isSmallExtendedTime = false
    }
    
    
    // MARK: - Function Creations
    @objc func goToSettings() {
        performSegue(withIdentifier: "SATsettingSegue", sender: self)
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "analog-watch-alarm_daniel-simion", ofType: ".mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func runReadingTimer() {
        label1.textAlignment = NSTextAlignment.center
        label2.textAlignment = NSTextAlignment.center
        label3.textAlignment = NSTextAlignment.center
        label4.textAlignment = NSTextAlignment.center
        
        timerReading = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(satViewController.updateReadingTimer)), userInfo: nil, repeats: true)
    }
    
    func runWritingTimer() {
        label2.textAlignment = NSTextAlignment.center
        
        timerWriting = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(satViewController.updateWritingTimer)), userInfo: nil, repeats: true)
    }
    
    func runMathncTimer() {
        label3.textAlignment = NSTextAlignment.center
        
        timerMathnc = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(satViewController.updateMathcTimer)), userInfo: nil, repeats: true)
    }
    
    func runMathcTimer() {
        label4.textAlignment = NSTextAlignment.center
        
        timerMathc = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(satViewController.updateMathcTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateReadingTimer() {
        if(timeReading>0) {
            timeReading -= 1
        }
        
        if(timeReading == 0) {
            self.playSound()
        }
        
        label1.text=timeString(time: TimeInterval(timeReading))
    }
    
    @objc func updateWritingTimer() {
        if(timeWriting>0) {
            timeWriting -= 1
        }
        
        if(timeWriting == 0) {
            self.playSound()
        }
        
        label2.text=timeString(time: TimeInterval(timeWriting))
    }
    
    @objc func updateMathncTimer() {
        if(timeMathnc>0) {
            timeMathnc -= 1
        }
        
        if(timeMathnc == 0) {
            self.playSound()
        }
        
        label3.text=timeString(time: TimeInterval(timeMathnc))
    }
    
    @objc func updateMathcTimer() {
        if(timeMathc>0) {
            timeMathc -= 1
        }
        
        if(timeMathc == 0) {
            self.playSound()
        }
        
        label4.text=timeString(time: TimeInterval(timeMathc))
    }
    
    func timeString(time:TimeInterval) -> String {
        if(time>=3600)
        {
            let hours = Int(time) / 60 / 60
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
        else if(time == 3599)
        {
            label1.textAlignment = NSTextAlignment.center
            label2.textAlignment = NSTextAlignment.center
            label3.textAlignment = NSTextAlignment.center
            label4.textAlignment = NSTextAlignment.center
            
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        }
        else
        {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i", minutes, seconds)
        }
        
    }
    
    
    // MARK: - Reading Methods
    @objc func SAT_READING_START(_ sender: Any) {
        audioPlayer.stop()
        if((self.isReadingTimerRunning == false) && (timeReading == 0)) {
            if(satViewController.timings.isBigExtendedTime == true)
            {
                timeReading=7_800
                
            }
            else if(satViewController.timings.isSmallExtendedTime == true)
            {
                timeReading=5_850
                
            }
            else
            {
                timeReading=3_900
                
            }
        }
        label1.text=timeString(time: TimeInterval(timeReading))
        
        if(self.isReadingTimerRunning == false)
        {
            runReadingTimer()
            isReadingTimerRunning=true
        }
        
    }
    @objc func SAT_READING_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isReadingTimerRunning == true) {
            timerReading.invalidate()
            self.isReadingTimerRunning = false
        }
        else {
            runReadingTimer()
            self.isReadingTimerRunning = true
        }
    }
    @objc func SAT_READING_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerReading.invalidate()
        self.isReadingTimerRunning = false
        timeReading = 0
        SAT_READING_START(self)
    }
    
    // MARK: - Writing Methods
    @objc func SAT_WRITING_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isWritingTimerRunning == false && (timeWriting == 0)) {
            if(satViewController.timings.isBigExtendedTime == true)
            {
                timeWriting=6_300
                
            }
            else if(satViewController.timings.isSmallExtendedTime == true)
            {
                timeWriting=4_725
                
            }
            else
            {
                timeWriting=3_150
                
            }
        }
        if(self.isWritingTimerRunning == false)
        {
            runWritingTimer()
            isWritingTimerRunning=true
        }
        
    }
    @objc func SAT_WRITING_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isWritingTimerRunning == true) {
            timerWriting.invalidate()
            self.isReadingTimerRunning = false
        }
        else {
            runWritingTimer()
            self.isWritingTimerRunning = true
        }
    }
    @objc func SAT_WRITING_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerWriting.invalidate()
        self.isWritingTimerRunning = false
        timeWriting=0
        SAT_WRITING_START(self)
    }
    
    // MARK: - Math No Calc Methods
    @objc func SAT_MATHnc_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathncTimerRunning == false && (timeMathc == 0)) {
            if(satViewController.timings.isBigExtendedTime == true)
            {
                timeMathnc=3_000
                
            }
            else if(satViewController.timings.isSmallExtendedTime == true)
            {
                timeMathnc=2_250
                
            }
            else
            {
                timeMathnc=1_500
                
            }
        }
        if(self.isMathncTimerRunning == false)
        {
            runMathncTimer()
            isMathncTimerRunning=true
        }
        
    }
    @objc func SAT_MATHnc_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathncTimerRunning == true) {
            timerMathnc.invalidate()
            self.isMathncTimerRunning = false
        }
        else {
            runMathncTimer()
            self.isMathncTimerRunning = true
        }
    }
    @objc func SAT_MATHnc_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerMathnc.invalidate()
        self.isReadingTimerRunning = false
        timeMathnc=0
        SAT_MATHnc_START(self)
    }
    
    
    // MARK: - Math Calc Methods
    @objc func SAT_MATHc_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathcTimerRunning == false && (timeMathc == 0)) {
            if(satViewController.timings.isBigExtendedTime == true)
            {
                timeMathc=6_300
                
            }
            else if(satViewController.timings.isSmallExtendedTime == true)
            {
                timeMathc=4_725
                
            }
            else
            {
                timeMathc=3_150
                
            }
        }
        if(self.isMathcTimerRunning == false)
        {
            runMathcTimer()
            isMathcTimerRunning=true
        }
        
    }
    @objc func SAT_MATHc_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathcTimerRunning == true) {
            timerMathc.invalidate()
            self.isMathcTimerRunning = false
        }
        else {
            runMathcTimer()
            self.isMathcTimerRunning = true
        }
    }
    @objc func SAT_MATHc_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerMathc.invalidate()
        self.isMathcTimerRunning = false
        timeMathc=0
        SAT_MATHc_START(self)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    @objc func startTest() {
        scrollToPage(page: 1, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        checkForDefaults()
        
        // MARK: - Labels
        titleLabel = UILabel()
        titleLabel.font=UIFont(name: "Spartan-Black", size: 60)
        titleLabel.text=" SAT "
        titleLabel.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        titleLabel.sizeToFit()
        titleLabel.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        reading = UILabel()
        reading.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        reading.text=" Reading "
        reading.textColor = UIColor(red: 237/255.0, green: 234/255.0, blue: 229/255.0, alpha: 1.0)
        reading.sizeToFit()
        reading.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        writing = UILabel()
        writing.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        writing.text=" Writing "
        writing.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        writing.sizeToFit()
        writing.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        mathnc = UILabel()
        mathnc.font=UIFont(name: "Spartan-ExtraBold", size: 40)
        mathnc.text=" Math No-Calc "
        mathnc.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        mathnc.sizeToFit()
        mathnc.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        mathc = UILabel()
        mathc.font=UIFont(name: "Spartan-ExtraBold", size: 45)
        mathc.text=" Math Calc "
        mathc.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        mathc.sizeToFit()
        mathc.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        label1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label1.font=UIFont(name: "Spartan-SemiBold", size: 50)
        label1.text=" 00:00:00 "
        label1.textColor = UIColor(red: 237/255.0, green: 234/255.0, blue: 229/255.0, alpha: 1.0)
        label1.sizeToFit()
        label1.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
      
        
        label2 = UILabel()
        label2.font=UIFont(name: "Spartan-SemiBold", size: 50)
        label2.text=" 00:00:00 "
        label2.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        label2.sizeToFit()
        label2.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        label3 = UILabel()
        label3.font=UIFont(name: "Spartan-SemiBold", size: 50)
        label3.text=" 00:00:00 "
        label3.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        label3.sizeToFit()
        label3.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2 + 25)
        
        label4 = UILabel()
        label4.font=UIFont(name: "Spartan-SemiBold", size: 50)
        label4.text=" 00:00:00 "
        label4.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        label4.sizeToFit()
        label4.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        // MARK: - Buttons
        
        let satStart = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        satStart.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(2/3))
        satStart.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        satStart.titleLabel?.sizeToFit()
        satStart.titleLabel?.font=UIFont(name: "Spartan-Regular", size: 40)
        satStart.setTitle("Start", for: .normal)
        satStart.setTitleColor(UIColor(red: 255/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0), for: .normal)
        satStart.layer.cornerRadius = 75
        satStart.layer.masksToBounds = true
        satStart.addTarget(self, action: #selector(startTest), for: .touchUpInside)
        
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button1.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button1.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button1.titleLabel?.font=UIFont(name: "Spartan-Regular", size: 20)
        button1.setTitle("Start", for: .normal)
        button1.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button1.layer.cornerRadius = 50
        button1.layer.masksToBounds = true
        button1.addTarget(self, action: #selector(SAT_READING_START), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button2.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button2.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button2.titleLabel?.font = UIFont(name: "Spartan-Regular", size: 20)
        button2.setTitle("Pause", for: .normal)
        button2.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button2.layer.cornerRadius = 50
        button2.layer.masksToBounds = true
        button2.addTarget(self, action: #selector(SAT_READING_PAUSE), for: .touchUpInside)
        
        let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button3.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button3.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button3.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button3.setTitle("Reset", for: .normal)
        button3.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button3.layer.cornerRadius = 50
        button3.layer.masksToBounds = true
        button3.addTarget(self, action: #selector(SAT_READING_RESET), for: .touchUpInside)
        
        let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button4.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button4.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button4.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button4.setTitle("Start", for: .normal)
        button4.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button4.layer.cornerRadius = 50
        button4.layer.masksToBounds = true
        button4.addTarget(self, action: #selector(SAT_WRITING_START), for: .touchUpInside)
        
        let button5 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button5.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button5.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button5.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button5.setTitle("Pause", for: .normal)
        button5.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button5.layer.cornerRadius = 50
        button5.layer.masksToBounds = true
        button5.addTarget(self, action: #selector(SAT_WRITING_PAUSE), for: .touchUpInside)
        
        let button6 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button6.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button6.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button6.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button6.setTitle("Reset", for: .normal)
        button6.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button6.layer.cornerRadius = 50
        button6.layer.masksToBounds = true
        button6.addTarget(self, action: #selector(SAT_WRITING_RESET(_:)), for: .touchUpInside)
        
        let button7 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button7.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button7.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button7.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button7.setTitle("Start", for: .normal)
        button7.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button7.layer.cornerRadius = 50
        button7.layer.masksToBounds = true
        button7.addTarget(self, action: #selector(SAT_MATHnc_START), for: .touchUpInside)
        
        let button8 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button8.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button8.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button8.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button8.setTitle("Pause", for: .normal)
        button8.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button8.layer.cornerRadius = 50
        button8.layer.masksToBounds = true
        button8.addTarget(self, action: #selector(SAT_MATHnc_PAUSE), for: .touchUpInside)
        
        let button9 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button9.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button9.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button9.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button9.setTitle("Reset", for: .normal)
        button9.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button9.layer.cornerRadius = 50
        button9.layer.masksToBounds = true
        button9.addTarget(self, action: #selector(SAT_MATHnc_RESET), for: .touchUpInside)
        
        let button10 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button10.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button10.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button10.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button10.setTitle("Start", for: .normal)
        button10.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button10.layer.cornerRadius = 50
        button10.layer.masksToBounds = true
        button10.addTarget(self, action: #selector(SAT_MATHc_START), for: .touchUpInside)
        
        let button11 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button11.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button11.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button11.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button11.setTitle("Pause", for: .normal)
        button11.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button11.layer.cornerRadius = 50
        button11.layer.masksToBounds = true
        button11.addTarget(self, action: #selector(SAT_MATHc_PAUSE), for: .touchUpInside)
        
        let button12 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button12.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button12.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button12.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button12.setTitle("Reset", for: .normal)
        button12.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button12.layer.cornerRadius = 50
        button12.layer.masksToBounds = true
        button12.addTarget(self, action: #selector(SAT_MATHc_RESET), for: .touchUpInside)
        
        
        // MARK: - Page Set-Up
        
        // Scroll View Set-up
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        let numPages: CGFloat=5
        scrollView.contentSize=CGSize(width: self.view.bounds.width * numPages, height: self.view.bounds.height)
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=true
        self.view.addSubview(scrollView)
        
        // Title Page
        let page1View = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page1View.backgroundColor = UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0)
        page1View.addSubview(titleLabel)
        
        let SATsettings = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 50))
        SATsettings.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        SATsettings.setTitle("SAT Settings", for: .normal)
        SATsettings.setTitleColor(UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0), for: .normal)
        SATsettings.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        SATsettings.center=CGPoint(x: self.view.bounds.width/4, y: 100)
        
        page1View.addSubview(SATsettings)
        
        page1View.addSubview(satStart)
        
        scrollView.addSubview(page1View)
        
        // Reading
        let page2View = UIScrollView(frame: CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page2View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page2View.addSubview(label1) // Add label
        page2View.addSubview(reading)
        page2View.addSubview(button1) // Add buttons
        page2View.addSubview(button2)
        page2View.addSubview(button3)
        
        scrollView.addSubview(page2View)
        
        // Writing
        let page3View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 2, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page3View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page3View.addSubview(label2) // Add label
        page3View.addSubview(writing)
        page3View.addSubview(button4) // Add buttons
        page3View.addSubview(button5)
        page3View.addSubview(button6)
        
        scrollView.addSubview(page3View)
        
        // Math no-calc
        let page4View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 3, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page4View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page4View.addSubview(label3) // Add label
        page4View.addSubview(mathnc)
        page4View.addSubview(button7) // Add buttons
        page4View.addSubview(button8)
        page4View.addSubview(button9)
        
        scrollView.addSubview(page4View)
        
        // Math calc
        let page5View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 4, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page5View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page5View.addSubview(label4) // Add label
        page5View.addSubview(mathc)
        page5View.addSubview(button10) // Add buttons
        page5View.addSubview(button11)
        page5View.addSubview(button12)
        
        scrollView.addSubview(page5View)
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func checkForDefaults() {
        let stillWantBigTime = defaults.bool(forKey: "wantedSATBigTime")
        let stillWantSmallTime = defaults.bool(forKey: "wantedSATSmallTime")
        
        if(stillWantBigTime == true) {
            timings.isBigExtendedTime = true
        }
        if(stillWantSmallTime == true) {
            timings.isSmallExtendedTime = true
        }
    }
    
}
