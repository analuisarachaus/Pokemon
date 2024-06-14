//
//  PokemonService.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import Foundation

class PokemonService {

    enum PokemonServiceError: Error {
        case invalidURL
        case invalidResponse
        case decodingError
    }

    func getPokemons() async throws -> PokemonList {

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=30&offset=0") else { throw PokemonServiceError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PokemonServiceError.invalidResponse
        }

        do {
            let pokemons = try JSONDecoder().decode(PokemonList.self, from: data)
            return pokemons
        } catch {
            throw PokemonServiceError.decodingError
        }

    }

    func getPokemon(string: String) async throws -> Pokemon {
        guard let url = URL(string: string) else { throw PokemonServiceError.invalidURL }

            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw PokemonServiceError.invalidResponse
            }

            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return pokemon
            } catch {
                throw PokemonServiceError.decodingError
            }

    }

    func getSprites(string: String) async throws -> Data {

        guard let url = URL(string: string) else { throw PokemonServiceError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PokemonServiceError.invalidResponse
        }

        return data
    }

}
