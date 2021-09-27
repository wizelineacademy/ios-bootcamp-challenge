//
//  Pokemon.swift
//  iOS Bootcamp Challenge
//
//  Created by Jorge Benavides on 26/09/21.
//

import Foundation

struct Pokemon: Decodable, Equatable {

    let id: Int
    let name: String
    let image: String?
    let types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case type
        case types
        case sprites
        case front_default
    }
    
    static func decode(json: JSON?) -> Pokemon? {
        guard let json = json else { return nil }
        return try? JSONDecoder().decode(Pokemon.self, from: json.data)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let image_container = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        image = try? image_container.decode(String.self, forKey: .front_default)
        
        // TODO: Decode list of types
        
        var types_array = try container.nestedUnkeyedContainer(forKey: .types)
        var poke_types:[String] = []
        while(!types_array.isAtEnd) {
            let types_container = try types_array.nestedContainer(keyedBy: CodingKeys.self)
            let type_container = try types_container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
            poke_types.append(try type_container.decode(String.self, forKey: .name))
        }
        types = poke_types
    }

}
