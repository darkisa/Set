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
    sender.layer.borderWidth = 3.0
    sender.layer.borderColor = UIColor.blue.cgColor
  }
  
  @IBAction private func newGame() {
    for (index, card) in cards.enumerated() {
      if index == 13 { break }
      let attributes: [NSAttributedString.Key: Any] = [
        .strokeColor: getSymbolColor(at: index),
        .strokeWidth: getSymbolShading(at: index)
      ]
      let attributedText = NSAttributedString(string: getSymbol(at: index), attributes: attributes)
      card.setAttributedTitle(attributedText, for: UIControl.State.normal)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newGame()
  }
  
  private func getSymbol(at index: Int) -> String {
      return game.cards[index].symbol.getSymbol()
    }
  
  func getSymbolColor(at index: Int) -> UIColor {
    let symbolColor = game.cards[index].color
    switch symbolColor {
    case .red: return UIColor.red
    case .green: return UIColor.green
    case .purple: return UIColor.purple
    }
  }
  
  func getSymbolShading(at index: Int) -> Double {
    return game.cards[index].shading.getShading()
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
