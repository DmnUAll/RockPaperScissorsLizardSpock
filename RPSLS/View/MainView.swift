import UIKit

// MARK: - MainViewDelegate protocol
protocol MainViewDelegate: AnyObject {
    func selectorButtonTapped(withTag tag: Int)
    func goButtonTapped()
    func infoButtonTapped()
}

// MARK: - MainView
final class MainView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: MainViewDelegate?

    lazy var infoLabel: UILabel = {
        makeLabel(withText: "Let's see how tough you are!", alignment: .center)
    }()

    lazy var aiImage: UIImageView = {
        makeImageView()
    }()

    lazy var scoreLabel: UILabel = {
        makeLabel(withText: "0 : 0", alignment: .center)
    }()

    private lazy var scoreStackView: UIStackView = {
        makeStackView(withAxis: .horizontal, distribution: .fillEqually, andSpacing: 5)
    }()

    lazy var previousButtonImage: UIImageView = {
        makeImageView(withimage: "arrowl")
    }()

    private lazy var previousButton: UIButton = {
        let button = makeButton(action: #selector(selectorButtonTapped))
        button.tag = 0
        return button
    }()

    private lazy var previousView: UIView = {
        makeView()
    }()

    lazy var playerImage: UIImageView = {
        makeImageView()
    }()

    lazy var nextButtonImage: UIImageView = {
        makeImageView(withimage: "arrow")
    }()

    private lazy var nextButton: UIButton = {
        let button = makeButton(action: #selector(selectorButtonTapped))
        button.tag = 1
        return button
    }()

    private lazy var nextView: UIView = {
        makeView()
    }()

    private lazy var playerStackView: UIStackView = {
        makeStackView(withAxis: .horizontal)
    }()

    lazy var goButton: UIButton = {
        makeButton(withText: "Go!", andBGColor: .rpslsGreenLight, action: #selector(goButtonTapped))
    }()

    private lazy var infoButton: UIButton = {
        let button = makeButton(tintColor: .rpslsGreenLight, action: #selector(infoButtonTapped))
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        return button
    }()

    private lazy var bottomButtonsStackView: UIStackView = {
        makeStackView(withAxis: .horizontal)
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical, alignment: .center, distribution: .equalSpacing)
        stackView.toAutolayout()
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        aiImage.image = UIImage(named: "lizard")
        playerImage.image = UIImage(named: "paper")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension MainView {

    @objc private func selectorButtonTapped(_ sender: UIButton) {
        delegate?.selectorButtonTapped(withTag: sender.tag)
    }

    @objc private func goButtonTapped() {
        delegate?.goButtonTapped()
    }

    @objc private func infoButtonTapped() {
        delegate?.infoButtonTapped()
    }

    private func addSubviews() {
        scoreStackView.addArrangedSubview(makeLabel(withText: "Just You", alignment: .right))
        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(makeLabel(withText: "Mighty AI", alignment: .left))
        previousView.addSubview(previousButtonImage)
        previousView.addSubview(previousButton)
        nextView.addSubview(nextButtonImage)
        nextView.addSubview(nextButton)
        playerStackView.addArrangedSubview(previousView)
        playerStackView.addArrangedSubview(playerImage)
        playerStackView.addArrangedSubview(nextView)
        bottomButtonsStackView.addArrangedSubview(goButton)
        bottomButtonsStackView.addArrangedSubview(infoButton)
        mainStackView.addArrangedSubview(infoLabel)
        mainStackView.addArrangedSubview(aiImage)
        mainStackView.addArrangedSubview(scoreStackView)
        mainStackView.addArrangedSubview(playerStackView)
        mainStackView.addArrangedSubview(bottomButtonsStackView)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let imageSize = UIScreen.screenSize(heightDividedBy: 4)
        let buttonHeight = imageSize / 4
        let constraints = [
            aiImage.widthAnchor.constraint(equalToConstant: imageSize),
            aiImage.heightAnchor.constraint(equalToConstant: imageSize),
            playerImage.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            playerImage.widthAnchor.constraint(equalToConstant: imageSize),
            playerImage.heightAnchor.constraint(equalToConstant: imageSize),
            previousView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 3),
            previousView.trailingAnchor.constraint(equalTo: playerImage.leadingAnchor, constant: -3),
            previousButtonImage.leadingAnchor.constraint(equalTo: previousView.leadingAnchor, constant: 3),
            previousButtonImage.topAnchor.constraint(equalTo: previousView.topAnchor, constant: 3),
            previousButtonImage.trailingAnchor.constraint(equalTo: previousView.trailingAnchor, constant: -3),
            previousButtonImage.bottomAnchor.constraint(equalTo: previousView.bottomAnchor, constant: -3),
            previousButton.leadingAnchor.constraint(equalTo: previousView.leadingAnchor),
            previousButton.topAnchor.constraint(equalTo: previousView.topAnchor),
            previousButton.trailingAnchor.constraint(equalTo: previousView.trailingAnchor),
            previousButton.bottomAnchor.constraint(equalTo: previousView.bottomAnchor),
            nextView.leadingAnchor.constraint(equalTo: playerImage.trailingAnchor, constant: 3),
            nextView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -3),
            nextButtonImage.leadingAnchor.constraint(equalTo: nextView.leadingAnchor, constant: 3),
            nextButtonImage.topAnchor.constraint(equalTo: nextView.topAnchor, constant: 3),
            nextButtonImage.trailingAnchor.constraint(equalTo: nextView.trailingAnchor, constant: -3),
            nextButtonImage.bottomAnchor.constraint(equalTo: nextView.bottomAnchor, constant: -3),
            nextButton.leadingAnchor.constraint(equalTo: nextView.leadingAnchor),
            nextButton.topAnchor.constraint(equalTo: nextView.topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: nextView.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: nextView.bottomAnchor),
            goButton.widthAnchor.constraint(greaterThanOrEqualToConstant: imageSize),
            goButton.leadingAnchor.constraint(greaterThanOrEqualTo: bottomButtonsStackView.leadingAnchor, constant: 3),
            goButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            infoButton.widthAnchor.constraint(equalToConstant: buttonHeight),
            infoButton.trailingAnchor.constraint(equalTo: bottomButtonsStackView.trailingAnchor, constant: -3),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        label.textColor = .rpslsGreenLight
        return label
    }

    private func makeImageView(withimage imageName: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.toAutolayout()
        guard let imagName = imageName else {
            return imageView
        }
        imageView.image = UIImage(named: imagName)
        return imageView
    }

    private func makeButton(withText text: String = "",
                            tintColor: UIColor = .white,
                            andBGColor bgColor: UIColor = .clear,
                            action: Selector? = nil
    ) -> UIButton {
        let button = UIButton()
        button.toAutolayout()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy Bold", size: 20)
        button.backgroundColor = bgColor
        button.tintColor = tintColor
        button.layer.cornerRadius = 15
        guard let action = action else { return button }
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func makeView() -> UIView {
        let view = UIView()
        return view
    }

    private func makeStackView(withAxis axis: NSLayoutConstraint.Axis,
                               alignment: UIStackView.Alignment = .fill,
                               distribution: UIStackView.Distribution = .fill,
                               andSpacing spacing: CGFloat = 10
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
}
