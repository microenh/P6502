//
//  Model6502.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Foundation

struct Model6502 {
    var memory = Array(repeating: UInt8(0x00), count: 0x10000)
    var pc = UInt16(0)
    var sp = UInt8(0)
    private var _a = UInt8(0)
    private var _x = UInt8(0)
    private var _y = UInt8(0)
    
    // flags
    var n = false  // bit 7
    var o = false  // bit 6
    // bit 5 not used (always 1)
    var b = false  // bit 4
    var d = false  // bit 3
    var i = false  // bit 2
    var z = false  // bit 1
    var c = false  // bit 0
    
    struct Registers {
        let pc: UInt16
        let sp: UInt8
        let a: UInt8
        let x: UInt8
        let y: UInt8
        let n: Bool
        let o: Bool
        let b: Bool
        let d: Bool
        let i: Bool
        let z: Bool
        let c: Bool
    }
    
    var registers: Registers {
        get { Registers(pc: pc, sp: sp, a: _a, x: _x, y: _y,
            n: n, o: o, b: b, d: d, i: i, z: z, c: c)
        }
    }
    
    
    static func zeroNegativeFlags(value: UInt8) -> (zero: Bool, negative: Bool) {
        (zero: value == 0x00, negative: value >= 0x80)
    }
    
    static func twosComplement(value: UInt8) -> Int8 {
        value <= 0x80 ? Int8(truncatingIfNeeded: value) :
        -Int8(truncatingIfNeeded: (~value + 1))
    }
    
    var a: UInt8 {
        get {_a}
        set {
            _a = newValue
            (z, n) = Model6502.zeroNegativeFlags(value: newValue)
        }
    }
    
    var x: UInt8 {
        get {_x}
        set {
            _x = newValue
            (z, n) = Model6502.zeroNegativeFlags(value: newValue)
        }
    }
    
    var y: UInt8 {
        get {_y}
        set {
            _y = newValue
            (z, n) = Model6502.zeroNegativeFlags(value: newValue)
        }
    }
    
    
}
