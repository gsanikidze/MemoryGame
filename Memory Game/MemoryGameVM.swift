//
//  MemoryGameVM.swift
//  Memory Game
//
//  Created by Guram Sanikidze on 02.04.23.
//

import SwiftUI

let fakeData = [
    "🚓", "🛒", "🛻", "🚌", "💺", "🚃", "🗃️"
]

class MemoryGameVM: ObservableObject {
    @Published private var model: MemoryGameModel<String>
    
    init() {
        model = MemoryGameModel<String>(count: 7) { i, id in
            MemoryGameModel.Card(
                id: id,
                content: fakeData[i]
            )
        }
    }
    
    var cards: [MemoryGameModel<String>.Card] {
        model.cards
    }
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}
