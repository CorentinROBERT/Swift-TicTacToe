//
//  GridGameView.swift
//  TicTacToe
//
//  Created by Corentin Robert on 17/09/2024.
//

import SwiftUI

struct GridGameView: View {
    @ObservedObject
    var controler : GameControler
    var showOverlay : Bool = true
    var body: some View {
        VStack{
            Grid(horizontalSpacing: 1, verticalSpacing: 1){
                GridRow{
                    ClickableCase(width: 100,overlay: controler.grid[0][0], onTap: {onGridTap(0,0)})
                    ClickableCase(width: 100,overlay: controler.grid[0][1], onTap: {onGridTap(0,1)})
                    ClickableCase(width: 100,overlay: controler.grid[0][2], onTap: {onGridTap(0,2)})
                }
                GridRow{
                    ClickableCase(width: 100,overlay: controler.grid[1][0], onTap: {onGridTap(1,0)})
                    ClickableCase(width: 100,overlay: controler.grid[1][1], onTap: {onGridTap(1,1)})
                    ClickableCase(width: 100,overlay: controler.grid[1][2], onTap: {onGridTap(1,2)})
                }
                GridRow{
                    ClickableCase(width: 100,overlay: controler.grid[2][0], onTap: {onGridTap(2,0)})
                    ClickableCase(width: 100,overlay: controler.grid[2][1], onTap: {onGridTap(2,1)})
                    ClickableCase(width: 100,overlay: controler.grid[2][2], onTap: {onGridTap(2,2)})
                }
            }
            .background(Color.gray)
            .border(Color.gray)
        }.background(.green)
    }
    
    func onGridTap(_ raw:Int, _ col:Int) {
        //print("\(controler.currentPlayer?.name ?? "") : raw \(raw) col \(col)")
        if(controler.grid[raw][col] == nil && controler.canPlay){
            controler.grid[raw][col] = controler.currentPlayer == controler.player1
            controler.swapPlayer()
        }
    }
}

#Preview {
    GridGameView(controler: GameControler())
}
