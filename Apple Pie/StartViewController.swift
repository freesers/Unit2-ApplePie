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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
}
