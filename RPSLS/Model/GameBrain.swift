//
//  GameBrain.swift
//  RPSLS
//
//  Created by Илья Валито on 12.06.2022.
//

import UIKit

struct GameBrain {
    
    var aiScore: Int = 0
    var playerScore: Int = 0
    var aiSelection: Int = 0
    var playerSelection: Int = Int.random(in: 0...4)
    
    static let gameSet: [UIImage] = [
        UIImage(named: "rock.png")!,
        UIImage(named: "paper.png")!,
        UIImage(named: "scissors.png")!,
        UIImage(named: "lizard.png")!,
        UIImage(named: "spock.png")!
    ]
    
    static let gameScheme: [Int: ([Int], String, String)] = [
        0: ([2, 3], "Rock crushes scissors!", "Rock crushes lizard!"),
        1: ([0, 4], "Paper covers rock!", "Paper disproves Spock!"),
        2: ([1, 3], "Scissors cut paper!", "Scissors decapitate lizzard!"),
        3: ([1, 4], "Lizzard eats paper!", "Lizzard poisions Spock!"),
        4: ([0, 2], "Spock vaporizes rock!", "Spock smashes scissors!")
    ]
    
    mutating func nextSelection() -> UIImage {
        
        if playerSelection + 1 > GameBrain.gameSet.count - 1 {
            
            playerSelection = 0
        } else {
            
            playerSelection += 1
        }
        return GameBrain.gameSet[playerSelection]
    }
    
    mutating func previousSelection() -> UIImage {
        
        if playerSelection - 1 < 0 {
            
            playerSelection = GameBrain.gameSet.count - 1
        } else {
            
            playerSelection -= 1
        }
        return GameBrain.gameSet[playerSelection]
    }
    
    mutating func whoWon() -> String {
        
        if let result = GameBrain.gameScheme[playerSelection] {
            if result.0.contains(aiSelection) {
                playerScore += 1
                if result.0.firstIndex(of: aiSelection) == 0 {
                    return result.1 + " You won!"
                } else {
                    return result.2 + " You won!"
                }
            }
            if let result = GameBrain.gameScheme[aiSelection] {
                if result.0.contains(playerSelection) {
                    aiScore += 1
                    if result.0.firstIndex(of: playerSelection) == 0 {
                        return result.1 + " You lose!"
                    } else {
                        return result.2 + " You lose!"
                    }
                }
            }
        }
        return "Spare!"
    }
}
