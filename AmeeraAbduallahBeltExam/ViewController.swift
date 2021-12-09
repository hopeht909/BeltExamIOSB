//
//  ViewController.swift
//  AmeeraAbduallahBeltExam
//
//  Created by admin on 09/12/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    //Outlet
    @IBOutlet weak var skipResetBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newCardLabel: UILabel!
    @IBOutlet weak var newCardbutton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //Variable
    var scoreCounter = true
    var cardNumber: Int = 0
    var score: Int = 0
    var selectedCard: Int = 0
    let allCard = Cardsdata()
    
    var seconds = 60
    var timerT = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    var rightCards: [String] = []
    
    struct Cardsdata{
        var cards = [
            Card(CardName: "Heavy"),
            Card(CardName: "Home"),
            Card(CardName: "Money"),
            Card(CardName: "Car"),
            Card(CardName: "Key"),
            Card(CardName: "Book"),
            Card(CardName: "Iphone"),
            Card(CardName: "Red"),
            Card(CardName: "Fast"),
            Card(CardName: "Slow"),
            Card(CardName: "Nice"),
            Card(CardName: "LapTop")
            
        ]
    }
    
    struct Card {
        var CardName = String()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCards()
        updateUI(scoreString: "Score: ")
        if  isTimerRunning == false {
            runTimer()
        }
        skipResetBtn.setTitle("Skip", for: .normal)
        self.title = "Go back And Restart The Game"
        skipResetBtn.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
        skipResetBtn.layer.cornerRadius = 10
        skipResetBtn.layer.borderWidth = 4
        skipResetBtn.layer.borderColor = UIColor.white.cgColor
        
        
        
    }
    //Draw a new Card
    @IBAction func newCardAction(_ sender: UIButton) {
        if scoreCounter == true{
            score += 1
            updateUI(scoreString: "Score: \(score)")
            
            if let card = newCardLabel.text {
                rightCards.append(card)
            }
            
            cardNumber += 1
            updateCards()
        }
        else{
            scoreCounter = true
            cardNumber += 1
            updateUI(scoreString: "Score: \(score)")
            updateCards()
            
        }
    }
    //Action to Skip Cards Or Restart The game
    @IBAction func skipRestartAction(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "Skip"{
                scoreCounter = false
                cardNumber += 1
                updateCards()
            }
            else{
                resumeTapped = false
                pause()
                restartGame()
            }
            scoreCounter = true
        }
    }
    //Start The Timer
    func runTimer() {
        timerT = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        
        isTimerRunning = true
    }
    //Update The Timer
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text =  timeString(time: TimeInterval(seconds))
        
        if seconds == 0 {
            resumeTapped = false
            pause()
            cardNumber += 1
            let alert = UIAlertController(title: "Time out", message: "Go To Next Card?", preferredStyle: .alert)
            let goAction = UIAlertAction(title: "Go", style: .default, handler: {action in self.updateCards()})
            alert.addAction(goAction)
            present(alert, animated: true, completion: nil)
        }
    }
    //Pasue The Timer
    func pause(){
        if self.resumeTapped == false {
            timerT.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
    //Reset The Timer
    func reset(){
        timerT.invalidate()
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    //Update The Score
    func updateUI(scoreString: String){
        scoreLabel.text = scoreString
        
    }
    //Restart The Game
    func restartGame(){
        score = 0
        cardNumber = 0
        updateCards()
        updateUI(scoreString: "Score: ")
        skipResetBtn.setTitle("Skip", for: .normal)
        rightCards = []
        
    }
    
    //Draw a new Card for the player
    func updateCards(){
        if cardNumber <=  allCard.cards.count - 1{
            newCardLabel.text = allCard.cards[cardNumber].CardName
            reset()
            runTimer()
            
            //Open A new View Controller And Show The Correct Answers There
        }else {
            let secondCV = storyboard?.instantiateViewController(withIdentifier: "ScreenTwoID") as! SecondVC
            secondCV.score = score
            secondCV.correctAnswers = rightCards
            self.navigationController?.pushViewController(secondCV, animated: true)
            skipResetBtn.setTitle("Restart", for: .normal)
            resumeTapped = false
            pause()
            
        }
    }
    
    
}

