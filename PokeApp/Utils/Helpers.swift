//
//  Helpers.swift
//  PokeApp
//
//  Created by Edwin Niwarlangga on 30/01/24.
//

import Foundation
import UIKit
import SwiftEntryKit

public class Helpers {

    public static func isPrimeNumber(_ number: Int) -> Bool {
        guard number >= 2     else { return false }
        guard number != 2     else { return true  }
        guard number % 2 != 0 else { return false }
        
        return !stride(from: 3, through: Int(sqrt(Double(number))), by: 2).contains { number % $0 == 0 }
    }
    
    public static func getRandomNumber(start: Int, end: Int) -> Int {
        let randomInt = Int.random(in: start...end)
        return randomInt
    }
    
    public static func getRandomBool() -> Bool {
        return Bool.random()
    }
    
    public static func getFibonacciNumber(_ n: Int) -> Int{
        guard n != 0, n != 1 else { return n }
        return getFibonacciNumber(n - 1) + getFibonacciNumber(n - 2)
    }
}

extension Helpers{
    static func getMyPokemonList() -> [MyPokemon] {
        guard let data = PreferenceServices.getData(key: .myPokeList) else {
            return []
        }
        
        guard let pokemonList = try?
                JSONDecoder().decode([MyPokemon].self, from: data) else { return []}
        
        return pokemonList
    }
    
    static func saveMyPokemonList(pokemonList: [MyPokemon]){
        guard !pokemonList.isEmpty,
              let jsonData = try? JSONEncoder().encode(pokemonList) else {
            return
        }
        
        PreferenceServices.saveData(key: .myPokeList, value: jsonData)
    }
}

extension Helpers{
    public static func showBottomToast(title: String? = nil, body: String?, isWarning: Bool = true) {
        DispatchQueue.main.async {
            SwiftEntryKit.dismiss(.all)
            // Generate top floating entry and set some properties
            let green = EKColor(red: 22, green: 161, blue: 99)
            let red = EKColor(red: 161, green: 22, blue: 22)
            
            
            var attributes = EKAttributes.bottomFloat
            attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: isWarning ? red : green)
            attributes.displayDuration = 5
            attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 2)))
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 5, offset: .zero))
            attributes.statusBar = .dark
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
            
            
            let title = EKProperty.LabelContent(text: title ?? "", style: .init(font: UIFont(name: "Trebuchet MS", size: 16)!, color: EKColor(light: UIColor.black, dark: UIColor.white)))
            let description = EKProperty.LabelContent(text: body ?? "", style: .init(font: UIFont(name: "Trebuchet MS", size: 14)!, color: .white))
            
            let simpleMessage = EKSimpleMessage(image: nil, title: title, description: description)
            let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
            let contentView = EKNotificationMessageView(with: notificationMessage)
            
            
            SwiftEntryKit.display(entry: contentView, using: attributes)
        }
    }
}


extension Helpers{
    static func showFormAlert(pokemonName: String, pokemonImage: String, rename: String = "",  completion: @escaping (MyPokemon) -> Void){
        var attributes: EKAttributes = .centerFloat
        
        let colors: [EKColor] = [
            EKColor(red: 211, green: 211, blue: 223),
            EKColor(red: 198, green: 197, blue: 229),
            EKColor(red: 185, green: 182, blue: 234),
            EKColor(red: 172, green: 168, blue: 240),
        ]
        attributes.entryBackground = .gradient(gradient: .init(colors: colors, startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        
        attributes.screenBackground = .color(color: EKColor(UIColor(white: 0.5, alpha: 0.5)))
        
        attributes.roundCorners = .all(radius: 12)
        
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        let offset = EKAttributes.PositionConstraints.KeyboardRelation.Offset(bottom: 10, screenEdgeResistance: 20)
        let keyboardRelation = EKAttributes.PositionConstraints.KeyboardRelation.bind(offset: offset)
        attributes.positionConstraints.keyboardRelation = keyboardRelation
        
        let titleLabel = EKProperty.LabelContent(
            text: "Add Nickname to your Pokemon",
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 18, weight: .semibold),
                color: EKColor(red: 37, green: 35, blue: 34),
                alignment: .center,
                numberOfLines: 1
            )
        )
        var nameTF = createTextField(placeholder: "Pokemon Nickname", leadingImage:  UIImage(systemName: "person.crop.circle"))
        if rename != "" {
            nameTF.textContent = rename
        }
        
        let buttonLabel = EKProperty.LabelContent(
            text: "Submit",
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 16, weight: .semibold),
                color: EKColor(red: 37, green: 35, blue: 34),
                alignment: .center,
                numberOfLines: 1
            )
        )
        
        let button = EKProperty.ButtonContent(
            label: buttonLabel,
            backgroundColor: .white,
            highlightedBackgroundColor: .white,
            contentEdgeInset: 8) {
                let myPokemon = MyPokemon(nickname: nameTF.textContent, realname: pokemonName , isAlreadyRename: false, attemptRename: 0, frontImage: pokemonImage)
                completion(myPokemon)
                SwiftEntryKit.dismiss()
            }
        
        let entry = EKFormMessageView(
              with: titleLabel,
              textFieldsContent: [nameTF],
              buttonContent: button
          )
        
       

          SwiftEntryKit.display(entry: entry, using: attributes)
    }
    
    public static func createTextField(placeholder: String, leadingImage: UIImage?, keyboardType: UIKeyboardType = .default) -> EKProperty.TextFieldContent {
        EKProperty.TextFieldContent(
            keyboardType: keyboardType,
            placeholder: getPlaceholder(with: placeholder),
            tintColor: EKColor(red: 37, green: 35, blue: 34),
            textStyle: EKProperty.LabelStyle(font: .systemFont(ofSize: 16), color: EKColor(red: 37, green: 35, blue: 34)),
            leadingImage: leadingImage,
            bottomBorderColor: EKColor(red: 93, green: 89, blue: 87)
        )
    }
    
    public static func getPlaceholder(with text: String) -> EKProperty.LabelContent {
        EKProperty.LabelContent(
            text: text,
            style: EKProperty.LabelStyle(
                font: .systemFont(ofSize: 16),
                color: EKColor(red: 93, green: 89, blue: 87)
            )
        )
    }
}
