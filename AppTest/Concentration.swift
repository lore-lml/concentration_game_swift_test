//
//  Concentration.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 16/11/21.
//

import Foundation

class Concentration{
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    
    init(numberOfPairs: Int){
        for _ in 0..<numberOfPairs{
            let card = Card()
//            self.cards.append(card)
//            self.cards.append(card)
//            OR BETTER
//            Structs are value types so it makes a copy whenever it is assigned or passed
            self.cards += [card, card]
        }
        
        var idxs = [Int](cards.indices)
        var newCards: [Card] = []
        for _ in cards.indices{
            let randomIdx = Int(arc4random_uniform(UInt32(idxs.count)))
            newCards.append(cards[idxs[randomIdx]])
            idxs.remove(at: randomIdx)
        }
        self.cards = newCards
    }
    
    func chooseCard(at index: Int) -> Bool{
        if index >= cards.count || cards[index].isFaceUp{
            return false
        }
        
        cards[index].isFaceUp = true
        var indexOfFaceCardResult: Int?
        if indexOfFaceUpCard == nil{
            indexOfFaceCardResult = index
            for i in cards.indices{
                cards[i].isFaceUp = i == index || cards[i].isMatched
            }
        }
        else if cards[index].id == cards[indexOfFaceUpCard!].id{
            indexOfFaceCardResult = nil
            cards[index].isMatched = true
            cards[indexOfFaceUpCard!].isMatched = true
        }
        indexOfFaceUpCard = indexOfFaceCardResult
        return true
    }
}
