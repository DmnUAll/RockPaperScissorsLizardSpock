import UIKit

// MARK: - InfoController
final class InfoController: UIViewController {

    lazy var infoView: InfoView = {
        let view = InfoView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoView)
        setupConstraints()
    }
}

// MARK: - Helpers
extension InfoController {

    private func setupConstraints() {
        let constraints = [
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
