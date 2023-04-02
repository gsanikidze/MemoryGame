//
//  MemoryGameModel.swift
//  Memory Game
//
//  Created by Guram Sanikidze on 02.04.23.
//

import Foundation

struct MemoryGameModel <T> where T: Equatable {
    private(set) var cards: [Card] = []
    
    init(count: Int, createCard: (Int, Int) -> Card) {
        for i in 0..<count {
            cards.append(createCard(i, i*2))
            cards.append(createCard(i, i*2 + 1))
        }
        
        cards.shuffle()
    }
    
    var faceUpCards: [Card] {
        get {
            cards.filter { $0.isFacedUp }
        }
    }
    
    var matchedCards: [Card] {
        get {
            cards.filter { $0.matched }
        }
    }
    
    private mutating func toggleItem(_ card: Card) -> Void {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFacedUp.toggle()
        }
    }
    
    private mutating func markAsMatched(_ card: Card) -> Void {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].matched = true
        }
    }
    
    mutating func choose(_ card: Card) {
        if card.matched || matchedCards.count == cards.count {
            return
        }
        
        if faceUpCards.count == 2 && !card.isFacedUp {
            faceUpCards.forEach { item in
                toggleItem(item)
            }
        } else if faceUpCards.count == 1 && !card.isFacedUp {
            let firstCard = faceUpCards[0]
            
            if firstCard.content == card.content {
                markAsMatched(card)
                markAsMatched(firstCard)
            }
        }
        
        toggleItem(card)
    }
    
    mutating func restart() {
        for i in 0..<cards.count {
            cards[i].isFacedUp = false
            cards[i].matched = false
        }
        
        cards.shuffle()
    }
 
    struct Card: Identifiable {
        var id: Int
        var content: T
        var isFacedUp = false
        var matched = false
    }
}
