//
//  LogFile.swift
//  HPNetwork
//
//  Created by Kim dohyun on 2023/09/15.
//

import Foundation


public struct LogFile {
    public static func logging<T>(_ object: T?, filename: String = #file, line: Int = #line, funcName: String = #function) {
        if let obj = object {
            print("""
            \(obj)
            \(Date())
            file: \(filename.components(separatedBy: "/").last ?? "")
            funcName: \(funcName)
            line: \(line)
            """)
        } else {
            print("""
            nil
            \(Date())
            file: \(filename.components(separatedBy: "/").last ?? "")
            funcName: \(funcName)
            line: \(line)
            """)
        }
        print("------------------")
    }
}
