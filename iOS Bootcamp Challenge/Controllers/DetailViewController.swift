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

    lazy private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy private var cardView: CardView = {
        let title = "About"
        let cardView = CardView(card: Card(title: title, items: items))
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()

    lazy private var items: [Item] = {
        var items = [Item]()

        guard let pokemon = pokemon else { return items }

        // abilities
        if let abilities = pokemon.abilities {
            let title = "Abilities"
            let description = abilities.joined(separator: "\n")
            let item = Item(title: title, description: description)
            items.append(item)
        }

        // weight
        let weight = "Weight"
        items.append(Item(title: weight, description: "\(pokemon.weight/10) kg"))

        // baseExperience
        let baseExperience = "Base Experience"
        items.append(Item(title: baseExperience, description: "\(pokemon.baseExperience)"))

        return items
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

        if let image = pokemon.image, let url = URL(string: image) {
            imageView.kf.setImage(with: url)
        }

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

        view.addSubview(cardView)
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height/2.5).isActive = true
        cardView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        view.addSubview(imageView)
        imageView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: margin * 2).isActive = true
        imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
            let paddedWidth = label.intrinsicContentSize.width + CGFloat(padding)
            label.widthAnchor.constraint(equalToConstant: paddedWidth).isActive = true
            typesStackView.addArrangedSubview(label)
        }
    }

}
