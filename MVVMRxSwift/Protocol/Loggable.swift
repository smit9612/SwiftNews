//
//  Loggable.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation
// MARK: - Loggable
protocol Loggable {

    var logFileName: String { get set }
    var items: [String] { get set }
}

// MARK: - Internals
extension Loggable {

    func log(message: String) {
        // TODO: Enable/Disable logging based on flag
        print(message)
    }
    
    func save() -> String? {
        guard let url = try? logFileURL() else { return nil }
        do {
            try items.joined(separator: "\r\n").write(to: url, atomically: false, encoding: .utf8)
        } catch {
            return nil
        }
        return url.path
    }

    func remove() {
        do {
            let url = try logFileURL()
            try FileManager.default.removeItem(at: url)
        } catch {}
    }
}

// MARK: - Privates
extension Loggable {

    private func logFileURL() throws -> URL {
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                             in: .userDomainMask,
                                                             appropriateFor: nil,
                                                             create: true)
        return documentsDirectory.appendingPathComponent(logFileName)
    }
}
