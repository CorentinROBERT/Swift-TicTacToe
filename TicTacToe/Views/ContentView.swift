//
//  ContentView.swift
//  TicTacToe
//
//  Created by Corentin Robert on 16/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    var controler : GameControler = GameControler()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing:0){
                    Text("app_title".localize()).frame(alignment: .leading)
                    //Head with player name
                    HeadPlayerView(player1: controler.player1, player2: controler.player2, currentPlayer: controler.currentPlayer ?? controler.player1).padding()
                    //Grid Game
                    GridGameView(controler: controler)
                    
                    //Buttons new game / reset history
                    VStack{
                        //Player Turn
                        Text(controler.state == .game ? (controler.currentPlayer == controler.player1 ? "\(controler.player1.name) : \("your_turn".localize())" : "\(controler.player2.name) : \("your_turn".localize())") :
                                controler.state == .win ? "\(controler.currentPlayer!.name) \("win".localize())" : "equality".localize())
                        Button(action: {
                            controler.newGame()
                        }, label: {
                            Text("new_game".localize()).foregroundStyle(Color.white)
                        }).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)).background(Color.blue).clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                        Button(action: {
                            controler.resetHistory()
                            //print("Reset History \nplayer1 \(controler.player1.score) \nplayer2 \(controler.player2.score)")
                        }, label: {
                            Text("reset_history".localize()).foregroundStyle(Color.white)
                        }).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)).background(Color.red).clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }.padding()
                    
                }.padding()
            }
        }.onAppear {
            controler.loadGameState()
        }
    }
}

#Preview {
    ContentView(controler:GameControler())
}
