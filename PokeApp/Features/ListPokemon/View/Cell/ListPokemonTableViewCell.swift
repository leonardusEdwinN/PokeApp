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
    @IBOutlet weak var pokemonCategoryCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetUI()
    
        
        viewRounded.backgroundColor = UIColor.white
        viewRounded.layer.cornerRadius = 15.0
        viewRounded.layer.shadowColor = UIColor.gray.cgColor
        viewRounded.layer.shadowOffset = CGSize(width: 1, height: 1)
        viewRounded.layer.shadowRadius = 1
        viewRounded.layer.shadowOpacity = 5
        
       
        // Initialization code
    }
    
    func resetUI(){
        self.pokemonNameLabel.text = ""
//        self.newsSource.text = ""
//        self.newsAuthor.text = ""
//        self.newsCreatedAt.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(title: String, imageUrl: String){
        DispatchQueue.main.async {
            
            self.pokemonNameLabel.text = title
            
            guard let imageURL = URL(string: imageUrl) else { return }
            self.pokemonImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "noImage"))
        
//            self.newsSource.text = description
//            self.newsAuthor.text = author
//            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//            dateFormatter.timeZone = TimeZone(abbreviation: "WIB")
//            let dateTemp = dateFormatter.date(from: createdAt)
//            
//            
//            dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss"
//            self.newsCreatedAt.text = dateFormatter.string(from: dateTemp ?? Date())
            
           
        }
    }
    
//    func setUI(imageURL: String, title: String, createdAt : String, author: String, description : String){
//        DispatchQueue.main.async {
//
//            self.newsTitle.text = title
//            self.newsDescription.text = description
//            self.newsAuthor.text = author
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//            dateFormatter.timeZone = TimeZone(abbreviation: "WIB")
//            let dateTemp = dateFormatter.date(from: createdAt)
//
//
//            dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss"
////            print("Dateobj: \(dateFormatter.string(from: dateTemp ?? Date())) :: DATETEMP : \(dateTemp) :: CREATED AT : \(createdAt)")
//
//
//
//            self.newsCreatedAt.text = dateFormatter.string(from: dateTemp ?? Date())
//
//            let imageUrl: URL = URL(string: imageURL)!
//            let imageData : NSData = NSData(contentsOf: imageUrl)!
//            let image = UIImage(data: imageData as Data)
//            self.newsImage.image = image
//
//        }
//    }
    
}
