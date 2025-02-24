//
//  Transfer.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/24/25.
//

import Foundation

extension Model6502 {
    mutating func tax() {
        registers.x = registers.a
    }
    
    mutating func tay() {
        registers.y = registers.a
    }
    
    mutating func txa() {
        registers.a = registers.x
    }
    
    mutating func tya() {
        registers.a = registers.y
    }
}
