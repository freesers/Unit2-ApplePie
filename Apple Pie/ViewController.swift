//
//  ViewController.swift
//  Apple Pie
//
//  Created by Sander de Vries on 08/11/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // image outlet
    @IBOutlet weak var treeImageView: UIImageView!
    
    // label outlets
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // button outlet
    @IBOutlet var letterButtons: [UIButton]!
    
    // variables
    var listOfWords = ["heuristieken", "hockey", "apple", "windsurfen", "pizza", "groentijd"]
    var incorrectMovesAllowed = 7
    
    // new round at win or lose
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // start new round if still words in list
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            updateUI()
            enableLetterButtons(false)
            // delay before dismissing view
            // credits: owlswipe: https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // update labels and image
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    // update wins and losses
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }

    // disable button and append to guessed letter
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
}

