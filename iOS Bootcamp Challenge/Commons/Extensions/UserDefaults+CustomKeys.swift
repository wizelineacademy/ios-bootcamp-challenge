//
//  UserDefaults+CustomKeys.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 28/09/21.
//

import Foundation

extension UserDefaults {

    enum Keys: String {
        case searchText
    }

    func set(_ any: Any?, forKey key: UserDefaults.Keys) {
        self.set(any, forKey: key.rawValue)
    }

    func string(forKey key: UserDefaults.Keys) -> String? {
        self.string(forKey: key.rawValue)
    }

    func bool(forKey key: UserDefaults.Keys) -> Bool? {
        self.bool(forKey: key.rawValue)
    }

}
