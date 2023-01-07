import UIKit

// MARK: - GameModel
struct GameModel {

    // MARK: - Properties and Initializers
    var aiScore: Int = 0
    var playerScore: Int = 0
    var aiSelection: Int = 0
    var playerSelection: Int = Int.random(in: 0...4)

    let gameSet: [UIImage] = [
        UIImage(named: "rock.png")!,
        UIImage(named: "paper.png")!,
        UIImage(named: "scissors.png")!,
        UIImage(named: "lizard.png")!,
        UIImage(named: "spock.png")!
    ]

    let gameScheme: [Int: ([Int], [String])] = [
        0: ([2, 3], ["Rock crushes scissors!", "Rock crushes lizard!"]),
        1: ([0, 4], ["Paper covers rock!", "Paper disproves Spock!"]),
        2: ([1, 3], ["Scissors cut paper!", "Scissors decapitate lizzard!"]),
        3: ([1, 4], ["Lizzard eats paper!", "Lizzard poisions Spock!"]),
        4: ([0, 2], ["Spock vaporizes rock!", "Spock smashes scissors!"])
    ]
}
