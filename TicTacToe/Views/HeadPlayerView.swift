//
//  HeadPlayerView.swift
//  TicTacToe
//
//  Created by Corentin Robert on 17/09/2024.
//

import SwiftUI

struct HeadPlayerView : View {
    
    @ObservedObject var player1: Player
    @ObservedObject var player2: Player
    var currentPlayer: Player
    
    var body: some View {
        HStack(alignment: .center){
            HStack{
                Image.init(systemName: player1.icon)
                    .resizable()
                    .foregroundColor(Color.purple)
                    .frame(width: 50, height: 50)
                VStack{
                    Text(player1.name)
                    Text("Score".localize()+" : \(player1.score)")
                }
            }
            .padding()
            .background(currentPlayer == player1 ? Color.gray.opacity(0.3): nil)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack{
                Image.init(systemName: player2.icon)
                    .resizable()
                    .foregroundColor(Color.green)
                    .frame(width: 50, height: 50)
                VStack{
                    Text(player2.name)
                    Text("Score".localize()+" : \(player2.score)")
                }
            }
            .padding()
            .background(currentPlayer == player2 ? Color.gray.opacity(0.2): nil)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    HeadPlayerView(
        player1: Player(name: "Player 1", score: 0, icon: "xmark", isFirstPlayer: true),
        player2: Player(name: "Player 2", score: 0, icon: "circle", isFirstPlayer: false),
        currentPlayer: Player(name: "Player 1", score: 1, icon: "xmark",isFirstPlayer: true))
}
