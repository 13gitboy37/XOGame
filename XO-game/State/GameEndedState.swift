//
//  GameEndedState.swift
//  XO-game
//
//  Created by Никита Мошенцев on 31.05.2022.
//

import Foundation

public class GameEndedState: GameState {
    //MARK: - Public properties
    public let isCompleted = false
    public let winner: Player?
    //MARK: - Private properties
    private(set) weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    //MARK: - Public methods
    public func begin() {
        self.gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
        } else {
            self.gameViewController?.winnerLabel.text = "No winner"
        }
        self.gameViewController?.firstPlayerTurnLabel.isHidden = true
        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    //MARK: - Private methods
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        case .computer:
            return "Computer"
        }
    }
}
