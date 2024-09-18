//
//  ClickableCase.swift
//  TicTacToe
//
//  Created by Corentin Robert on 17/09/2024.
//

import SwiftUI

struct ClickableCase: View {
    var width:Double
    var overlay : Bool? = nil
    var onTap: (() -> Void)?
    var body: some View {
        Rectangle()
            .fill(Color.white) // Taille du rectangle
            .frame(width:width, height:width)
            .onTapGesture {
                if(onTap != nil)
                {
                    onTap!()
                }
            }
            .overlay(
                overlay != nil ? ( overlay! ? 
                   Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(.purple)
                    .frame(width: width/2, height:width/2)
                :
                Image(systemName: "circle")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: width/2, height:width/2)
                )
                : nil
               
            )
    }
}

#Preview {
    ClickableCase(width:100)
}
