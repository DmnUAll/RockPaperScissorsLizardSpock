import UIKit

// MARK: - MainController
final class MainController: UIViewController {

    // MARK: - Properties and Initializers
    private var presenter: MainPresenter?
    lazy var mainView: MainView = {
        let view = MainView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.setAsBackground(withImage: "background", to: self)
        view.addSubview(mainView)
        setupConstraints()
        presenter = MainPresenter(viewController: self)
        mainView.delegate = self
        mainView.playerImage.image = presenter?.giveImage()
        presenter?.startAIImitation()
    }
}

// MARK: - Helpers
private extension MainController {

    private func setupConstraints() {
        let constraints = [
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - MainViewDelegate
extension MainController: MainViewDelegate {

    func selectorButtonTapped(withTag tag: Int) {
        mainView.playerImage.image = presenter?.giveImage(forTag: tag)
        let buttonImage = tag == 0 ? mainView.previousButtonImage : mainView.nextButtonImage
        buttonImage.alpha = 0.75
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            buttonImage.alpha = 1
        })
    }

    func goButtonTapped() {
        guard let presenter = presenter else { return }
        if presenter.isUserMadeChoice() {
            mainView.goButton.backgroundColor = .rpslsRed
            mainView.goButton.setTitle("Replay!", for: .normal)
            mainView.infoLabel.text = presenter.returnRoundInfo(withAIPick: mainView.aiImage.image)
            mainView.scoreLabel.text = presenter.returnScoreInfo()
        } else {
            mainView.goButton.backgroundColor = .rpslsGreenDark
            mainView.goButton.setTitle("Go!", for: .normal)
            mainView.infoLabel.text = "Let's see how tough you are!"
        }
    }

    func infoButtonTapped() {
        show(InfoController(), sender: nil)
    }
}
