//
//  NetworkLogger.swift
//  MVVMRxSwift
//
//  Created by smitesh patel on 2020-06-22.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

// MARK: - NetworkLogger class
class NetworkLogger: Loggable {
    
    // MARK: Loggable
    var logFileName: String = ""
    var items: [String] = []
    
    init(logFileName: String = "network.log") {
        self.logFileName = logFileName
    }
}

// MARK: - NetworkLogger Internals
extension NetworkLogger {
    
    func log(request: URLRequest) {
        log(heading: "REQUEST", url: request.url?.absoluteString, method: request.httpMethod, headers: request.allHTTPHeaderFields, data: request.httpBody)
    }
    
    func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
        log(heading: "RESPONSE", url: response?.url?.absoluteString, status: response?.statusCode, headers: response?.allHeaderFields, data: data, error: error)
    }
}

// MARK: - NetworkLogger Privates
extension NetworkLogger {
    
    private func log(heading: String, url: String?, method: String? = nil, status: Int? = nil, headers: [AnyHashable: Any]?, data: Data?, error: Error? = nil) {
        var message = "\n=========================\(heading)=========================\r\n\n"
        
        if let url = url {
            message += "URL: \t\t\(url)\r\n"
        }
        
        if let status = status {
            message += "STATUS:\t\(status)\r\n"
        }
        
        if let method = method {
            message += "METHOD:\t\(method)\r\n"
        }
        
        if let headers = headers, !headers.isEmpty {
            message += "HEADERS:\r\n"
            headers.forEach {
                message += "\t\t\t\($0.key): \($0.value)\r\n"
            }
        }
        
        if let data = data, let stringValue = data.stringValue {
            message += "DATA: \r\n\(stringValue.removedSpaces)\r\n"
        }
        
        if let error = error as NSError? {
            message += "ERROR:\t\(error.code): \(error.localizedDescription)\r\n"
        }
        
        log(message: message)
        items.append(message)
    }
}

extension Data {
    
    fileprivate var stringValue: String? {
        return String(data: self, encoding: .utf8)
    }
}

extension String {
    
    fileprivate var removedSpaces: String {
        return trimmingCharacters(in: .whitespaces)
    }
}
