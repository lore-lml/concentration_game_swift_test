//
//  ViewController.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 15/11/21.
//

import UIKit

class ViewController: UIViewController {
    // Init a variable once it is needed aka on the first use
    private lazy var game = Concentration(numberOfPairs: numberOfPairs)
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private var numberOfPairs: Int{
        return cardButtons.count / 2
    }
    
    private var emojiSet = ["👻", "🎃", "🧙🏻‍♀️", "🦇", "💀", "🧟‍♀️", "🧛🏻‍♂️", "🧞"]
    
    private var emojiDict = [Card:String]()
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender){
            flipCount += self.game.chooseCard(at: cardIndex) ? 1:0
            updateViewFromModel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: -5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }

    private func updateViewFromModel(){
        for i in cardButtons.indices{
            let button = cardButtons[i]
            let card = self.game.cards[i]
            if !card.isFaceUp{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.orange.withAlphaComponent(0) : UIColor.orange
            }else{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0) : UIColor.white
            }
        }
    }
    
    private func emoji(for card: Card) -> String{
        if emojiDict[card] == nil, emojiSet.count > 0{
            let emojiIndex = emojiSet.count.random_uniform
            emojiDict[card] = emojiSet.remove(at: emojiIndex)
        }
        return emojiDict[card] ?? "?"
    }
}


extension Int{
    var random_uniform: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        
        return 0
    }
}
