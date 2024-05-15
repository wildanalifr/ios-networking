//
//  PokemonViewModel.swift
//  networking
//
//  Created by Wildan on 13/05/24.
//

import Foundation

//ObservableObject is Protocol from swift that can update ui automatically with @Published

class PokemonViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonModel] = []
    @Published var errorMessage: String = ""
    
    private let pokemonService = PokemonService()
    
    init() {
        fetchingData()
    }
    
    func fetchingData() {
        pokemonService.fetchData { [weak self] pokemons, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }else if let pokemons = pokemons {
                DispatchQueue.main.async {
                    self?.pokemons = pokemons
                }
            }
        }
    }
    
}
