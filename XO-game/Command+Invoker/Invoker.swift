//
//  Invoker.swift
//  XO-game
//
//  Created by Никита Мошенцев on 06.06.2022.
//

import Foundation

final class Invoker {
    static let shared = Invoker()
    
    private(set) var commands: [PlayerGameCommand] = []
    private var timeInterval = 0.5
    
    internal func addGameCommand(_ command: PlayerGameCommand) {
        command.execute(delay: 0)
        self.commands.append(command)
        }
    
     internal func executeCommandsIfNeeded() {
         for i in 0...4 {
             commands[i].execute(delay: Double(i) )
             commands[i + 5].execute(delay: Double(i) + timeInterval)
             }
         DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
             self.commands = []
         })
     }
    }
