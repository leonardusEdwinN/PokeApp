//
//  ListPokemonVM.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import Foundation

class ListPokemonVM{
    private var listPokemonResponse = [ListPokemonResults]()
    private var listPokemonWithImage = [PokemonDetailResponse]()
    private var page : Int = 1

    
    func numberOfRows(_ section: Int) -> Int {
        return listPokemonWithImage.count
    }
    
    func getPokemon(at index: Int) -> PokemonDetailResponse {
        return listPokemonWithImage[index]
    }
    
    func getListPokemon(isNext: Bool, completion: @escaping ([PokemonDetailResponse]) -> Void) {
        
        if(isNext){
            self.page += 1
        }
        
        if(listPokemonResponse.count > 0 && !isNext){
            listPokemonResponse = []
        }
        
        let searchUrl = Constants.Urls.urlForGetPokemonList(limit: 10, page: self.page)

        let listPokemonsResource = Resource<ListPokemonResponse>(url: searchUrl) { data in
            let articleResponses = try? JSONDecoder().decode(ListPokemonResponse.self, from: data)
            return articleResponses
        }
        
        Webservice().load(resource: listPokemonsResource) { (result) in
            
            if let listPokemon = result?.results {
                for pokemon in listPokemon {
                    self.listPokemonResponse.append(pokemon)
                    if let idPokemon = pokemon.url?.split(separator: "/").last{
                        self.getPokemonDetail(idPokemon: String(idPokemon)) { pokemon in
                            self.listPokemonWithImage.append(pokemon)
                            if self.listPokemonWithImage.count == self.listPokemonResponse.count{
                                completion(self.listPokemonWithImage)
                            }
                        }
                    }
                    
                }
            } else {
                completion([])
            }
        }
        
    }
    
    func getPokemonDetail(idPokemon: String, completion: @escaping (PokemonDetailResponse) -> Void) {
        let searchUrl = Constants.Urls.urlForGetPokemonDetail(pokemonId: idPokemon)

        let pokemonResource = Resource<PokemonDetailResponse>(url: searchUrl) { data in
            let pokemonResponse = try? JSONDecoder().decode(PokemonDetailResponse.self, from: data)
            return pokemonResponse
        }
        
        Webservice().load(resource: pokemonResource) { (result) in
            
            if let pokemon = result {
                completion(pokemon)
            }
        }
    }
}
