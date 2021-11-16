//
//  ViewController.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 15/11/21.
//

import UIKit

class ViewController: UIViewController {
    // Init a variable once it is needed aka on the first use
    lazy var game = Concentration(numberOfPairs: cardButtons.count / 2)
    var flipCount = 0{
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiSet = ["👻", "🎃", "🧙🏻‍♀️", "🦇", "💀", "🧟‍♀️", "🧛🏻‍♂️", "🧞"]
    
    var emojiDict = [Int:String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender){
            flipCount += self.game.chooseCard(at: cardIndex) ? 1:0
            updateViewFromModel()
        }
    }

    func updateViewFromModel(){
        for i in cardButtons.indices{
            let button = cardButtons[i]
            let card = self.game.cards[i]
            if !card.isFaceUp{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = UIColor.orange
            }else{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0) : UIColor.white
            }
        }
    }
    
    func emoji(for card: Card) -> String{
        if emojiDict[card.id] == nil, emojiSet.count > 0{
            let emojiIndex = Int(arc4random_uniform(UInt32(emojiSet.count)))
            emojiDict[card.id] = emojiSet.remove(at: emojiIndex)
        }
        return emojiDict[card.id] ?? "?"
    }
}

