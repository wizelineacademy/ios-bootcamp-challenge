//
//  PokemonColor.swift
//  iOS Bootcamp Challenge
//
//  Created by Marlon David Ruiz Arroyave on 27/09/21.
//

import Foundation
import UIKit

struct PokemonColor {

    // swiftlint:disable:next cyclomatic_complexity
    static func typeLinearGradient(name: String?) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        let type = PokemonType(rawValue: name ?? "")
        switch type {
        case .grass:
            gradient.colors = [UIColor.primaryGrass, UIColor.secondaryGrass]
            return gradient
        case .poison:
            gradient.colors = [UIColor.primaryPoison, UIColor.secondaryPoison]
            return gradient
        case .fire:
            gradient.colors = [UIColor.primaryFire, UIColor.secondaryFire]
            return gradient
        case .flying:
            gradient.colors = [UIColor.primaryFlying, UIColor.secondaryFlying]
            return gradient
        case .bug:
            gradient.colors = [UIColor.primaryBug, UIColor.secondaryBug]
            return gradient
        case .water:
            gradient.colors = [UIColor.primaryWater, UIColor.secondaryWater]
            return gradient
        case .fighting:
            gradient.colors = [UIColor.primaryFighting, UIColor.secondaryFighting]
            return gradient
        case .ice:
            gradient.colors = [UIColor.primaryIce, UIColor.secondaryIce]
            return gradient
        case .electric:
            gradient.colors = [UIColor.primaryElectric, UIColor.secondaryElectric]
            return gradient
        case .ground:
            gradient.colors = [UIColor.primaryGround, UIColor.secondaryGround]
            return gradient
        default:
            gradient.colors = [UIColor.primaryNormal, UIColor.secondaryNormal]
            return gradient
        }
    }

}

extension UIColor {

    static let primaryWater = UIColor(red: 85.0/255, green: 158.0/255, blue: 223.0/255, alpha: 0.8).cgColor
    static let secondaryWater = UIColor(red: 105.0/255, green: 185.0/255, blue: 227.0/255, alpha: 0.8).cgColor
    static let primaryGrass = UIColor(red: 95.0/255, green: 188.0/255, blue: 81.0/255, alpha: 0.8).cgColor
    static let secondaryGrass = UIColor(red: 90.0/255, green: 193.0/255, blue: 120.0/255, alpha: 0.8).cgColor
    static let primaryBug = UIColor(red: 146.0/255, green: 188.0/255, blue: 44.0/255, alpha: 0.8).cgColor
    static let secondaryBug = UIColor(red: 175.0/255, green: 200.0/255, blue: 54.0/255, alpha: 0.8).cgColor
    static let primaryNormal = UIColor(red: 146.0/255, green: 152.0/255, blue: 164.0/255, alpha: 0.8).cgColor
    static let secondaryNormal = UIColor(red: 163.0/255, green: 164.0/255, blue: 158.0/255, alpha: 0.8).cgColor
    static let primaryFire = UIColor(red: 251.0/255, green: 155.0/255, blue: 81.0/255, alpha: 0.8).cgColor
    static let secondaryFire = UIColor(red: 251.0/255, green: 174.0/255, blue: 70.0/255, alpha: 0.8).cgColor
    static let primaryPoison = UIColor(red: 168.0/255, green: 100.0/255, blue: 199.0/255, alpha: 0.8).cgColor
    static let secondaryPoison = UIColor(red: 194.0/255, green: 97.0/255, blue: 212.0/255, alpha: 0.8).cgColor
    static let primaryFlying = UIColor(red: 144.0/255, green: 167.0/255, blue: 218.0/255, alpha: 0.8).cgColor
    static let secondaryFlying = UIColor(red: 166.0/255, green: 194.0/255, blue: 242.0/255, alpha: 0.8).cgColor
    static let primaryFighting = UIColor(red: 206.0/255, green: 66.0/255, blue: 101.0/255, alpha: 0.8).cgColor
    static let secondaryFighting  = UIColor(red: 231.0/255, green: 67.0/255, blue: 71.0/255, alpha: 0.8).cgColor
    static let primaryIce = UIColor(red: 112.0/255, green: 204.0/255, blue: 189.0/255, alpha: 0.8).cgColor
    static let secondaryIce  = UIColor(red: 140.0/255, green: 221.0/255, blue: 212.0/255, alpha: 0.8).cgColor
    static let primaryElectric = UIColor(red: 237.0/255, green: 213.0/255, blue: 62.0/255, alpha: 0.8).cgColor
    static let secondaryElectric  = UIColor(red: 251.0/255, green: 226.0/255, blue: 115.0/255, alpha: 0.8).cgColor
    static let primaryGround = UIColor(red: 220.0/255, green: 117.0/255, blue: 69.0/255, alpha: 0.8).cgColor
    static let secondaryGround  = UIColor(red: 210.0/255, green: 148.0/255, blue: 99.0/255, alpha: 0.8).cgColor

}
