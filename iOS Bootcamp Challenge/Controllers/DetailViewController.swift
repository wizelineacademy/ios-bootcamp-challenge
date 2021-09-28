//
//  DetailViewController.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    static let segueIdentifier = "goDetailViewControllerSegue"
    private let margin: CGFloat = 20

    private var gradient: CAGradientLayer? {
        guard let pokemon = pokemon else { return nil }
        let gradient = PokemonColor.typeLinearGradient(name: pokemon.primaryType())
        gradient.frame = view.bounds
        return gradient
    }

    var pokemon: Pokemon?

    lazy private var closeButon: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = margin/2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    @objc private func closeButton(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }

    private func setup() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = pokemon.formattedNumber()

        guard let gradient = gradient else { return }
        view.layer.insertSublayer(gradient, at: 0)

        guard let types = pokemon.types else { return }
        buildTypes(types)
    }

    private func setupUI() {
        view.addSubview(closeButon)
        closeButon.topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        closeButon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true

        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: closeButon.bottomAnchor, constant: margin).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: closeButon.leftAnchor).isActive = true
        nameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true

        view.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        idLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true

        view.addSubview(typesStackView)
        typesStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: margin).isActive = true
        typesStackView.leftAnchor.constraint(equalTo: closeButon.leftAnchor).isActive = true
        typesStackView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    private func buildTypes(_ types: [String]) {
        types.forEach { type in
            let padding = 20.0
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = type.capitalized
            label.backgroundColor = .white.withAlphaComponent(0.30)
            label.layer.cornerRadius = 7.0
            label.layer.masksToBounds = true
            let paddedWidth = label.intrinsicContentSize.width + padding
            label.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            typesStackView.addArrangedSubview(label)
        }
    }

}
