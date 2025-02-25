//
//  Dispatch.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/24/25.
//

import Foundation

enum OpCode6502: UInt8 {
    case brk = 0x00
    case oraIndexedIndirect = 0x01
    case oraZeroPage = 0x05
    case aslZeroPage = 0x06
    case php = 0x08
    case oraImmediate = 0x09
    case aslA = 0x0a
    case oraAbsolute = 0x0d
    case aslAbsolute = 0x0e
    //
    case bpl = 0x10
    case oraIndirectIndexed = 0x11
    case oraZeroPageX = 0x15
    case aslZeroPageX = 0x16
    case clc = 0x18
    case oraAbsoluteY = 0x19
    case oraAbsoluteX = 0x1d
    case aslAbsoluteX = 0x1e
}

extension Model6502 {
    mutating func getByte() -> UInt8 {
        let iPC = Int(registers.pc)
        let mem = memory[iPC]
        registers.pc = UInt16(truncatingIfNeeded: iPC + 1)
        // print("mem: \(mem)")
        return mem
    }
    
    mutating func getWord() -> UInt16 {
        UInt16(getByte()) | ((UInt16(getByte()) << 8))
    }
    
    func cycleDelay(cycles: UInt8) {
    }
    
    mutating func dispatchLoop() {
        extraCycles = 0
        func dispatch(opCode: OpCode6502) {
            switch opCode {
            case .brk:
                brk()
                cycleDelay(cycles: 7)
            case .oraIndexedIndirect:
                ora(value: memory[indexedIndirect(base: getByte())])
                cycleDelay(cycles: 6)
            case .oraZeroPage:
                ora(value: memory[Int(getByte())])
                cycleDelay(cycles: 3)
            case .aslZeroPage:
                let addr = Int(getByte())
                memory[addr] = asl(value: memory[addr])
                cycleDelay(cycles: 5)
            case .php:
                php()
                cycleDelay(cycles: 3)
            case .oraImmediate:
                ora(value: getByte())
                cycleDelay(cycles: 4)
            case .aslA:
                registers.a = asl(value: registers.a)
                cycleDelay(cycles: 2)
            case .oraAbsolute:
                ora(value: memory[Int(getWord())])
                cycleDelay(cycles: 4)
            case .aslAbsolute:
                let addr = Int(getWord())
                memory[addr] = asl(value: memory[addr])
                cycleDelay(cycles: 6)
                //
            case .bpl:
                bpl(offset: getByte())
                cycleDelay(cycles: 2)
            case .oraIndirectIndexed:
                ora(value: memory[indirectIndexed(base: getByte())])
                cycleDelay(cycles: 5)
            case .oraZeroPageX:
                ora(value: memory[zeroPageX(base: getByte())])
                cycleDelay(cycles: 4)
            case .aslZeroPageX:
                let addr = zeroPageX(base: getByte())
                memory[addr] = asl(value: memory[addr])
                cycleDelay(cycles: 6)
            case .clc:
                registers.c = false
                cycleDelay(cycles: 2)
            case .oraAbsoluteY:
                ora(value: memory[absoluteY(base: getWord())])
                cycleDelay(cycles: 4)
            case .oraAbsoluteX:
                ora(value: memory[absoluteX(base: getWord())])
                cycleDelay(cycles: 4)
            case .aslAbsoluteX:
                let addr = absoluteX(base: getWord())
                memory[addr] = asl(value: memory[addr])
                extraCycles = 0
                cycleDelay(cycles: 7)
            }
        }
    
        if let opCode = OpCode6502(rawValue: getByte()) {
            dispatch(opCode: opCode)
        }
    }
}
