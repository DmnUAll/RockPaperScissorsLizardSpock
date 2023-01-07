import UIKit

// MARK: - MainPresenter
final class MainPresenter {

    // MARK: - Properties and Initializers
    private weak var viewController: MainController?
    private var gameModel = GameModel()
    var timer: Timer?
    var userHaveMadeChoice = false

    init(viewController: MainController? = nil) {
        self.viewController = viewController
    }
}

// MARK: - Helpers
extension MainPresenter {

    private func fireTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.viewController?.mainView.aiImage.image = self.gameModel.gameSet.randomElement()
        }
        timer?.fire()
    }

    func startAIImitation() {
       fireTimer()
    }

    func isUserMadeChoice() -> Bool {
        userHaveMadeChoice.toggle()
        if userHaveMadeChoice {
            timer?.invalidate()
        } else {
            fireTimer()
        }
        return userHaveMadeChoice
    }

    func giveImage(forTag tag: Int? = nil) -> UIImage {
        guard let tag = tag else { return gameModel.gameSet[gameModel.playerSelection] }
        if tag == 0 {
            if gameModel.playerSelection + 1 > gameModel.gameSet.count - 1 {
                gameModel.playerSelection = 0
            } else {
                gameModel.playerSelection += 1
            }
        } else {
            if gameModel.playerSelection - 1 < 0 {
                gameModel.playerSelection = gameModel.gameSet.count - 1
            } else {
                gameModel.playerSelection -= 1
            }
        }
        return gameModel.gameSet[gameModel.playerSelection]
    }

    func returnRoundInfo(withAIPick aiPick: UIImage?) -> String {
        guard let aiPick = aiPick else { return "Something went wrong" }
        gameModel.aiSelection = gameModel.gameSet.firstIndex(of: aiPick) ?? 0
        if let result = gameModel.gameScheme[gameModel.playerSelection] {
            if result.0.contains(gameModel.aiSelection) {
                gameModel.playerScore += 1
                if result.0.firstIndex(of: gameModel.aiSelection) == 0 {
                    return result.1[0] + " You won!"
                } else {
                    return result.1[1] + " You won!"
                }
            }
            if let result = gameModel.gameScheme[gameModel.aiSelection] {
                if result.0.contains(gameModel.playerSelection) {
                    gameModel.aiScore += 1
                    if result.0.firstIndex(of: gameModel.playerSelection) == 0 {
                        return result.1[0] + " You lose!"
                    } else {
                        return result.1[1] + " You lose!"
                    }
                }
            }
        }
        return "Spare!"
    }

    func returnScoreInfo() -> String {
        return "\(gameModel.playerScore) : \(gameModel.aiScore)"
    }
}
