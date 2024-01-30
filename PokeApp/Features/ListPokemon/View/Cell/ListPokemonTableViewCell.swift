//
//  ListPokemonTableViewCell.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import UIKit
import SDWebImage

class ListPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRounded: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetUI()
    
        viewRounded.backgroundColor = UIColor.colorPrimary
        viewRounded.layer.cornerRadius = 15.0
        viewRounded.layer.shadowColor = UIColor.gray.cgColor
        viewRounded.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewRounded.layer.shadowRadius = 1
        viewRounded.layer.shadowOpacity = 5
        
    }
    
    func resetUI(){
        self.pokemonNameLabel.text = ""
        self.pokemonImageView.image = UIImage(named:"ic_no_Image")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(title: String, imageUrl: String){
        DispatchQueue.main.async {
            
            self.pokemonNameLabel.text = title
            
            guard let imageURL = URL(string: imageUrl) else { return }
            self.pokemonImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "ic_no_Image"))
           
        }
    }
    
}
