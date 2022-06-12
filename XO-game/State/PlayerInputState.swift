//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Никита Мошенцев on 31.05.2022.
//

import Foundation

public class PlayerInputState: GameState {
    //MARK: - Public properties
    public private(set) var isCompleted = false
    public let player: Player
    
    //MARK: - Private properties
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    private var refeere: Referee
    
    //MARK: - Init
    init(player: Player, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.refeere = Referee(gameboard: gameboard)
    }
    
    //MARK: - Public methods
    public func begin() {
        switch self.player {
        case .first:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = false
            self.gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .computer:
            self.gameViewController?.firstPlayerTurnLabel.isHidden = true
            self.gameViewController?.secondPlayerTurnLabel.text = "Computer"
            self.gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        self.gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        guard let gameboardView = gameboardView, let gameboard = gameboard, gameboardView.canPlaceMarkView(at: position)
            else { return }
        let markView: MarkView
        if Game.shared.gameSelection != .fiveSteps {
        switch self.player {
        case .first:
            markView = XView()
        case .second:
            markView = OView()
        case .computer:
            markView = OView()
            }
            self.gameboardView?.placeMarkView(markView, at: position)
            self.gameboard?.setPlayer(self.player, at: position)
            self.isCompleted = true
            
        } else {
            guard let gameViewController = gameViewController else { return }
            switch self.player {
            case .first:
                markView = XView()
                    PlaceMarkCommand(position: position, player: player, gameboard: gameboard, gameboardView: gameboardView, markView: markView)
                if Invoker.shared.commands.count == 5 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        gameboardView.clear()
                        gameboard.clear()
                    })
                    self.gameboard?.setPlayer(self.player, at: position)
                    self.isCompleted = true
                }
            case .second:
                markView = OView()
                PlaceMarkCommand(position: position, player: player, gameboard: gameboard, gameboardView: gameboardView, markView: markView)
                if Invoker.shared.commands.count == 10 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        gameboard.clear()
                        gameboardView.clear()
                        self.gameViewController?.secondPlayerTurnLabel.isHidden = true
                        self.gameViewController?.winnerLabel.text = "Game is on..."
                        self.gameViewController?.winnerLabel.isHidden = false
                        self.isCompleted = true
                        Invoker.shared.executeCommandsIfNeeded()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            gameViewController.checkWinner()
                            }
                        }
                    }
            case .computer:
                break
            }
        }
    }
}


