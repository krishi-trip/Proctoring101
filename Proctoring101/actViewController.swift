//
//  actViewController.swift
//  Proctoring 101
//
//  Created by Krishi Tripuraneni on 6/2/20.
//  Copyright © 2020 Krishi Tripuraneni. All rights reserved.
//

import UIKit
import AVFoundation

class actViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var audioPlayer = AVAudioPlayer()
    
    // Look at bottom
    var titleLabel: UILabel!
    
    var english: UILabel!
    var reading: UILabel!
    var math: UILabel!
    var science: UILabel!
    
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    var label4: UILabel!
    
    var scrollView: UIScrollView!
    
    var timeEnglish=0
    var timeMath=0
    var timeReading=0
    var timeScience=0
    
    
    var timerEnglish = Timer()
    var timerMath = Timer()
    var timerReading = Timer()
    var timerScience = Timer()
    
    var isEnglishTimerRunning = false
    var isMathTimerRunning = false
    var isReadingTimerRunning = false
    var isScienceTimerRunning = false
    
    struct timings {
        static var isBigExtendedTime = false
        static var isSmallExtendedTime = false
    }
    
    
    // MARK: - Function Creations
    @objc func goToSettings() {
        performSegue(withIdentifier: "ACTsettingSegue", sender: self)
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
    
    func runEnglishTimer() {
        label1.textAlignment = NSTextAlignment.center
        
        timerEnglish = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(actViewController.updateEnglishTimer)), userInfo: nil, repeats: true)
    }
    
    func runMathTimer() {
        label2.textAlignment = NSTextAlignment.center
        
        timerMath = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(actViewController.updateMathTimer)), userInfo: nil, repeats: true)
    }
    
    func runReadingTimer() {
        label3.textAlignment = NSTextAlignment.center
        
        timerReading = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(actViewController.updateReadingTimer)), userInfo: nil, repeats: true)
    }
    
    func runScienceTimer() {
        label4.textAlignment = NSTextAlignment.center
        
        timerScience = Timer.scheduledTimer(timeInterval: 1, target:self, selector:(#selector(actViewController.updateScienceTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateEnglishTimer() {
        if(timeEnglish>0) {
            timeEnglish -= 1
        }
        
        if(timeEnglish == 0) {
            self.playSound()
        }
        
        label1.text=timeString(time: TimeInterval(timeEnglish))
    }
    
    @objc func updateMathTimer() {
        if(timeMath>0) {
            timeMath -= 1
        }
        
        if(timeMath == 0) {
            self.playSound()
        }
        
        label2.text=timeString(time: TimeInterval(timeMath))
    }
    
    @objc func updateReadingTimer() {
        if(timeReading>0) {
            timeReading -= 1
        }
        
        if(timeReading == 0) {
            self.playSound()
        }
        
        label3.text=timeString(time: TimeInterval(timeReading))
    }
    
    
    @objc func updateScienceTimer() {
        if(timeScience>0) {
            timeScience -= 1
        }
        
        if(timeScience == 0) {
            self.playSound()
        }
        
        label4.text=timeString(time: TimeInterval(timeScience))
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
    
    
    // MARK: - English Methods
    @objc func ACT_english_START(_ sender: Any) {
        audioPlayer.stop()
        if((self.isEnglishTimerRunning == false) && (timeEnglish == 0)) {
            if(actViewController.timings.isBigExtendedTime == true)
            {
                timeEnglish=5_400
                
            }
            else if(actViewController.timings.isSmallExtendedTime == true)
            {
                timeEnglish=4_050
                
            }
            else
            {
                timeEnglish=2_700
                
            }
        }
        label1.text=timeString(time: TimeInterval(timeEnglish))
        
        if(self.isEnglishTimerRunning == false)
        {
            runEnglishTimer()
            isEnglishTimerRunning=true
        }
        
    }
    @objc func ACT_english_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isEnglishTimerRunning == true) {
            timerEnglish.invalidate()
            self.isEnglishTimerRunning = false
        }
        else {
            runEnglishTimer()
            self.isEnglishTimerRunning = true
        }
    }
    @objc func ACT_english_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerEnglish.invalidate()
        self.isEnglishTimerRunning = false
        timeEnglish = 0
        ACT_english_START(self)
    }
    
    
    // MARK: - Math Methods
    @objc func ACT_math_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathTimerRunning == false && (timeMath == 0)) {
            if(actViewController.timings.isBigExtendedTime == true)
            {
                timeMath=7_200
                
            }
            else if(actViewController.timings.isSmallExtendedTime == true)
            {
                timeMath=5_400
                
            }
            else
            {
                timeMath=3_600
                
            }
        }
        if(self.isMathTimerRunning == false)
        {
            runMathTimer()
            isMathTimerRunning=true
        }
        
    }
    @objc func ACT_math_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isMathTimerRunning == true) {
            timerMath.invalidate()
            self.isMathTimerRunning = false
        }
        else {
            runMathTimer()
            self.isMathTimerRunning = true
        }
    }
    @objc func ACT_math_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerMath.invalidate()
        self.isMathTimerRunning = false
        timeMath=0
        ACT_math_START(self)
    }
    
    
    // MARK: - Reading Methods
    @objc func ACT_reading_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isReadingTimerRunning == false && (timeReading == 0)) {
            if(actViewController.timings.isBigExtendedTime == true)
            {
                timeReading=4_200
                
            }
            else if(actViewController.timings.isSmallExtendedTime == true)
            {
                timeReading=3_150
                
            }
            else
            {
                timeReading=2_100
                
            }
        }
        if(self.isReadingTimerRunning == false)
        {
            runReadingTimer()
            isReadingTimerRunning=true
        }
        
    }
    @objc func ACT_reading_PAUSE(_ sender: Any) {
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
    @objc func ACT_reading_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerReading.invalidate()
        self.isReadingTimerRunning = false
        timeReading=0
        ACT_reading_START(self)
    }
    
    
    // MARK: - Science Methods
    @objc func ACT_science_START(_ sender: Any) {
        audioPlayer.stop()
        if(self.isScienceTimerRunning == false && (timeScience == 0)) {
            if(actViewController.timings.isBigExtendedTime == true)
            {
                timeScience=4_200
                
            }
            else if(actViewController.timings.isSmallExtendedTime == true)
            {
                timeScience=3_150
                
            }
            else
            {
                timeScience=2_100
                
            }
        }
        if(self.isScienceTimerRunning == false)
        {
            runScienceTimer()
            isScienceTimerRunning=true
        }
        
    }
    @objc func ACT_science_PAUSE(_ sender: Any) {
        audioPlayer.stop()
        if(self.isScienceTimerRunning == true) {
            timerScience.invalidate()
            self.isScienceTimerRunning = false
        }
        else {
            runScienceTimer()
            self.isScienceTimerRunning = true
        }
    }
    @objc func ACT_science_RESET(_ sender: Any) {
        audioPlayer.stop()
        timerScience.invalidate()
        self.isScienceTimerRunning = false
        timeScience=0
        ACT_science_START(self)
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
        titleLabel.text=" ACT "
        titleLabel.textColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        titleLabel.sizeToFit()
        titleLabel.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        english = UILabel()
        english.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        english.text=" English "
        english.textColor = UIColor(red: 237/255.0, green: 234/255.0, blue: 229/255.0, alpha: 1.0)
        english.sizeToFit()
        english.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        
        math = UILabel()
        math.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        math.text=" Math "
        math.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        math.sizeToFit()
        math.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        reading = UILabel()
        reading.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        reading.text=" Reading "
        reading.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        reading.sizeToFit()
        reading.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
        science = UILabel()
        science.font=UIFont(name: "Spartan-ExtraBold", size: 50)
        science.text=" Science "
        science.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        science.sizeToFit()
        science.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height*(1/4))
        
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
        label3.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        label4 = UILabel()
        label4.font=UIFont(name: "Spartan-SemiBold", size: 50)
        label4.text=" 00:00:00 "
        label4.textColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)
        label4.sizeToFit()
        label4.center=CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        // MARK: - Buttons
        
        let actStart = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        actStart.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(2/3))
        actStart.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        actStart.titleLabel?.sizeToFit()
        actStart.titleLabel?.font=UIFont(name: "Spartan-Regular", size: 40)
        actStart.setTitle("Start", for: .normal)
        actStart.setTitleColor(UIColor(red: 255/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1.0), for: .normal)
        actStart.layer.cornerRadius = 75
        actStart.layer.masksToBounds = true
        actStart.addTarget(self, action: #selector(startTest), for: .touchUpInside)
    
        let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button1.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button1.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button1.titleLabel?.font=UIFont(name: "Spartan-Regular", size: 20)
        button1.setTitle("Start", for: .normal)
        button1.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button1.layer.cornerRadius = 50
        button1.layer.masksToBounds = true
        button1.addTarget(self, action: #selector(ACT_english_START), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button2.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button2.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button2.titleLabel?.font = UIFont(name: "Spartan-Regular", size: 20)
        button2.setTitle("Pause", for: .normal)
        button2.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button2.layer.cornerRadius = 50
        button2.layer.masksToBounds = true
        button2.addTarget(self, action: #selector(ACT_english_PAUSE), for: .touchUpInside)
        
        let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button3.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button3.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button3.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button3.setTitle("Reset", for: .normal)
        button3.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button3.layer.cornerRadius = 50
        button3.layer.masksToBounds = true
        button3.addTarget(self, action: #selector(ACT_english_RESET), for: .touchUpInside)
        
        let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button4.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button4.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button4.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button4.setTitle("Start", for: .normal)
        button4.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button4.layer.cornerRadius = 50
        button4.layer.masksToBounds = true
        button4.addTarget(self, action: #selector(ACT_math_START), for: .touchUpInside)
        
        let button5 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button5.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button5.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button5.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button5.setTitle("Pause", for: .normal)
        button5.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button5.layer.cornerRadius = 50
        button5.layer.masksToBounds = true
        button5.addTarget(self, action: #selector(ACT_math_PAUSE), for: .touchUpInside)
        
        let button6 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button6.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button6.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button6.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button6.setTitle("Reset", for: .normal)
        button6.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button6.layer.cornerRadius = 50
        button6.layer.masksToBounds = true
        button6.addTarget(self, action: #selector(ACT_math_RESET(_:)), for: .touchUpInside)
        
        let button7 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button7.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button7.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button7.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button7.setTitle("Start", for: .normal)
        button7.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button7.layer.cornerRadius = 50
        button7.layer.masksToBounds = true
        button7.addTarget(self, action: #selector(ACT_reading_START), for: .touchUpInside)
        
        let button8 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button8.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button8.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button8.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button8.setTitle("Pause", for: .normal)
        button8.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button8.layer.cornerRadius = 50
        button8.layer.masksToBounds = true
        button8.addTarget(self, action: #selector(ACT_reading_PAUSE), for: .touchUpInside)
        
        let button9 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button9.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button9.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button9.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button9.setTitle("Reset", for: .normal)
        button9.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button9.layer.cornerRadius = 50
        button9.layer.masksToBounds = true
        button9.addTarget(self, action: #selector(ACT_reading_RESET), for: .touchUpInside)
        
        let button10 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button10.center=CGPoint(x: self.view.bounds.width*(1/4)-20, y: self.view.bounds.height*(4/5))
        button10.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button10.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button10.setTitle("Start", for: .normal)
        button10.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button10.layer.cornerRadius = 50
        button10.layer.masksToBounds = true
        button10.addTarget(self, action: #selector(ACT_science_START), for: .touchUpInside)
        
        let button11 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button11.center=CGPoint(x: self.view.bounds.width*(1/2), y: self.view.bounds.height*(4/5))
        button11.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button11.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button11.setTitle("Pause", for: .normal)
        button11.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button11.layer.cornerRadius = 50
        button11.layer.masksToBounds = true
        button11.addTarget(self, action: #selector(ACT_science_PAUSE), for: .touchUpInside)
        
        let button12 = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button12.center=CGPoint(x: self.view.bounds.width*(3/4)+20, y: self.view.bounds.height*(4/5))
        button12.backgroundColor = UIColor(red: 209/255.0, green: 232/255.0, blue: 225/255.0, alpha: 1.0)
        button12.titleLabel!.font=UIFont(name: "Spartan-Regular", size: 20)
        button12.setTitle("Reset", for: .normal)
        button12.setTitleColor(UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0), for: .normal)
        button12.layer.cornerRadius = 50
        button12.layer.masksToBounds = true
        button12.addTarget(self, action: #selector(ACT_science_RESET), for: .touchUpInside)
        
    
        
        
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
        
        let ACTsettings = UIButton(frame: CGRect(x: 100, y: 100, width: 150, height: 50))
        ACTsettings.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        ACTsettings.setTitle("ACT Settings", for: .normal)
        ACTsettings.setTitleColor(UIColor(red: 212/255.0, green: 235/255.0, blue: 246/255.0, alpha: 1.0), for: .normal)
        ACTsettings.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        ACTsettings.center=CGPoint(x: self.view.bounds.width/4, y: 100)
        
        page1View.addSubview(actStart)
        
        page1View.addSubview(ACTsettings)
        
        scrollView.addSubview(page1View)
        
        // English
        let page2View = UIScrollView(frame: CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page2View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page2View.addSubview(label1) // Add label
        page2View.addSubview(english)
        page2View.addSubview(button1) // Add buttons
        page2View.addSubview(button2)
        page2View.addSubview(button3)
        
        scrollView.addSubview(page2View)
        
        // Math
        let page3View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 2, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page3View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page3View.addSubview(label2) // Add label
        page3View.addSubview(math)
        page3View.addSubview(button4) // Add buttons
        page3View.addSubview(button5)
        page3View.addSubview(button6)
        
        scrollView.addSubview(page3View)
        
        // Reading
        let page4View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 3, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page4View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page4View.addSubview(label3) // Add label
        page4View.addSubview(reading)
        page4View.addSubview(button7) // Add buttons
        page4View.addSubview(button8)
        page4View.addSubview(button9)
        
        scrollView.addSubview(page4View)
        
        // Science
        let page5View = UIScrollView(frame: CGRect(x: self.view.bounds.width * 4, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        page5View.backgroundColor = UIColor(red: 49/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0)
        
        page5View.addSubview(label4) // Add label
        page5View.addSubview(science)
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
        let stillWantBigTime = defaults.bool(forKey: "wantedACTBigTime")
        let stillWantSmallTime = defaults.bool(forKey: "wantedACTSmallTime")
        
        if(stillWantBigTime == true) {
            timings.isBigExtendedTime = true
        }
        if(stillWantSmallTime == true) {
            timings.isSmallExtendedTime = true
        }
    }
    
}
