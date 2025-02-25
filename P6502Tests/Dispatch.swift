//
//  Dispatch.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/24/25.
//

import Testing
@testable import P6502

struct Dispatch {
    var p = Model6502()
    
    @Test
    mutating func getByte() {
        p.memory[0xc000] = 0x80
        p.registers.pc = 0xc000
        #expect(p.getByte() == UInt8(0x80))
        #expect(p.registers.pc == 0xc001)
    }
    
    @Test
    mutating func getWord() {
        p.memory[0xc000] = 0x80
        p.memory[0xc001] = 0x40
        p.registers.pc = 0xc000
        #expect(p.getWord() == UInt16(0x4080))
        #expect(p.registers.pc == 0xc002)
    }
    
    @Test
    mutating func brk() {
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x00
        p.memory[0xfffe] = 0x00
        p.memory[0xffff] = 0xc0
        p.dispatchLoop()
        #expect(p.registers.pc == 0xc000)
    }
    
    @Test
    mutating func oraIndexedIndirect() {
        p.registers.x = 0x10
        p.registers.a = 0x40
        
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x01
        p.memory[0x1001] = 0x20
        
        p.memory[0x30] = 0x80
        p.memory[0x31] = 0xb0
        
        p.memory[0xb080] = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xc0)
    }
    
    @Test
    mutating func oraZeroPage() {
        p.registers.a = 0x40
        
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x05
        p.memory[0x1001] = 0x20
        
        p.memory[0x20] = 0x80
        p.memory[0x21] = 0xb0
        
        p.memory[0xb080] = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xc0)
    }
    
    @Test
    mutating func aslZeroPage() {
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x06
        p.memory[0x1001] = 0x20
        
        p.memory[0x20] = 0x40
        
        p.dispatchLoop()
        #expect(p.memory[0x20] == 0x80)
    }
    
    @Test
    mutating func php() {
        p.registers.c = true
        p.registers.z = false
        print("flags \(p.registers.flags)")
        p.registers.sp = 0xff
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x08
        p.dispatchLoop()
        #expect(p.memory[0x01ff] == 0x21)
    }
    
    @Test
    mutating func oraImmediate() {
        p.registers.a = 0x40
        
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x09
        p.memory[0x1001] = 0x80
        
        p.dispatchLoop()
        #expect(p.registers.a == 0xc0)
    }
    
    @Test
    mutating func aslA() {
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x0a
        
        p.registers.a = 0x40
        
        p.dispatchLoop()
        #expect(p.registers.a == 0x80)
    }
    
    @Test
    mutating func oraAbsolute() {
        p.registers.a = 0x40
        
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x0d
        p.memory[0x1001] = 0x80
        p.memory[0x1002] = 0xc0
        
        p.memory[0xc080] = 0x80
        
        p.dispatchLoop()
        #expect(p.registers.a == 0xc0)
    }
    
    @Test
    mutating func aslAbsolute() {
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x0e
        p.memory[0x1001] = 0x80
        p.memory[0x1002] = 0xc0
        
        p.memory[0xc080] = 0x40
        
        p.dispatchLoop()
        #expect(p.memory[0xc080] == 0x80)
    }
}
