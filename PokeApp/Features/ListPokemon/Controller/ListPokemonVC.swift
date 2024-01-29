//
//  ListPokemonVC.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import Foundation
import UIKit

class ListPokemonVC : UIViewController{
    
    @IBOutlet weak var listPokemonTableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    private var listPokemonVM = ListPokemonVM()
    private var selectedIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListPokemon(isNext: false)
        
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
        listPokemonTableView.register(UINib.init(nibName: "ListPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonTableViewCell")
        listPokemonTableView.delegate = self
        listPokemonTableView.dataSource = self
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GoToListSource"{
//            if let destVC = segue.destination as? ListSourceViewController {
//                
//                let categoryVM = categoriesViewModel.modelAt(self.selectedIndex)
//                destVC.category = categoryVM.item.categoryName ?? "business" // justdefault value
//                destVC.categoryImage = categoryVM.item.categoryImage ?? ""
//                destVC.modalPresentationStyle = .fullScreen
//            }
//        }
//    }
    
    func getListPokemon(isNext : Bool){
        LoadingScreen.sharedInstance.showIndicator()
        listPokemonVM.getListPokemon(isNext: false) { result in
            DispatchQueue.main.async {
                self.listPokemonTableView.reloadData()
                LoadingScreen.sharedInstance.hideIndicator()

            }
        }
    }
   
}

extension ListPokemonVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPokemonVM.numberOfRows(section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableViewCell", for: indexPath)  as! ListPokemonTableViewCell
        
        
        let pokemonVM = listPokemonVM.getPokemon(at: indexPath.row)
        cell.setUI(title: pokemonVM.name ?? "", imageUrl: pokemonVM.sprites?.frontDefault ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // need to pass your indexpath then it showing your indicator at bottom
        tableView.addLoading(indexPath) {
            // add your code here
            // append Your array and reload your tableview
            self.getAnotherListPokemon(isNext: true)
            tableView.stopLoading() // stop your indicator
        }
    }
    
    func getAnotherListPokemon(isNext : Bool){
        listPokemonVM.getListPokemon(isNext: isNext){ result in
            DispatchQueue.main.async {
                if result.count != 0{
                    self.listPokemonTableView.reloadData()
                }
            }
        }
    }
    
    
}


extension UITableView {
    
    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            
            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .large
            } else {
                // Fallback on earlier versions
                activityIndicatorView.style = .whiteLarge
            }
            
            activityIndicatorView.color = UIColor(red: 0.95, green: 0.43, blue: 0.23, alpha: 1.00)
            activityIndicatorView.hidesWhenStopped = true
            
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        }
        else {
            return activityIndicatorView
        }
    }
    
    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }
    
    func stopLoading() {
        if self.tableFooterView != nil {
            self.indicatorView().stopAnimating()
            self.tableFooterView = nil
        }
        else {
            self.tableFooterView = nil
        }
    }
}
