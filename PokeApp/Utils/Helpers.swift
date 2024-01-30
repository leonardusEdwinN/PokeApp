//
//  Helpers.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//

import Foundation

public class Helpers {
    func isPrimeNumber(_ number: Int) -> Bool {
        guard number >= 2     else { return false }
        guard number != 2     else { return true  }
        guard number % 2 != 0 else { return false }
        
        return !stride(from: 3, through: Int(sqrt(Double(number))), by: 2).contains { number % $0 == 0 }
    }
    
    public func getRandomNumber(start: Int, end: Int) -> Int {
        let randomInt = Int.random(in: start...end)
        return randomInt
    }
    
    public func getRandomBool() -> Bool {
        return Bool.random()
    }
    
    public func getFibonacciNumber(_ n: Int) -> Int{
        guard n != 0, n != 1 else { return n }
        return getFibonacciNumber(n - 1) + getFibonacciNumber(n - 2)
    }
}
