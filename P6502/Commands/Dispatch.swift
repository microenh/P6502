//
//  Dispatch.swift
//  P6502
//
//  Created by Mark Erbaugh on 2/24/25.
//

import Foundation

enum OpCode6502: UInt8 {
    case brk = 0x00
    case oraIndirectIndexed = 0x01
    case oraZeroPage = 0x05
    case aslZeroPage = 0x06
    case php = 0x08
    case oraImmediate = 0x09
    case aslA = 0x0a
    case oraAbsolute = 0x0d
    case aslAbsolute = 0x0e
}

extension Model6502 {
    mutating func getByte() -> UInt8 {
        let iPC = Int(registers.pc)
        let mem = memory[iPC]
        registers.pc = UInt16(truncatingIfNeeded: iPC + 1)
        // print("mem: \(mem)")
        return mem
    }
    
    func cycleDelay(cycles: UInt8) {
    }
    
    mutating func dispatchLoop() {
        func dispatch(opCode: OpCode6502) {
            switch opCode {
            case .brk:
                brk()
                cycleDelay(cycles: 7)
            case .oraIndirectIndexed:
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
                ora(value: memory[Int(getByte()) | (Int(getByte()) << 8)])
                cycleDelay(cycles: 4)
            case .aslAbsolute:
                let addr = Int(getByte()) | (Int(getByte()) << 8)
                memory[addr] = asl(value: memory[addr])
                cycleDelay(cycles: 6)
            //default:
            //    break
            }
        }
    
        if let opCode = OpCode6502(rawValue: getByte()) {
            dispatch(opCode: opCode)
        }
    }
}
