//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Никита Мошенцев on 31.05.2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var gameAgainstControl: UISegmentedControl!

    public var gameAgainst: GameSelection {
        switch self .gameAgainstControl.selectedSegmentIndex {
        case 0:
            return .player
        case 1:
            return .computer
        case 2:
            return .fiveSteps
        default:
            return .player
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGameSegue":
            Game.shared.gameSelection = gameAgainst
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
