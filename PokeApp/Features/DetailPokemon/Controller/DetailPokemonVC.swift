//
//  DetailPokemonVC.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//
import Foundation
import UIKit
import SDWebImage
import SwiftEntryKit

class DetailPokemonVC : UIViewController {
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var catchPokemonButton: UIButton!
    @IBAction func catchPokemonButtonPressed(_ sender: Any) {
        let randomBool = Helpers.getRandomBool()
        if randomBool{
            Helpers.showFormAlert(pokemonName: self.pokemonDetail?.name ?? "", pokemonImage: pokemonDetail?.sprites?.frontDefault ?? "") { [self] myPokemon in
                let pokemon = myPokemon
                pokemonDetailVM.addPokemonToList(newPokemon: myPokemon)
                
                Helpers.showBottomToast(body: "GOTCHA \(myPokemon.nickname ?? "") to your Poke List", isWarning: false)
            }
            
            
        } else {
            Helpers.showBottomToast(body: "Sorry you lost \(pokemonDetail?.name ?? ""), \(pokemonDetail?.name ?? "") FLEE")
        }
    }
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var pokemonHeightValueLabel: UILabel!
    @IBOutlet weak var pokemonWeightValueLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonTypeCollectionView: UICollectionView!
    
    @IBOutlet weak var pokemonMoveCollectionView: UICollectionView!
    
    @IBOutlet weak var pokemonMovesLabel: UILabel!
    var pokemonDetail: PokemonDetailResponse?
    var pokemonDetailVM = DetailPokemonVM()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        self.setUINavigation()
        setUI()
        
        pokemonTypeCollectionView.showsVerticalScrollIndicator = false
        pokemonTypeCollectionView.showsHorizontalScrollIndicator = false
        pokemonTypeCollectionView.reloadData()
    }
    
    func setUI(){
        pokemonNameLabel.text = pokemonDetail?.name ?? ""
        pokemonHeightValueLabel.text = "\(pokemonDetail?.height ?? 0)"
        pokemonWeightValueLabel.text = "\(pokemonDetail?.weight ?? 0)"
        
        guard
            let frontImageURL = URL(string: pokemonDetail?.sprites?.frontDefault ?? ""),
            let backImageURL = URL(string: pokemonDetail?.sprites?.backDefault ?? "")
        else {
            return
        }
        frontImageView.sd_setImage(with: frontImageURL, placeholderImage: UIImage(named: "ic_no_Image"))
        backImageView.sd_setImage(with: backImageURL, placeholderImage: UIImage(named: "ic_no_Image"))
    }
    
    func registerCell(){
        pokemonTypeCollectionView.register(UINib.init(nibName: "PokemonDetailTypesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pokemonDetailTypesCollectionViewCell")
        pokemonTypeCollectionView.delegate = self
        pokemonTypeCollectionView.dataSource = self
        pokemonMoveCollectionView.register(UINib.init(nibName: "PokemonDetailTypesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pokemonDetailTypesCollectionViewCell")
        pokemonMoveCollectionView.delegate = self
        pokemonMoveCollectionView.dataSource = self
    }
    
    func setUINavigation(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
    }
    
}

extension DetailPokemonVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.pokemonTypeCollectionView{
            return pokemonDetail?.types?.count ?? 0
        } else if collectionView == self.pokemonMoveCollectionView {
            return pokemonDetail?.moves?.count ?? 0
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonDetailTypesCollectionViewCell", for: indexPath) as! PokemonDetailTypesCollectionViewCell
        
        if collectionView == self.pokemonTypeCollectionView {
            let pokemonType = pokemonDetail?.types?[indexPath.row].type?.name ?? ""
            cell.setUI(type: pokemonType)
            return cell
        } else if collectionView == self.pokemonMoveCollectionView {
            let pokemonMove = pokemonDetail?.moves?[indexPath.row].move?.name ?? ""
            cell.setUI(type: pokemonMove)
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    
}

extension DetailPokemonVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthCell : CGSize = CGSize(width: 100, height: 100)
        
        
        if collectionView == self.pokemonTypeCollectionView{
            let pokemonType = pokemonDetail?.types?[indexPath.row].type?.name ?? ""
            let widthCellItem = (pokemonType.count * 6) + 40
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            
            widthCell =  CGSize(width: widthCellItem, height: 36) // Set your item size here
        } else if collectionView == self.pokemonMoveCollectionView {
            
            let pokemonMove = pokemonDetail?.moves?[indexPath.row].move?.name ?? ""
            let widthCellItem = (pokemonMove.count * 6) + 40
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 4
            layout.scrollDirection = .vertical
            
            widthCell =  CGSize(width: widthCellItem, height: 36) // Set your item size here
        }
        
        return widthCell
    }
}
