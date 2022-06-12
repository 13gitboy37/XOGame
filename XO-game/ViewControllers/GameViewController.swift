//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//

import UIKit

class GameViewController: UIViewController {
    //MARK: - IBOutlet`s
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    //MARK: - Private properties
    private let gameboard = Gameboard()
    lazy var referee = Referee(gameboard: self.gameboard)
    
    //MARK: - Properties
    var vsGame: GameSelection = .player
    var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToFirstState()
        self.vsGame = Game.shared.gameSelection
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted {
                self.goToNextState()
            }
        }
    }
    //MARK: - IBAction`s
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        gameboardView.clear()
        gameboard.clear()
        goToFirstState()
    }
    //MARK: - Private methods
    private func goToFirstState() {
        self.currentState = PlayerInputState(player: .first,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        if Game.shared.gameSelection != .fiveSteps {
            
        if checkNoMovies() {
            self.currentState = GameEndedState(winner: nil, gameViewController: self)
        }
            
        if let winner = self.referee.determineWinner() {
            self.currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                 gameViewController: self,
                                                 gameboard: gameboard,
                                                 gameboardView: gameboardView)
            }
        
        if let playerInputState = currentState as? PlayerInputState {
            if playerInputState.player == .computer {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                var compPosition = self.computerPosition()
                while !self.gameboardView.canPlaceMarkView(at: compPosition) {
                    compPosition = self.computerPosition()
                }
                currentState.addMark(at: compPosition)
                if self.currentState.isCompleted {
                    goToNextState()
                        }
                    }
                }
            }
    } else {        
        if let playerInputState = currentState as? PlayerInputState {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [self] in
                self.currentState = PlayerInputState(player: playerInputState.player.next,
                                                     gameViewController: self,
                                                     gameboard: gameboard,
                                                     gameboardView: gameboardView)
                })
            }
        if Invoker.shared.commands.count == 10 {
            if let winner = self.referee.determineWinner() {
                self.currentState = GameEndedState(winner: winner, gameViewController: self)
                return
            }
            }
        }
    }
    
    private func computerPosition() -> GameboardPosition {
        let column = Int.random(in: 0...GameboardSize.columns - 1)
        let row = Int.random(in: 0...GameboardSize.rows - 1)
        return GameboardPosition(column: column, row: row)
    }
    
    private func checkNoMovies() -> Bool {
        for column in 0..<GameboardSize.columns {
            for row in 0..<GameboardSize.rows {
                if gameboardView.canPlaceMarkView(at: GameboardPosition(column: column, row: row)) {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    //MARK: - Methods
    func checkWinner() {
            if let winner = self.referee.determineWinner() {
                self.currentState = GameEndedState(winner: winner, gameViewController: self)
                return
            } else {
                self.currentState = GameEndedState(winner: nil, gameViewController: self)
            }
    }
}

