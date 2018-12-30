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
            cards.append(Card(symbol: symbol, color: color, shading: shade, pips: pipCount, selected: false))
          }
        }
      }
    }
    cards.shuffle()
  }

  var cards = [Card]()
  
}
