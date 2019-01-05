//
//  Set.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Set {
  
  init(){
    for symbol in Card.Symbol.all {
      for color in Card.Color.all {
        for shade in Card.Shading.all {
          for pipCount in Card.PipCount.all {
            cards.append(Card(symbol: symbol, color: color, shading: shade, pips: pipCount))
          }
        }
      }
    }
    cards.shuffle()
  }

  private(set) var cards = [Card?]()
  private(set) var indicesOfSelectedCards = [Int]()
  var indicesOfDeselectedCards = [Int]()
  var numberOfCardsDealt = 12 {
    didSet(newTotal) {
      if newTotal > 81 {
        numberOfCardsDealt = 81
      }
    }
  }
  var score = 0
  
  mutating func assignNewCards() {
    if cards.count > 24 {
      for index in indicesOfSelectedCards {
        cards[index] = cards.popLast()!
      }
    } else {
      for index in indicesOfSelectedCards {
        cards[index] = nil
      }
    }
    numberOfCardsDealt += 3
  }
  
  mutating func clearSelectedCards() {
    indicesOfDeselectedCards = indicesOfSelectedCards
    indicesOfSelectedCards.removeAll()
  }
  
  mutating func addToSelection(newCardIndex: Int) {
    if !indicesOfSelectedCards.contains(newCardIndex) {
      indicesOfSelectedCards.append(newCardIndex)
    } else {
      let deselectIndex = indicesOfSelectedCards.index(of: newCardIndex)!
      indicesOfDeselectedCards.append(indicesOfSelectedCards.remove(at: deselectIndex))
    }
  }
  
  func numberOfCardsSelected() -> Int {
    return indicesOfSelectedCards.count
  }
  
  func doSelectedCardsMatch() -> Bool {
    let cardOne = cards[indicesOfSelectedCards[0]]!
    let cardTwo = cards[indicesOfSelectedCards[1]]!
    let cardThree = cards[indicesOfSelectedCards[2]]!
    return cardMatch(firstCard: cardOne.symbol, secondCard: cardTwo.symbol, thirdCard: cardThree.symbol) &&
            cardMatch(firstCard: cardOne.pips, secondCard: cardTwo.pips, thirdCard: cardThree.pips) &&
            cardMatch(firstCard: cardOne.color, secondCard: cardTwo.color, thirdCard: cardThree.color) &&
            cardMatch(firstCard: cardOne.shading, secondCard: cardTwo.shading, thirdCard: cardThree.shading)
  }
  
  func cardMatch<T: Equatable>(firstCard: T, secondCard: T, thirdCard: T) -> Bool {
    return (firstCard == secondCard && firstCard == thirdCard) ||
            (firstCard != secondCard && firstCard != thirdCard && secondCard != thirdCard)
  }
}
