//
//  Player.swift
//  TicTacToe
//
//  Created by Corentin Robert on 17/09/2024.
//

import Foundation
import SwiftUI

class Player:ObservableObject,Equatable, Codable{
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.isFirstPlayer == rhs.isFirstPlayer
    }
    
    // Implémentation de l'encodage
        enum CodingKeys: String, CodingKey {
            case name
            case score
            case icon
            case isFirstPlayer
        }
    
    
    @Published var name: String
    @Published var score: Int
    @Published var icon: String
    @Published var isFirstPlayer: Bool
    
    init(name: String, score: Int, icon: String, isFirstPlayer: Bool) {
        self.name = name
        self.score = score
        self.icon = icon
        self.isFirstPlayer = isFirstPlayer
    }
    
    func resetScore(){
        self.score = 0
    }
    
    // Initialisation à partir du décodeur
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        score = try container.decode(Int.self, forKey: .score)
        icon = try container.decode(String.self, forKey: .icon)
        isFirstPlayer = try container.decode(Bool.self, forKey: .isFirstPlayer)
    }
    
    // Encodage vers un encodeur
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(name, forKey: .name)
           try container.encode(score, forKey: .score)
           try container.encode(icon, forKey: .icon)
           try container.encode(isFirstPlayer, forKey: .isFirstPlayer)
       }
}
