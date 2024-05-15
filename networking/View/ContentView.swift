//
//  ContentView.swift
//  networking
//
//  Created by Wildan on 13/05/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokemonViewModel = PokemonViewModel()
    
    var body: some View {
        if !pokemonViewModel.pokemons.isEmpty {
            List(pokemonViewModel.pokemons) { pokemon in
                Text(pokemon.url)
            }
        } else {
            Text("Loading...")
        }
    }
}

#Preview {
    ContentView()
}
