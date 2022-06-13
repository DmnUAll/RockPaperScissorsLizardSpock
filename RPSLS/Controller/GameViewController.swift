//
//  ViewController.swift
//  RPSLS
//
//  Created by Илья Валито on 12.06.2022.
//

import UIKit

class GameViewController: UIViewController {

    var gameBrain = GameBrain()
    var goPressed: Bool = false
    
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 100000
    var firstTap: Bool = true
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var aiImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            aiImage.image = GameBrain.gameSet.randomElement()
        } else {
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 0.06, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
        userImage.image = GameBrain.gameSet[gameBrain.playerSelection]
    }

    @IBAction func selectorButtonPressed(_ sender: UIButton) {
        
        if sender.restorationIdentifier == "0" {
            
            userImage.image = gameBrain.previousSelection()
        } else {
            
            userImage.image = gameBrain.nextSelection()
        }
    }
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
       
        if goPressed {
            
            secondsPassed = 0
            timer = Timer.scheduledTimer(timeInterval: 0.06, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
            
            goButton.backgroundColor = #colorLiteral(red: 0, green: 0.4805992842, blue: 0.5544506907, alpha: 1)
            goButton.setTitle("Go!", for: .normal)
            
            infoLabel.text = "Let's see how tough you are!"
        } else {
            
            timer.invalidate()
            
            goButton.backgroundColor = #colorLiteral(red: 0.5347552896, green: 0.006902733352, blue: 0.001711655874, alpha: 1)
            goButton.setTitle("Replay!", for: .normal)
            
            gameBrain.aiSelection = GameBrain.gameSet.firstIndex(of: aiImage.image!)!
            infoLabel.text = gameBrain.whoWon()
            scoreLabel.text = "\(gameBrain.playerScore) : \(gameBrain.aiScore)"
        }
        goPressed = !goPressed
    }
}


