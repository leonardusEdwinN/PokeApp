//
//  MyPokemonListVC.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//

import Foundation
import UIKit

class MyPokemonListVC : UIViewController{
    
    @IBOutlet weak var listPokemonTableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    private var myPokemonVM = DetailPokemonVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPokemonVM.getMyPokemonList()
        
        
        self.registerCell()
        self.setUINavigation()
        
        listPokemonTableView.showsVerticalScrollIndicator = false
        listPokemonTableView.showsHorizontalScrollIndicator = false
        listPokemonTableView.reloadData()
    }
    
    func setUINavigation(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
    }
    
    func registerCell(){
        listPokemonTableView.register(UINib.init(nibName: "MyPokemonListTableViewCell", bundle: nil), forCellReuseIdentifier: "myPokemonTableViewCell")
        listPokemonTableView.delegate = self
        listPokemonTableView.dataSource = self
    }
   
}

extension MyPokemonListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPokemonVM.getCountMyPokemonList()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPokemonTableViewCell", for: indexPath)  as! MyPokemonListTableViewCell
        
        let pokemonVM = myPokemonVM.getPokemon(at: indexPath.row)
        cell.setUI(realname: pokemonVM.realname ?? "", nickname: pokemonVM.nickname ?? "", imageUrl: pokemonVM.frontImage ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            let pokemon = self.myPokemonVM.getPokemon(at: indexPath.row)
            let fibonacciNumber = Helpers.getFibonacciNumber(pokemon.attemptRename ?? 0)
            var renamePokemon = ""
            
            if !(pokemon.isAlreadyRename ?? false) {
                renamePokemon = (pokemon.nickname ?? "") + "-" + "\(fibonacciNumber)"
            } else {
                let pokemonArray = pokemon.nickname?.split(separator: "-")
                renamePokemon = (pokemonArray?.first ?? "") + "-" + "\(fibonacciNumber)"
            }
            
            Helpers.showFormAlert(pokemonName: pokemon.realname ?? "", pokemonImage: pokemon.frontImage ?? "", rename: renamePokemon) { [self] myPokemon in
                var attemp = (pokemon.attemptRename ?? 0) + 1
                var pokemon = MyPokemon(
                    nickname: myPokemon.nickname,
                    realname: myPokemon.realname,
                    isAlreadyRename: true,
                    attemptRename: attemp,
                    frontImage: myPokemon.frontImage
                )
                
                myPokemonVM.editPokemon(pokemon: pokemon, at: indexPath.row)
                tableView.reloadData()
                Helpers.showBottomToast(body: "Successfully Rename pokemon", isWarning: false)
                
            }
        }
        editAction.backgroundColor = .darkGray
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Release") { (action, view, handler) in
            
            let numberRandom = Helpers.getRandomNumber(start: 0, end: 100)
            
            if Helpers.isPrimeNumber(numberRandom) {
                let pokemonRelease = self.myPokemonVM.getPokemon(at: indexPath.row)
                self.myPokemonVM.deletePokemonOnList(at: indexPath.row)
                Helpers.showBottomToast(body: "\(pokemonRelease.nickname ?? "") Release!!", isWarning: false)
                self.listPokemonTableView.reloadData()
            } else {
                Helpers.showBottomToast(body: "Sorry cannot release pokemon, Try Again later!")
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
