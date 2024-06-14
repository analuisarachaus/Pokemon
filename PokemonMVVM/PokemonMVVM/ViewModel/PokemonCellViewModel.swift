//
//  PokemonCellViewModel.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 13/06/24.
//

import Foundation

class PokemonCellViewModel {
    var pokemon: Pokemon
    var service: PokemonService
    var imageData: Data?

    init(pokemon: Pokemon, service: PokemonService = PokemonService()) {
        self.pokemon = pokemon
        self.service = service
    }

    func fetchImage() async -> Data {
        let image = try! await service.getSprites(string: pokemon.sprites.front)
        imageData = image
        return image
    }
}
