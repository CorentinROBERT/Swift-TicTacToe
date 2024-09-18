//
//  GameControler.swift
//  TicTacToe
//
//  Created by Corentin Robert on 17/09/2024.
//

import Foundation
import SwiftUI


class GameControler : ObservableObject,Codable{
        @Published var player1: Player
        @Published var player2: Player
        @Published var currentPlayer: Player?
        @Published var canPlay: Bool
        @Published var state: StateGameEnum
        @Published var grid: [[Bool?]]
        @Published var nbGameTurn: Int
        
        enum CodingKeys: String, CodingKey, Codable {
            case player1, player2, currentPlayer, canPlay, state, grid, nbGameTurn
        }
        
        init() {
            self.player1 = Player(name: "\("player".localize()) 1", score: 0, icon: "xmark", isFirstPlayer: true)
            self.player2 = Player(name: "\("player".localize()) 2", score: 0, icon: "circle", isFirstPlayer: false)
            self.canPlay = true
            self.state = .game
            self.grid = [
                [nil, nil, nil],
                [nil, nil, nil],
                [nil, nil, nil]
            ]
            self.nbGameTurn = 0
            self.currentPlayer = self.player1
        }
        
        // Méthodes pour l'encodage
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(player1, forKey: .player1)
            try container.encode(player2, forKey: .player2)
            try container.encode(currentPlayer, forKey: .currentPlayer)
            try container.encode(canPlay, forKey: .canPlay)
            try container.encode(state, forKey: .state)
            try container.encode(grid, forKey: .grid)
            try container.encode(nbGameTurn, forKey: .nbGameTurn)
        }
        
        // Méthodes pour le décodage
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.player1 = try container.decode(Player.self, forKey: .player1)
            self.player2 = try container.decode(Player.self, forKey: .player2)
            self.currentPlayer = try container.decode(Player?.self, forKey: .currentPlayer)
            self.canPlay = try container.decode(Bool.self, forKey: .canPlay)
            self.state = try container.decode(StateGameEnum.self, forKey: .state)
            self.grid = try container.decode([[Bool?]].self, forKey: .grid)
            self.nbGameTurn = try container.decode(Int.self, forKey: .nbGameTurn)
        }
    
    func saveGameState() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = documentDirectory?.appendingPathComponent("gameData.json")

            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self)
                try data.write(to: fileURL!)
                print("Game saved to file")
            } catch {
                print("Failed to save game: \(error)")
            }
    }
    
    func loadGameState() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
          let fileURL = documentDirectory?.appendingPathComponent("gameData.json")

          let decoder = JSONDecoder()
          do {
              let data = try Data(contentsOf: fileURL!)
              let loadedGame = try decoder.decode(GameControler.self, from: data)
              
              self.player1 = loadedGame.player1
              self.player2 = loadedGame.player2
              self.currentPlayer = loadedGame.currentPlayer
              self.grid = loadedGame.grid
              self.nbGameTurn = loadedGame.nbGameTurn
              self.state = loadedGame.state
              self.canPlay = loadedGame.canPlay
              
              print("Game loaded from file")
          } catch {
              print("Failed to load game: \(error)")
          }
    }

    func newGame(){
        self.grid = [
            [nil, nil, nil],
            [nil, nil, nil],
            [nil, nil, nil]
        ]
        currentPlayer = player1
        nbGameTurn = 0
        canPlay = true
        state = .game
    }
    
    func resetHistory(){
        self.player1.resetScore()
        self.player2.resetScore()
    }
    
    func swapPlayer(){
        //print(nbGameTurn)
        if(isWin()){
            currentPlayer?.score += 1
            canPlay = false
        }
        else if(nbGameTurn == 8){
            canPlay = false
            state = .equality
        }
        else{
            self.currentPlayer = self.currentPlayer == self.player1 ? self.player2 : self.player1
            self.nbGameTurn += 1
        }
        saveGameState()
    }
    
    func isWin() -> Bool {
        //vertical
        if( (grid[0][0] != nil && grid[1][0] != nil && grid[2][0] != nil) && (self.grid[0][0] == self.grid[1][0] && self.grid[1][0] == grid[2][0])
            || (grid[0][1] != nil && grid[1][1] != nil && grid[2][1] != nil) && (grid[0][1] == grid[1][1] && grid[1][1] == grid[2][1])
            || (grid[0][2] != nil && grid[1][2] != nil && grid[2][2] != nil) && (grid[0][2] == grid[1][2] && grid[1][2] == grid[2][2]) )
        {
            print("win Vertical")
            state = .win
            return true
        }
        
        //horizontal
        if( (grid[0][0] != nil && grid[0][1] != nil && grid[0][2] != nil) && (grid[0][0]! == grid[0][1]! && grid[0][1]! == grid[0][2]!)
            || (grid[1][0] != nil && grid[1][1] != nil && grid[1][2] != nil) && (grid[1][0]! == grid[1][1]! && grid[1][1]! == grid[1][2]!)
            || (grid[2][0] != nil && grid[2][1] != nil && grid[2][2] != nil) && (grid[2][0]! == grid[2][1]! && grid[2][1]! == grid[2][2]!))
        {
            print("win Horizontal")
            state = .win
            return true
        }
        
        //diag1
        if(grid[0][0] != nil && grid[1][1] != nil && grid[2][2] != nil) && (grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2])
        {
            print("win diag1")
            state = .win
            return true
        }
        //diag2
        if(grid[0][2] != nil && grid[1][1] != nil && grid[2][0] != nil) && (grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0])
        {
            print("win diag2")
            state = .win
            return true
        }
        
        return false
    }
    
}
