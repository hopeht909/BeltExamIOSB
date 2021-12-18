//
//  SecondVC.swift
//  AmeeraAbduallahBeltExam
//
//  Created by admin on 09/12/2021.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = 0
    var correctAnswers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        let string = correctAnswers.joined(separator: "\n")
        correctAnswerLabel.text = string
        
    }
    
    
    
}
