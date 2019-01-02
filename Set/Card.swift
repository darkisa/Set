//
//  Card.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Card {
  
  let symbol: Symbol, color: Color, shading: Shading, pips: PipCount
  
  enum Symbol {
    case triangle, square, circle
    
    static let all = [Symbol.triangle, .square, .circle]
  }
  
  enum PipCount: Int {
    case one = 1, two, three
    
    static let all = [PipCount.one, .two, .three]
  }
  
  enum Color {
    case red, green, purple
    
    static let all = [Color.red, .green, .purple]
  }
  
  enum Shading {
    case solid, striped, open
    
    static let all = [Shading.solid, .striped, .open]
  }
}

//extension Card: Equatable {
//  static func == (lhs: Card, rhs: Card) -> Bool {
//  return
//      lhs.symbol == rhs.symbol &&
//      lhs.street == rhs.street &&
//      lhs.unit == rhs.unit
//  }
//}
