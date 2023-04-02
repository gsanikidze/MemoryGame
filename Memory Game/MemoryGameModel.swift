//
//  MemoryGameModel.swift
//  Memory Game
//
//  Created by Guram Sanikidze on 02.04.23.
//

import Foundation

struct MemoryGameModel <T> {
    private(set) var cards: [Card] = []
    
    init(count: Int, createCard: (Int, Int) -> Card) {
        for i in 0..<count {
            cards.append(createCard(i, i*2))
            cards.append(createCard(i, i*2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFacedUp.toggle()
        }
    }
 
    struct Card: Identifiable {
        var id: Int
        var content: T
        var isFacedUp = true
    }
}
