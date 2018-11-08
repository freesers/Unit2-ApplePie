//
//  StartViewController.swift
//  Apple Pie
//
//  Created by Sander de Vries on 08/11/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var difficultySlider: UISlider!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var alreadyPlayed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // reset start screen 
    override func viewWillAppear(_ animated: Bool) {
        if alreadyPlayed == true {
            welcomeLabel.text = "Welcome to Apple Pie! (again)"
            difficultySlider.setValue(7.5, animated: true)
        }
    }
    
    
    
    @IBAction func sliderAdjusted(_ sender: UISlider) {
    
        // change number of mistakes with slider
        switch sender.value {
        case 1...3:
            difficultyLabel.text = "Impossible"
        case 3...6:
            difficultyLabel.text = "Challenging"
        case 6...10:
            difficultyLabel.text = "Average"
        case 10...14:
            difficultyLabel.text = "Easy"
        default:
            difficultyLabel.text = "Average"
        }
    }
    
    // move slider value over to Viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let vc = segue.destination as? ViewController
            vc?.incorrectMovesAllowed = Int(difficultySlider.value)
            alreadyPlayed = true
        }
    }
}
