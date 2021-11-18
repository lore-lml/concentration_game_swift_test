//
//  ConcentrationThemeChooserViewController.swift
//  AppTest
//
//  Created by Lorenzo Limoli on 18/11/21.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    let themes = [
        "sports":"⚽️⛷🏐🏀🎱🎾🏓🏸",
        "animals":"🐱🐈🐈‍⬛🐭🐹🐶🐷🐴",
        "halloween":"👻🎃🧙🏻‍♀️🦇💀🧟‍♀️🧛🏻‍♂️🧞"
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "Choose Theme"{
            return
        }
        
        guard let themeName = (sender as? UIButton)?.currentTitle?.lowercased(), let chosenTheme = themes[themeName] else{
            return
        }
        
        guard let concentrationController = segue.destination as? ConcentrationViewController else{
            return
        }
        
        concentrationController.theme = chosenTheme
    }
    

}
