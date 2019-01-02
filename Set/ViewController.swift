//
//  ViewController.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet private var cards: [UIButton]!
  @IBAction func touchCard(_ sender: UIButton) {
    let touchedCardIndex = cards.index(of: sender)!
    game.addToSelection(newCardIndex: touchedCardIndex)
    if game.numberOfCardsSelected() == 3 {
      if game.doSelectedCardsMatch() {
        print("Works")
      }
      highlightSelectedCards()
    } else {
      highlightSelectedCards()
    }
  }
  
  @IBAction private func newGame() {
    game.cards.shuffle()
    setAttributesOfCards()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
  }
  
  private func highlightSelectedCards() {
    if game.deselectedCards.count > 0 { deselectCards() }
    for index in game.indicesOfSelectedCards {
      let card = cards[index]
      card.layer.borderWidth = 3.0
      card.layer.borderColor = UIColor.blue.cgColor
    }
  }
  
  private func deselectCards() {
    for index in game.deselectedCards {
      cards[index].layer.borderWidth = 0
    }
  }
  
  private func setAttributesOfCards() {
    for (index, card) in cards.enumerated() {
      if index == cards.count  { break }
      let shading = getSymbolShading(at: index)
      let attributes: [NSAttributedString.Key: Any] = [
        .strokeWidth: shading,
        .foregroundColor: (shading == -1 ? getSymbolColor(at: index).withAlphaComponent(0.3) : getSymbolColor(at: index))
      ]
      let attributedText = NSAttributedString(string: getSymbol(at: index), attributes: attributes)
      card.setAttributedTitle(attributedText, for: UIControl.State.normal)
    }
  }
  
  private func getSymbol(at index: Int) -> String {
    let pipsCount = game.cards[index].pips.rawValue
    let symbol = game.cards[index].symbol
    switch symbol {
    case .triangle: return String(repeating: "■", count: pipsCount)
    case .square: return String(repeating: "▲", count: pipsCount)
    case .circle: return String(repeating: "●", count: pipsCount)
    }
  }
  
  private func getSymbolColor(at index: Int) -> UIColor {
    let symbolColor = game.cards[index].color
    switch symbolColor {
    case .red: return UIColor.red
    case .green: return UIColor.green
    case .purple: return UIColor.purple
    }
  }
  
  private func getSymbolShading(at index: Int) -> Double {
    let shading = game.cards[index].shading
    switch shading {
    case .solid: return 0
    case .striped: return -1
    case .open: return 5
    }
  }
  
  private var game = Set()
}

extension Int {
  var arc4random: Int {
    if self > 0 {
      return Int(arc4random_uniform(UInt32(self)))
    } else if self < 0 {
      return -Int(arc4random_uniform(UInt32(abs(self))))
    } else {
      return 0
    }
  }
}
