//
//  Card.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 16/11/21.
//

import Foundation

struct Card{
    static var idFactory = 0
    var id: Int
    var isFaceUp = false
    var isMatched = false
    
    static func getUniqueId() -> Int{
        idFactory += 1
        return idFactory
    }
    init(){
        self.id = Card.getUniqueId()
    }
}
