//
//  Command.swift
//  XO-game
//
//  Created by Никита Мошенцев on 06.06.2022.
//

import Foundation

protocol Command {
    func execute(delay: Double)
}

class PlayerGameCommand: Command {
    
    private var player: Player
    private var position: GameboardPosition
    private var markView: MarkView
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    private var refeere: Referee?
    
    init (position: GameboardPosition, player: Player, gameboard: Gameboard, gameboardView: GameboardView, markView: MarkView) {
        self.position = position
        self.player = player
        self.markView = markView
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.refeere = Referee(gameboard: gameboard)
    }
    
    func execute(delay: Double) {
        guard let gameboardView = gameboardView else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [self] in
                    gameboardView.removeMarkView(at: position)
                    gameboardView.placeMarkView(markView, at: position)
                    gameboard?.setPlayer(player, at: position)
                    }
        }
}

