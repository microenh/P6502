//
//  Model6502.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Foundation

struct Model6502 {
    var memory = Array(repeating: UInt8(0x00), count: 0x10000)
    
    struct Registers {
        var pc = UInt16(0)
        var sp = UInt8(0)
        private var _a = UInt8(0)
        private var _x = UInt8(0)
        private var _y = UInt8(0)
        var n = false   // bit 7
        var o = false   // bit 6
        // bit 5 not used (always 1)
        var b = false   // bit 4
        var d = false   // bit 3
        var i = false   // bit 2
        var z = true    // bit 1
        var c = false   // bit 0
        
        var a: UInt8 {
            get {_a}
            set {
                _a = newValue
                (z, n) = zeroNegativeFlags(value: newValue)
            }
        }
        
        var x: UInt8 {
            get {_x}
            set {
                _x = newValue
                (z, n) = zeroNegativeFlags(value: newValue)
            }
        }
        
        var y: UInt8 {
            get {_y}
            set {
                _y = newValue
                (z, n) = zeroNegativeFlags(value: newValue)
            }
        }
    }
    
    var registers = Registers()
}
