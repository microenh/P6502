//
//  Addressing.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/18/25.
//

import Testing
@testable import P6502

struct Addressing {
    var p = Model6502()

    @Test("AddressZeroPage", arguments: [UInt16(0), 1, 0x7f, 0x80, 0xff])
    func addressZeroPage2(base: UInt16) {
        let addr = p.address(mode: .zeroPage, base: base)
        #expect(addr == base)
    }
    
    @Test(arguments: zip([UInt16(0), 1, 0x7f, 0x80, 0xff],
                         [UInt16(0x10), 0x11, 0x8f, 0x90, 0x0f]))
    mutating func addressZeroPageX2(base: UInt16, result: UInt16) {
        p.x = 0x10
        let addr = p.address(mode: .zeroPageX, base: base)
        #expect(addr == result)
    }
    
    @Test()
    func addressZeroPage() {
        let arguments = [UInt16(0), 1, 0x7f, 0x80, 0xff]
        for base in arguments {
            let addr = p.address(mode: .zeroPage, base: base)
            #expect(addr == base)
        }
    }

    @Test
    mutating func addressZeroPageX() {
        p.x = 0x10
        let arguments = zip([UInt16(0), 1, 0x7f, 0x80, 0xff],
                            [UInt16(0x10), 0x11, 0x8f, 0x90, 0x0f])
        for (base, result) in arguments {
            let addr = p.address(mode: .zeroPageX, base: base)
            #expect(addr == result)
        }
    }
    
    @Test
    mutating func addressZeroPageY() {
        p.y = 0x10
        let arguments = zip([UInt16(0), 1, 0x7f, 0x80, 0xff],
                            [UInt16(0x10), 0x11, 0x8f, 0x90, 0x0f])
        for (base, result) in arguments {
            let addr = p.address(mode: .zeroPageY, base: base)
            #expect(addr == result)
        }
    }
    
    @Test
    mutating func addressAbsoluteX() {
        p.x = 0x10
        let arguments = zip([UInt16(0x0000), 0x0001, 0x107f, 0x2080, 0x30ff],
                            [UInt16(0x0010), 0x0011, 0x108f, 0x2090, 0x310f])
        for (base, result) in arguments {
            let addr = p.address(mode: .absoluteX, base: base)
            #expect(addr == result)
        }
    }
    
    @Test
    mutating func addressAbsoluteY() {
        p.y = 0x10
        let arguments = zip([UInt16(0x0000), 0x0001, 0x107f, 0x2080, 0x30ff],
                            [UInt16(0x0010), 0x0011, 0x108f, 0x2090, 0x310f])
        for (base, result) in arguments {
            let addr = p.address(mode: .absoluteY, base: base)
            #expect(addr == result)
        }
    }
    
    @Test
    mutating func addressIndexedIndirect() {
        p.x = 0x10
        p.memory[0x20] = 0x34
        p.memory[0x21] = 0x12
        #expect(p.address(mode: .indexedIndirect, base: 0x10) == 0x1234)
        
        p.x = 0x01
        p.memory[0xff] = 0x56
        p.memory[0x00] = 0x34
        #expect(p.address(mode: .indexedIndirect, base: 0xfe) == 0x3456)

        p.x = 0xf0
        p.memory[0x00] = 0x78
        p.memory[0x01] = 0x56
        #expect(p.address(mode: .indexedIndirect, base: 0x10) == 0x5678)
    }
    
    @Test
    mutating func addressIndirectIndexed() {
        p.y = 0x10
        p.memory[0x20] = 0x34
        p.memory[0x21] = 0x12
        #expect(p.address(mode: .indirectIndexed, base: 0x20) == 0x1244)

        p.memory[0x00ff] = 0x56
        p.memory[0x0100] = 0x34
        #expect(p.address(mode: .indirectIndexed, base: 0xff) == 0x3466)
    }
    
    /*
    @Test
    mutating func branch() {
        p.pc = 0x8000
        p.branch(flag: true, offset: 0x10)
        let r = p.registers
        #expect(r.pc == 0x8010)
    }
     */
}
