//
//  CardView.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import UIKit

class CardView: UIView {

    private let margin: CGFloat = 30
    var card: Card?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setup()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setupUI()
    }

    private func setup() {
        guard let card = card else { return }

        card.items.forEach { _ in }

        titleLabel.text = card.title
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    private func configureLabel<T: UILabel>(lbl: inout T) -> Void {
        lbl.topAnchor.constraint(equalTo: self.topAnchor, constant: margin * 2).isActive = true
        lbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        lbl.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.70).isActive = true
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(typeLabel)
        configureLabel(lbl: &titleLabel)
        configureLabel(lbl: &nameLabel)
        configureLabel(lbl: &typeLabel)

        // TODO: Display pokemon info (eg. types, abilities)
    }

}
