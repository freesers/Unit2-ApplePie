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
            difficultySlider.setValue(7, animated: true)
        }
    }
    
    
    /// Updates label depening on de slider
    @IBAction func sliderAdjusted(_ sender: UISlider) {
    
        // change number of mistakes with slider
        switch sender.value {
        case 0...3:
            difficultyLabel.text = "Easy"
        case 3...8:
            difficultyLabel.text = "Average"
        case 8...12:
            difficultyLabel.text = "Challenging"
        case 12...13:
            difficultyLabel.text = "Impossible"
        default:
            difficultyLabel.text = "Average"
        }
    }
    
    // move slider value over to Viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let viewController = segue.destination as? ViewController
            viewController?.incorrectMovesAllowed =  14 - Int(difficultySlider.value)
            alreadyPlayed = true
        }
    }
}
