//
//  PokemonDetailTypesCollectionViewCell.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import UIKit

class PokemonDetailTypesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var typesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        resetUI()
        
        roundedView.backgroundColor = UIColor.white
        roundedView.layer.cornerRadius = 14.0
        roundedView.layer.shadowColor = UIColor.gray.cgColor
        roundedView.layer.shadowOffset = CGSize(width: 1, height: 1)
        roundedView.layer.shadowRadius = 1
        roundedView.layer.shadowOpacity = 5
        
       
        // Initialization code
    }
    
    func resetUI(){
        self.typesLabel.text = ""
    }
    
    func setUI(type: String){
        DispatchQueue.main.async {
            self.typesLabel.text = type
            self.typesLabel.textColor = UIColor.black
           
        }
    }

}
