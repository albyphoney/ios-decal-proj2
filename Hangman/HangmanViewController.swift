//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet var hangmanPicture: UIImageView!
    @IBOutlet var newGame: UIButton!
    @IBOutlet var guess: UIButton!
    @IBOutlet var guessUser: UITextField!
    @IBOutlet var previousGuesses: UILabel!
    @IBOutlet var knownString: UILabel!
    var hangman: Hangman!
    var numberWrong = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guess.addTarget(self, action: "guess:", forControlEvents: UIControlEvents.TouchUpInside)
        newGame.addTarget(self, action: "newGame:", forControlEvents: UIControlEvents.TouchUpInside)
        hangman = Hangman()
        initializeGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeGame() {
        hangman.start()
        self.knownString.text = hangman.knownString
        self.previousGuesses.text = ""
        numberWrong = 0
        self.hangmanPicture.image = UIImage(named: "hangman1")
    }
    
    func newGame(sender:UIButton) {
        hangman.start()
        self.knownString.text = hangman.knownString
        self.previousGuesses.text = ""
        self.knownString.text = ""
        numberWrong = 0
        self.hangmanPicture.image = UIImage(named: "hangman1")
    }
    
    func guess(sender:UIButton) -> Bool{
        let possible = hangman.guessLetter(guessUser.text!)
        if (!possible) {
            numberWrong += 1
            var imageName = "hangman"
            imageName += String(numberWrong + 1)
            self.hangmanPicture.image = UIImage(named: imageName)
            if (numberWrong > 6) {
                self.hangmanPicture.image = UIImage(named: "hangman7")
                let alertController = UIAlertController(title: "You Lose!", message:
                    "The word is: " + hangman.answer!, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
            }
            var retval = ""
            let guessedLetters = hangman.guessedLetters
            for guess in guessedLetters! {
                retval += guess as! String
            }
            self.previousGuesses.text = retval
            return false
        }
        else {
            if hangman.knownString == hangman.answer {
                self.previousGuesses.text = hangman.knownString
                let alertController = UIAlertController(title: "You Win", message:
                    "Let's play again!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay!", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return true
            }
            var retval = ""
            let guessedLetters = hangman.guessedLetters
            for guess in guessedLetters! {
                retval += guess as! String
            }
            self.previousGuesses.text = retval
            self.knownString.text = hangman.knownString
            return true
        }
    }
    
    
    
}

