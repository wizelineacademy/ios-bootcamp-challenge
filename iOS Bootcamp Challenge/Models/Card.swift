//
//  Card.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import Foundation

class Card {

    let title: String
    let items: [Item]

    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }

}
