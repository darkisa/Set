//
//  Card.swift
//  Set
//
//  Created by Darko Mijatovic on 12/26/18.
//  Copyright © 2018 Darko Mijatovic. All rights reserved.
//

import Foundation

struct Card {
  
  enum Symbol: Int {
    case triangle, square, circle
    
    static let all = [Symbol.triangle, .square, .circle]
    
    func getSymbol() -> String {
      switch self {
      case .triangle: return "\u{25B2}"
      case .square: return "\u{25FC}"
      case .circle: return "\u{25CF}"
      }
    }
  }
  
  enum PipCount {
    case one, two, three
    
    static let all = [PipCount.one, .two, .three]
    
    func getPipCount() -> Int {
      switch self {
      case .one: return 1
      case .two: return 2
      case .three: return 3
      }
    }
  }
  
  enum Color: Int {
    case red, green, purple
    
    static let all = [Color.red, .green, .purple]
  }
  
  enum Shading: Int {
    case solid, striped, open
    
    static let all = [Shading.solid, .striped, .open]
    
    func getShading() -> Double {
      switch self {
      case .solid: return 0.0
      case .striped: return 0.5
      case .open: return -0.5
      }
    }
  }
  
  let symbol: Symbol, color: Color, shading: Shading, pips: PipCount
  var selected = false
}
