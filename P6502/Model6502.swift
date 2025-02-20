//
//  Model6502.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Foundation

enum RegisterAddressMode {
    case zeroPage
    case zeroPageX
    case zeroPageY
    case absolute
    case absoluteX
    case absoluteY
    case indexedIndirect
    case indirectIndexed
}

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
    
    func address(mode: RegisterAddressMode, base: UInt16) -> Int {
        switch mode {
        case .zeroPage:
            return Int(base)
        case .zeroPageX:
            return Int(UInt8(truncatingIfNeeded: Int(base) + Int(_x)))
        case .zeroPageY:
            return Int(UInt8(truncatingIfNeeded: Int(base) + Int(_y)))
        case .absolute:
            return Int(base)
        case .absoluteX:
            return Int(UInt16(truncatingIfNeeded: Int(base) + Int(_x)))
        case .absoluteY:
            return Int(UInt16(truncatingIfNeeded: Int(base) + Int(_y)))
        case .indexedIndirect:
            let mem1 = Int(UInt8(truncatingIfNeeded: Int(base) + Int(_x)))
            let addrH = memory[Int(UInt8(truncatingIfNeeded: mem1 + 1))]
            return Int(memory[Int(mem1)]) | (Int(addrH) << 8)
        case .indirectIndexed:
            return Int(memory[Int(base)]) | (Int(memory[Int(base) + 1]) << 8) + Int(_y)
        }
    }
    
    mutating func adc(add: UInt8) {
        var done = false
        var res = 0
        if d {
            let rng = 0...9
            let a1 = Int(a & 0x0f),
                a10 = Int(a & 0xf0) >> 4,
                ad1 = Int(add & 0x0f),
                ad10 = Int(add & 0xf0) >> 4
            if rng.contains(a1) && rng.contains(a10)
                && rng.contains(ad1) && rng.contains(ad10) {
                res = a1 + ad1 + 10 * (a10 + ad10) + (c ? 1 : 0)
                c = res > 99
                res %= 100
                res = ((res / 10) << 4) | (res % 10)
                done = true
            }
        }
        if !done {
            res = Int(a) + Int(add) + (c ? 1 : 0)
            c = res > 0xff
        }
        o = (Int(a) ^ res) & (Int(add) ^ res) & 0x80 > 0
        a = UInt8(truncatingIfNeeded: res)
    }
    
    mutating func sbc(sub: UInt8) {
        var done = false
        var res = 0
        if d {
            let rng = 0...9
            let a1 = Int(a & 0x0f),
                a10 = Int(a & 0xf0) >> 4,
                ad1 = Int(sub & 0x0f),
                ad10 = Int(sub & 0xf0) >> 4
            if rng.contains(a1) && rng.contains(a10)
                && rng.contains(ad1) && rng.contains(ad10) {
                res = a1 - ad1 + 10 * (a10 - ad10) - (c ? 0 : 1)
                c = res > 0
                if !c {
                    res += 100
                }
                res = ((res / 10) << 4) | (res % 10)
                done = true
            }
        }
        if !done {
            res = Int(a) + (Int(~sub)) + (c ? 1 : 0)
            c = Int(a) >= Int(sub)
        }
        o = (Int(a) ^ res) & (Int(~sub) ^ res) & 0x80 > 0
        a = UInt8(truncatingIfNeeded: res)
    }
}
