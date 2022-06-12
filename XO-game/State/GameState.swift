//
//  GameState.swift
//  XO-game
//
//  Created by Никита Мошенцев on 31.05.2022.
//

import Foundation

public protocol GameState {
    
    var isCompleted: Bool { get }
    
    func begin()
    
    func addMark(at position: GameboardPosition)
}
