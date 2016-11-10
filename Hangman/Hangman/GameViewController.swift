//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var hangmanImage: UIImageView!
    @IBOutlet var word: UILabel!
    @IBOutlet var input: UITextField!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var wrongGuesses: UILabel!
    
    var gamePhrase = ""
    var wrongGuessesSet = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        gamePhrase = phrase!
        print(phrase)
        
        var blankPhrase = ""
        
        for i in phrase!.characters {
            if (i == " ") {
                blankPhrase += " " + " "
            }
            else {
                blankPhrase += "_" + " "
            }
        }
        
        word.text = blankPhrase
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
        
        
        
    }
    
    @IBAction func guess() {
        input.resignFirstResponder()
        let letter = input.text!
        var numLetters = 0
        let currentGuess = word.text!
        var currentPhrase = ""
        
        if (letter.characters.count > 1 || letter.characters.count == 0) {
            let alert = UIAlertController(title: "Error", message: "Please enter only 1 letter.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        for (i, enumerate) in gamePhrase.characters.enumerated() {
            if (String(enumerate) == letter.uppercased()) {
                currentPhrase += letter.uppercased() + " "
                numLetters += 1
            }
            else if (String(currentGuess[currentGuess.index(currentGuess.startIndex, offsetBy: 2 * i)]) != "_") {
                currentPhrase += String(currentGuess[currentGuess.index(currentGuess.startIndex, offsetBy: (2 * i))]) + " "
            }
            else {
                currentPhrase += "_" + " "
            }
        }
        print(currentPhrase)
        word.text = currentPhrase
        
        var compareString = ""
        for letter in gamePhrase.characters {
            compareString += String(letter) + " "
        }
        
        if (currentPhrase == compareString) {
            let alert = UIAlertController(title: "Congratulations", message: "You Win!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: {
                action in
                let hangmanPhrases = HangmanPhrases()
                let phrase = hangmanPhrases.getRandomPhrase()
                self.gamePhrase = phrase!
                print(phrase)
                
                var blankPhrase = ""
                
                for i in phrase!.characters {
                    if (i == " ") {
                        blankPhrase += " " + " "
                    }
                    else {
                        blankPhrase += "_" + " "
                    }
                }
                
                self.word.text = blankPhrase
                self.hangmanImage.image = UIImage(named: "hangman1.gif")
                self.wrongGuessesSet = Set<String>()
                self.wrongGuesses.text = "Incorrect Guesses:"
                self.word.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
        }
        if (numLetters == 0) {
            if (!wrongGuessesSet.contains(letter)) {
                wrongGuesses.text = wrongGuesses.text! + " " + letter
                wrongGuessesSet.insert(letter)
            }
            let currentPhaseOfPic = wrongGuessesSet.count + 1
            hangmanImage.image = UIImage(named: "hangman" + String(currentPhaseOfPic) + ".gif")
            if (currentPhaseOfPic >= 7) {
                let alert = UIAlertController(title: "Game Over", message: "You Lost", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: {
                    action in
                    let hangmanPhrases = HangmanPhrases()
                    let phrase = hangmanPhrases.getRandomPhrase()
                    self.gamePhrase = phrase!
                    print(phrase)
                    
                    var blankPhrase = ""
                    
                    for i in phrase!.characters {
                        if (i == " ") {
                            blankPhrase += " " + " "
                        }
                        else {
                            blankPhrase += "_" + " "
                        }
                    }
                    
                    self.word.text = blankPhrase
                    self.hangmanImage.image = UIImage(named: "hangman1.gif")
                    self.wrongGuessesSet = Set<String>()
                    self.wrongGuesses.text = "Incorrect Guesses:"
                    self.word.text = ""
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
