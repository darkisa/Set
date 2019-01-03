//
//  ViewController.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet private var cardButtons: [UIButton]!
  @IBAction func touchCard(_ sender: UIButton) {
    let touchedCardIndex = cardButtons.index(of: sender)!
    game.addToSelection(newCardIndex: touchedCardIndex)
    if game.numberOfCardsSelected() == 3 {
      if game.doSelectedCardsMatch() {
        game.assignNewCards()
        setAttributesOfCardButtons(range: 0..<game.visibleCards)
      }
      highlightSelectedCards()
    } else {
      highlightSelectedCards()
    }
  }
  
  @IBAction func dealThreeMoreCards(_ sender: UIButton) {
    if game.visibleCards == 23 {
      return
    } else {
      game.visibleCards += 3
      setAttributesOfCardButtons(range: 0..<game.visibleCards)
    }
  }
  
  @IBAction private func newGame() {
    game = Set()
    game.cards.shuffle()
    setAttributesOfCardButtons(range: 0..<game.visibleCards)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
  }
  
  private func highlightSelectedCards() {
    if game.deselectedCards.count > 0 { deselectCards() }
    for index in game.indicesOfSelectedCards {
      let cardButton = cardButtons[index]
      cardButton.layer.borderWidth = 3.0
      cardButton.layer.borderColor = UIColor.blue.cgColor
    }
  }
  
  private func deselectCards() {
    for index in game.deselectedCards {
      cardButtons[index].layer.borderWidth = 0
    }
  }
  
  private func setAttributesOfCardButtons(range: Range<Int>) {
    for cardButton in cardButtons[range] {
      if let card = game.cards.popLast() {
        let shading = getSymbolShading(of: card)
        let attributes: [NSAttributedString.Key: Any] = [
          .strokeWidth: shading,
          .foregroundColor: (shading == -1 ? getSymbolColor(of: card).withAlphaComponent(0.3) : getSymbolColor(of: card))
        ]
        let attributedText = NSAttributedString(string: getSymbol(of: card), attributes: attributes)
        cardButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        cardButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
      }
    }
  }
  
  private func getSymbol(of card: Card) -> String {
    switch card.symbol {
    case .triangle: return String(repeating: "■", count: card.pips.rawValue)
    case .square: return String(repeating: "▲", count: card.pips.rawValue)
    case .circle: return String(repeating: "●", count: card.pips.rawValue)
    }
  }
  
  private func getSymbolColor(of card: Card) -> UIColor {
    switch card.color {
    case .red: return UIColor.red
    case .green: return UIColor.green
    case .purple: return UIColor.purple
    }
  }
  
  private func getSymbolShading(of card: Card) -> Double {
    switch card.shading {
    case .solid: return 0
    case .striped: return -1
    case .open: return 5
    }
  }
  
  private var game = Set()
}
