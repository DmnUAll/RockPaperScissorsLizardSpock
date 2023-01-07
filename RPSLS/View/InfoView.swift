import UIKit

// MARK: - InfoView
final class InfoView: UIView {

    // MARK: - Properties and Initializers
    private lazy var topStackView: UIStackView = {
        makeStackView(withAxis: .horizontal, distribution: .fillEqually)
    }()

    private lazy var rulesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rules")
        return imageView
    }()

    private lazy var rulesLabel: UILabel = {
        let text = """
Rock crushes Scissors and Lizard
Paper covers Rock and disproves Spock Scissors cut Paper and decapitate Lizzard
Lizzard eats Paper and poisons Spock
Spock vaporizes Rock and smashes Scissors
"""
        return makeLabel(withText: text, alignment: .center)
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = makeStackView(withAxis: .vertical, distribution: .fill)
        stackView.toAutolayout()
        stackView.backgroundColor = .rpslsGreenDark
        stackView.layer.cornerRadius = 15
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension InfoView {

    private func addSubviews() {
        topStackView.addArrangedSubview(makeImageView(withimage: "arrow.down.to.line.alt"))
        topStackView.addArrangedSubview(makeLabel(withText: "Swipe down to dismiss!", alignment: .center))
        topStackView.addArrangedSubview(makeImageView(withimage: "arrow.down.to.line.alt"))
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(rulesImage)
        mainStackView.addArrangedSubview(rulesLabel)
        addSubview(mainStackView)
    }

    private func setupConstraints() {
        let constraints = [
            topStackView.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 14)),
            rulesImage.heightAnchor.constraint(equalToConstant: UIScreen.screenSize(heightDividedBy: 2)),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 36),
            mainStackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 24),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: 36)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String, alignment: NSTextAlignment, andSize size: CGFloat = 15) -> UILabel {
        let label = UILabel()
        label.text = text
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.font = UIFont(name: "Noteworthy Bold", size: size)
        label.textColor = .white
        return label
    }

    private func makeImageView(withimage imageName: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.toAutolayout()
        guard let imagName = imageName else {
            return imageView
        }
        imageView.image = UIImage(systemName: imagName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }

    private func makeStackView(withAxis axis: NSLayoutConstraint.Axis,
                               alignment: UIStackView.Alignment = .fill,
                               distribution: UIStackView.Distribution = .fill
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = 10
        return stackView
    }
}
