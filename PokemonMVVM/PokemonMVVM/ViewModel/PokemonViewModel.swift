//
//  PokemonViewModel.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import Foundation

class PokemonViewModel {
    var pokemons: [Pokemon]
    var service: PokemonService

    init(pokemons: [Pokemon] = [], service: PokemonService = PokemonService()) {
        self.pokemons = pokemons
        self.service = service
    }

    func fetch(onSuccess: () -> Void) async throws {
        let list = try await service.getPokemons()
        for result in list.results {
            if let url = result["url"] {
                let pokemon = try await service.getPokemon(string: url)
                pokemons.append(pokemon)
            }
        }

        onSuccess()
    }

    func buildViewModel(for index: Int) -> PokemonCellViewModel {
        .init(pokemon: pokemons[index], service: service)
    }
}
