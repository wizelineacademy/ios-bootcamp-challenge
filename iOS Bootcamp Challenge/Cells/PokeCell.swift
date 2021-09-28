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

    private var gradient: CAGradientLayer?

    // general margin for ui elements
    private let margin: CGFloat = 10

    // offset to make the pokemon image outside the "card"
    private let offset: CGFloat = 20

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .blue.withAlphaComponent(0.3)
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 3

        setupUI()
    }

    private func setupUI() {
        addSubview(backgroundBall)
        backgroundBall.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backgroundBall.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backgroundBall.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundBall.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(imageView)

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
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        idLabel.text = nil
        nameLabel.text = nil
        imageView.image = nil
        gradient?.removeFromSuperlayer()
    }

    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            idLabel.text = pokemon.formattedNumber()
            nameLabel.text = pokemon.name.capitalized

            if let image = pokemon.image, let url = URL(string: image) {
                imageView.kf.setImage(with: url)
            }

            gradient = PokemonColor.typeLinearGradient(name: pokemon.primaryType())
            guard let gradient = gradient else { return }
            gradient.frame = bounds
            contentView.layer.insertSublayer(gradient, at: 0)
        }
    }
}
