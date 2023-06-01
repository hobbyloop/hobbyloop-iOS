//
//  LogFile.swift
//  HPExtensions
//
//  Created by 김진우 on 2023/05/22.
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
