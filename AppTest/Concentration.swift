//
//  Concentration.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 16/11/21.
//

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    private var indexOfFaceUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set{
            for i in cards.indices{
                cards[i].isFaceUp = i == newValue
            }
        }
    }
    
    init(numberOfPairs: Int){
        assert(numberOfPairs>0, "Cocentration: init(numberOfPairs: \(numberOfPairs)) -> numberOfPairs is not greater than 0")
        for _ in 0..<numberOfPairs{
            let card = Card()
//            self.cards.append(card)
//            self.cards.append(card)
//            OR BETTER
//            Structs are value types so it makes a copy whenever it is assigned or passed
            self.cards += [card, card]
        }
        shuffleCards()
    }
    
    private mutating func shuffleCards(){
        var idxs = [Int](cards.indices)
        var newCards: [Card] = []
        for _ in cards.indices{
            let randomIdx = idxs.count.random_uniform
            newCards.append(cards[idxs[randomIdx]])
            idxs.remove(at: randomIdx)
        }
        self.cards = newCards
    }
    
    mutating func chooseCard(at index: Int) -> Bool{
        assert(cards.indices.contains(index), "Concentration: chooseCard(at: \(index)) -> index out of range")
        if cards[index].isFaceUp || cards[index].isMatched{
            return false
        }
        
        if let i = indexOfFaceUpCard, index != i{
            if cards[index] == cards[i]{
                cards[index].isMatched = true
                cards[i].isMatched = true
            }
            cards[index].isFaceUp = true
        }else{
            indexOfFaceUpCard = index
        }
        
        return true
    }
}


extension Collection{
    var oneAndOnly: Element?{
        return self.count == 1 ? self.first : nil
    }
}
