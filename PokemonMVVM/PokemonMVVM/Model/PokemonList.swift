//
//  PokemonList.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import Foundation

struct PokemonList: Decodable {
    let results: [[String: String]]
}

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
}

struct Sprites: Decodable {
    let front: String

    enum CodingKeys: String, CodingKey {
        case front = "front_default"
    }
}
