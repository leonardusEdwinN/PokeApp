//
//  MyPokemon.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//
import Foundation

//public class MyPokemon: NSObject, NSCoding, Decodable {
//    public var nickname: String?
//    public var realname: String?
//    public var isAlreadyRename: Bool?
//    public var attemptRename: Int?
//    override public init(){
//        super.init()
//    }
//    
//    public init( nickname: String?, realname: String?, isAlreadyRename: Bool?, attemptRename: Int?) {
//        self.nickname = nickname
//        self.realname = realname
//        self.isAlreadyRename = isAlreadyRename
//        self.attemptRename = attemptRename
//    }
//    
//    public required convenience init?(coder aDecoder: NSCoder) {
//        let nickname = aDecoder.decodeObject(forKey: "nickname") as? String
//        let realname = aDecoder.decodeObject(forKey: "realname") as? String
//        let isAlreadyRename = aDecoder.decodeObject(forKey: "is_already_rename") as? Bool
//        let attemptRename = aDecoder.decodeObject(forKey: "attempt_rename") as? Int
//        self.init(nickname: nickname, realname: realname, isAlreadyRename: isAlreadyRename, attemptRename: attemptRename)
//    }
//    
//    public func encode(with coder: NSCoder) {
//        coder.encode(self.nickname, forKey: "nickname")
//        coder.encode(self.realname, forKey: "realname")
//        coder.encode(self.isAlreadyRename, forKey: "is_already_rename")
//        coder.encode(self.attemptRename, forKey: "attempt_rename")
//    }
//}

struct MyPokemon: Decodable, Encodable {
    let nickname : String?
    let realname : String?
    let isAlreadyRename: Bool?
    let attemptRename: Int?
    let frontImage: String?
}
