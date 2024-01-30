//
//  MyPokemonListTableViewCell.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//

import UIKit

class MyPokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewRounded: UIView!
    @IBOutlet weak var pokemonRealNameLabel: UILabel!
    @IBOutlet weak var pokemonNickNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetUI()
        viewRounded.backgroundColor = UIColor.white
        viewRounded.layer.cornerRadius = 15.0
        viewRounded.layer.shadowColor = UIColor.gray.cgColor
        viewRounded.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewRounded.layer.shadowRadius = 1
        viewRounded.layer.shadowOpacity = 5
    }
    
    func resetUI(){
        self.pokemonRealNameLabel.text = ""
        self.pokemonNickNameLabel.text = ""
        
        self.pokemonImageView.image = UIImage(named:"ic_no_Image")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(realname: String, nickname: String, imageUrl: String){
        DispatchQueue.main.async {
            
            self.pokemonRealNameLabel.text = realname
            self.pokemonNickNameLabel.text = "Nick: " + nickname
            
            guard let imageURL = URL(string: imageUrl) else { return }
            self.pokemonImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "ic_no_Image"))
           
        }
    }
    
}
