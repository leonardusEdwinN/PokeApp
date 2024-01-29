//
//  String+Extensions.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 29/01/24.
//

import Foundation

extension String {
    
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
