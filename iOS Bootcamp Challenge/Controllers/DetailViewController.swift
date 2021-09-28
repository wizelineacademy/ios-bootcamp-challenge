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
    private var gradient: CAGradientLayer?
    var pokemon: Pokemon?

    lazy private var closeButon: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        gradient = PokemonColor.typeLinearGradient(name: pokemon.primaryType())
        guard let gradient = gradient else { return }
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }

    private func setupUI() {
        view.addSubview(closeButon)
        closeButon.topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        closeButon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
    }

}
