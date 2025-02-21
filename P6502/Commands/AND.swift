//
//  AND.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/21/25.
//

import Foundation

extension Model6502 {
    mutating func and(value: UInt8) {
        a &= value
    }
}
