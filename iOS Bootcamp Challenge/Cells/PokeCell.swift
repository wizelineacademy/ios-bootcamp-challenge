//
//  PokeCell.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import UIKit
import Kingfisher

class PokeCell: UICollectionViewCell {
    static let identifier = "kPokeCollectionViewCell"

    lazy private var idLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 14)
        view.textColor = UIColor.white.withAlphaComponent(0.6)
        return view
    }()

    lazy private var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 18)
        view.textColor = UIColor.white
        return view
    }()

    lazy private var typesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private func createTypeLabel(name: String) -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 12)
        view.textColor = .white.withAlphaComponent(0.8)
        view.text = " \(name.capitalized) "
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }

    lazy private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    // background decorative pokeball
    lazy private var backgroundBall: UIImageView = {
        let view = UIImageView(image: UIImage(named: "PokeBall"))
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.1
        return view
    }()

    // view containing gradients
    lazy private var gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // general margin for ui elements
    private let margin: CGFloat = 10

    // offset to make the pokemon image outside the "card"
    private let offset: CGFloat = 20

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 16
        setupUI()
    }

    private func setupUI() {

        addSubview(backgroundBall)
        addSubview(gradientView)
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(imageView)
        addSubview(typesContainer)

        backgroundBall.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundBall.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundBall.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundBall.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        idLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        idLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        idLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true

        nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: margin).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        nameLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -offset).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset).isActive = true
        imageView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: margin).isActive = true

        typesContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: margin).isActive = true
        typesContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        typesContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        typesContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin).isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        idLabel.text = nil
        nameLabel.text = nil
        imageView.image = nil
        gradientView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        typesContainer.subviews.forEach { $0.removeFromSuperview() }
    }

    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            idLabel.text = pokemon.formattedNumber()
            nameLabel.text = pokemon.name.capitalized

            if let image = pokemon.image, let url = URL(string: image) {
                imageView.kf.setImage(with: url)
            }

            for type in pokemon.types ?? [] {
                let last = typesContainer.subviews.last
                let view = createTypeLabel(name: type)
                typesContainer.addSubview(view)

                if let last = last {
                    view.leftAnchor.constraint(equalTo: last.rightAnchor, constant: 4).isActive = true
                } else {
                    view.leftAnchor.constraint(equalTo: typesContainer.leftAnchor).isActive = true
                }
                view.bottomAnchor.constraint(equalTo: typesContainer.bottomAnchor).isActive = true
            }

            let gradient = PokemonColor.typeLinearGradient(name: pokemon.primaryType())
            gradient.frame = bounds
            gradientView.layer.insertSublayer(gradient, at: 0)
        }
    }
}
