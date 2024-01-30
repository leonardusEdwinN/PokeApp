//
//  DetailPokemonVM.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//
import Foundation

class DetailPokemonVM {
    private var listMyPokemon = [MyPokemon]()

    func getMyPokemonList(){
        listMyPokemon = Helpers.getMyPokemonList()
    }
    
    func addPokemonToList(newPokemon : MyPokemon){
        getMyPokemonList()
        listMyPokemon.append(newPokemon)
        Helpers.saveMyPokemonList(pokemonList: listMyPokemon)
    }
    
    func getPokemon(at index: Int) -> MyPokemon {
        return listMyPokemon[index]
    }
    
    func getCountMyPokemonList() -> Int{
        getMyPokemonList()
        return listMyPokemon.count
    }
    
    func deletePokemonOnList(at index: Int){
        getMyPokemonList()
        
        listMyPokemon.remove(at: index)
        Helpers.saveMyPokemonList(pokemonList: listMyPokemon)
        
    }
    
    func editPokemon(pokemon: MyPokemon, at index: Int){
        listMyPokemon[index] = pokemon
        Helpers.saveMyPokemonList(pokemonList: listMyPokemon)
    }
    
}
