//
//  Dispatch1.swift
//  P6502Tests
//
//  Created by Mark Erbaugh on 2/25/25.
//

import Testing
@testable import P6502

struct Dispatch1 {
    var p = Model6502()

    @Test
    mutating func bpl() {
        p.registers.pc = 0x1000
        p.registers.n = true
        p.memory[0x1000] = 0x10
        p.memory[0x1001] = 0x80
        p.dispatchLoop()
        #expect(p.registers.pc == 0x1002)
        #expect(p.extraCycles == 0)
        
        p.registers.n = false
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x10
        p.memory[0x1001] = 0x70
        p.dispatchLoop()
        #expect(p.registers.pc == 0x1072)
        #expect(p.extraCycles == 1)
        
        p.registers.n = false
        p.registers.pc = 0x1000
        p.memory[0x1000] = 0x10
        p.memory[0x1001] = 0xf0
        p.dispatchLoop()
        #expect(p.registers.pc == 0x0ff2)
        #expect(p.extraCycles == 2)
    }
    
    @Test
    mutating func oraIndirectIndexed() {
        p.registers.pc = 0x1000
        p.registers.y = 0x20
        p.memory[0x1000] = 0x11
        p.memory[0x1001] = 0x10
        p.memory[0x0010] = 0x34
        p.memory[0x0011] = 0x12
        p.memory[p.indirectIndexed(base: 0x10)] = 0x20
        p.registers.a = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xa0)
        #expect(p.extraCycles == 0)
    }
    
    @Test
    mutating func oraZeroPageX() {
        p.registers.pc = 0x1000
        p.registers.x = 0x10
        p.registers.a = 0x20
        p.memory[0x1000] = 0x15
        p.memory[0x1001] = 0x30
        p.memory[0x0040] = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xa0)
    }
    
    @Test
    mutating func aslZeroPageX() {
        p.registers.pc = 0x1000
        p.registers.x = 0x10
        p.memory[0x1000] = 0x16
        p.memory[0x1001] = 0x30
        p.memory[0x0040] = 0x40
        p.dispatchLoop()
        #expect(p.memory[0x0040] == 0x80)
    }
    
    @Test
    mutating func clc() {
        p.registers.pc = 0x1000
        p.registers.c = true
        p.memory[0x1000] = 0x18
        p.dispatchLoop()
        #expect(!p.registers.c)
    }
    
    @Test
    mutating func oraAbsoluteY() {
        p.registers.pc = 0x1000
        p.registers.y = 0x20
        p.registers.a = 0x20
        p.memory[0x1000] = 0x19
        p.memory[0x1001] = 0xf0
        p.memory[0x1002] = 0x80
        p.memory[0x8110] = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xa0)
        #expect(p.extraCycles == 1)
    }

    @Test
    mutating func oraAbsoluteX() {
        p.registers.pc = 0x1000
        p.registers.x = 0x20
        p.registers.a = 0x20
        p.memory[0x1000] = 0x1d
        p.memory[0x1001] = 0xf0
        p.memory[0x1002] = 0x80
        p.memory[0x8110] = 0x80
        p.dispatchLoop()
        #expect(p.registers.a == 0xa0)
        #expect(p.extraCycles == 1)
    }
    
    @Test
    mutating func aslAbsoluteX() {
        p.registers.pc = 0x1000
        p.registers.x = 0x10
        p.memory[0x1000] = 0x1e
        p.memory[0x1001] = 0x30
        p.memory[0x1002] = 0x40
        p.memory[0x4040] = 0x40
        p.dispatchLoop()
        #expect(p.memory[0x4040] == 0x80)
        #expect(p.extraCycles == 0)
    }}
