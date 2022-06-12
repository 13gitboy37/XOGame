//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    
    var next: Player {
        if Game.shared.gameSelection == .player {
        switch self {
        case .first: return .second
        case .second: return .first
        default: return .first
        }
    } else if Game.shared.gameSelection == .computer {
                switch self {
                case .first: return .computer
                case .computer: return .first
                default: return .first
                }
    } else {
        switch self {
        case .first: return .second
        case .second: return .first
        default: return .first
            }
        }
    }
}
