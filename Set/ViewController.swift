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
        setAttributesOfCardButtons()
        cardsRemaining.text = "Number of Cards Remaining: \(cardsRemainingCount())"
        game.score += 3
        score.text = "Score: \(game.score)"
      } else {
          game.deselectedCards = game.indicesOfSelectedCards
          deselectCards()
          game.indicesOfSelectedCards.removeAll()
          game.score -= 5
          score.text = "Score: \(game.score)"
      }
      highlightSelectedCards()
    } else {
      highlightSelectedCards()
    }
  }
  
  @IBOutlet weak var score: UILabel!
  @IBOutlet weak var cardsRemaining: UILabel!
  
  @IBAction func dealThreeMoreCards(_ sender: UIButton) {
    if game.numberOfVisibleCards >= 23 {
      sender.isEnabled = false
      return
    } else if let indexOfHiddenButton = cardButtons.firstIndex(where: { $0.isHidden == true && $0.isEnabled == true}) {
      for cardButton in cardButtons[indexOfHiddenButton...indexOfHiddenButton + 2] {
        cardButton.isHidden = false
      }
      game.numberOfVisibleCards += 3
    }
  }
  
  @IBAction private func newGame() {
    game = Set()
    setAttributesOfCardButtons()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
  }
  
  private var game = Set()
  
  private func cardsRemainingCount() -> Int {
    return game.cards.count > 24 ? game.cards.count : cardButtons.filter { $0.isHidden == false }.count
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
      if game.cards.count <= 24 {
        cardButtons[index].isHidden = true
        cardButtons[index].isEnabled = false
      } else {
        cardButtons[index].layer.borderWidth = 0
      }
    }
    game.deselectedCards.removeAll()
  }
  
  private func setAttributesOfCardButtons() {
    let deckSize = game.cards.count
    for (index, cardButton) in cardButtons.enumerated() {
      if index >= deckSize {
        deselectCards()
      } else if let card = game.cards[index] {
        let attributedText = createAttributedString(card: card)
        cardButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
        cardButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        if index > game.numberOfVisibleCards {
          cardButton.isHidden = true
        }
      }
    }
  }
  
  private func createAttributedString(card: Card) -> NSAttributedString {
    let shading = getSymbolShading(of: card)
    let attributes: [NSAttributedString.Key: Any] = [
      .strokeWidth: shading,
      .foregroundColor: (shading == -1 ? getSymbolColor(of: card).withAlphaComponent(0.3) : getSymbolColor(of: card))
    ]
    return NSAttributedString(string: getSymbol(of: card), attributes: attributes)
  }
  
  private func getSymbol(of card: Card) -> String {
    switch card.symbol {
    case .triangle: return String(repeating: "▲", count: card.pips.rawValue)
    case .square: return String(repeating: "■", count: card.pips.rawValue)
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
}
