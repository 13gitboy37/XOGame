//
//  Singleton.swift
//  XO-game
//
//  Created by Никита Мошенцев on 03.06.2022.
//

import Foundation

class Game {
    static let shared = Game()
    var gameSelection: GameSelection = .player
}
