//
//  PreferenceServices.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//

import Foundation

public struct PreferenceServices {
    
    public enum PreferenceKey: String{
        case myPokeList = "MY_POKEMON_LIST"
    }
    
    static let pref = UserDefaults.standard
    
    public static func saveObject(key: PreferenceKey, value: AnyObject){
        var data: Data?
        if #available(iOS 11.0, *) {
            data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        } else {
            // Fallback on earlier versions
            data = NSKeyedArchiver.archivedData(withRootObject: value)
        }
        pref.set(data, forKey: key.rawValue)
        commit()
    }
    
    public static func saveDictionary(key: PreferenceKey, value: [String: Any?]){
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func saveBool(key: PreferenceKey, value: Bool){
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func saveInt(key: PreferenceKey, value: Int) {
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func saveString(key:PreferenceKey, value: String) {
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func saveArray(key: PreferenceKey, value: [Any]) {
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func commit(){
        pref.synchronize()
    }
    
    public static func remove(key: PreferenceKey) {
        pref.removeObject(forKey: key.rawValue)
    }
    
    public static func getObject(key: PreferenceKey) -> AnyObject?{
        if let data = pref.object(forKey: key.rawValue) as? NSData {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: data as Data)!
            return obj as AnyObject?
        }
        return nil
    }
    
    public static func getString(key: PreferenceKey) -> String{
        if let string = pref.string(forKey: key.rawValue) {
            return string
        }
        return ""
    }
    
    public static func getDictionary(key: PreferenceKey) -> [String: Any?]? {
        if let value = pref.dictionary(forKey: key.rawValue) {
            return value
        }
        return nil
    }
    
    public static func getBool(key: PreferenceKey) -> Bool {
        if pref.bool(forKey: key.rawValue) {
            return pref.bool(forKey: key.rawValue)
        }
        return false
    }
    
    public static func getInt(key: PreferenceKey) -> Int {
        return pref.integer(forKey: key.rawValue)
    }
    
    public static func getArray(key: PreferenceKey) -> [Any] {
        if let dict = pref.array(forKey: key.rawValue) {
            return dict
        }
        return []
    }
    
    public static func setLanguageSystem() { // For Google Address
        let lang = "id_ID"
        UserDefaults.standard.set([lang], forKey: "AppleLanguages")
    }
    
    public static func saveData(key: PreferenceKey, value: Data) {
        pref.set(value, forKey: key.rawValue)
        commit()
    }
    
    public static func getData(key: PreferenceKey) -> Data? {
        guard let objc = pref.object(forKey: key.rawValue) as? Data else { return nil }
        
        return objc
    }
}
