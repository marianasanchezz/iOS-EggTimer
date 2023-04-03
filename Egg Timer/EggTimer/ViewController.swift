//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let cookTime = ["soft": 3, "medium": 4, "hard": 7]
    
    var totalTime = 0
    var secPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = cookTime[hardness]!
        
        progressBar.progress = 0.0
        secPassed = 0
        titleLabel.text = "Cooking a " + hardness + " egg..."
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func updateTimer() {
        secPassed += 1
        if secPassed < totalTime {
            progressBar.setProgress(Float(secPassed) / Float(totalTime), animated: true)
            
        } else {
            timer.invalidate()
            progressBar.setProgress(1, animated: true)
            playSound()
            titleLabel.text = "Done!"
        }
    }

    }
    


