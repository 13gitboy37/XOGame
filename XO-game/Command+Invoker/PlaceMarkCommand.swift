//
//  PlaceMarkCommand.swift
//  XO-game
//
//  Created by Никита Мошенцев on 07.06.2022.
//

import Foundation

public func PlaceMarkCommand(position: GameboardPosition, player: Player, gameboard: Gameboard, gameboardView: GameboardView, markView: MarkView) {
    let command = PlayerGameCommand(position:position, player: player, gameboard: gameboard, gameboardView: gameboardView, markView: markView)
    Invoker.shared.addGameCommand(command)
}
