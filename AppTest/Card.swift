//
//  Card.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 16/11/21.
//

import Foundation

struct Card: Hashable{
    private static var idFactory = 0
    private var id: Int
    var isFaceUp = false
    var isMatched = false
    
    private static func getUniqueId() -> Int{
        idFactory += 1
        return idFactory
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    
    init(){
        self.id = Card.getUniqueId()
    }
}
