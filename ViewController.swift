//
//  ViewController.swift
//  ApplePie
//
//  Created by Vicente Soriano on 7/10/19.
//  Copyright © 2019 Vicente Soriano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["coffee", "sandwich", "hamburger", "moon", "milk", "rainbow", "guitar", "hat"]
    
    let incorrectMovesAllowed = 6
    
    var wins = 0 {
        didSet {
            newRound()
        }
    }
    
    var losses = 0 {
        didSet {
            newRound()
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
 
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }

    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(wins), Losses \(losses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            losses += 1
        } else if currentGame.word == currentGame.formattedWord {
            wins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = true
        }
    }
 
}

