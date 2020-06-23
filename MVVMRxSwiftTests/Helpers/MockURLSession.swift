//
//  MockURLSession.swift
//  MVVMRxSwiftTests
//
//  Created by smitesh patel on 2020-06-21.
//  Copyright © 2020 Smitesh Patel. All rights reserved.
//

import Foundation

enum MockType {
    case success
    case noData
    case invalidJSON
    case networkError
    case statusError
    case nonJSON
    case downloadError
    case successWith(statusCode: Int)
    case customResponse(responseFileName: String, statusCode: Int)

    var statusCode: Int {
        switch self {
        case .success, .noData, .invalidJSON, .nonJSON:
            return 200
        case .statusError:
            return 400
        case .networkError:
            return 0
        case .downloadError:
            return 503
        case .customResponse(_, let statusCode):
            return statusCode
        case .successWith(let statusCode):
            return statusCode
        }
    }

    static func == (lhs: MockType, rhs: MockType) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.noData, .noData):
            return true
        case (.invalidJSON, .invalidJSON):
            return true
        case (.networkError, .networkError):
            return true
        case (.statusError, .statusError):
            return true
        case (.downloadError, .downloadError):
            return true
        case (.customResponse(let lhsFileName), .customResponse(let rhsFileName)):
            return lhsFileName == rhsFileName
        case (.successWith(let lhsStatusCode), .successWith(let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        default:
            return false
        }
    }

    static func != (lhs: MockType, rhs: MockType) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return false
        case (.noData, .noData):
            return false
        case (.invalidJSON, .invalidJSON):
            return false
        case (.networkError, .networkError):
            return false
        case (.statusError, .statusError):
            return false
        case (.downloadError, .downloadError):
            return false
        case (.customResponse(let lhsFileName, let lhsStatusCode), .customResponse(let rhsFileName, let rhsStatusCode)):
            return lhsFileName != rhsFileName || lhsStatusCode != rhsStatusCode
        case (.successWith(let lhsStatusCode), .successWith(let rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        default:
            return true
        }
    }
}

final class MockURLSession: URLSession {

    private var mockType: MockType
    var subdirectory: String?

    private var tempDownloadedFileUrl: URL? {
        // Create an empty pdf temp file to test
        let tempDirectory = NSTemporaryDirectory()
        let tempFileName = UUID().uuidString
        let tempFullUrl = URL(fileURLWithPath: tempDirectory).appendingPathComponent(tempFileName).appendingPathExtension("tmp")
        let data = Data(base64Encoded: "test")
        try? data?.write(to: tempFullUrl)
        return FileManager.default.fileExists(atPath: tempFullUrl.path) ? tempFullUrl : nil
    }

    init(mockType: MockType) {
        self.mockType = mockType
    }

    init(mockType: MockType = .success, subdirectory: String) {
        self.mockType = mockType
        self.subdirectory = subdirectory
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(mockType: mockType, subdirectory: subdirectory, request: request) { data in
            guard let url = request.url else { return }
            completionHandler(data, HTTPURLResponse(url: url, statusCode: self.mockType.statusCode, httpVersion: "1.0", headerFields: ["X-XCODE-MOCK-DATA": "YES", "Last-Modified": "Tue, 15 May 2018 20:47:02 GMT"]), self.mockType == .networkError ? NSError(domain: "com.rogers.network.error", code: 1, userInfo: nil) : nil)
        }
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: URLRequest(url: url), completionHandler: { (data, urlResponse, error) in
            completionHandler(data, urlResponse, error)
        })
    }
    
    override func downloadTask(with request: URLRequest, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        return MockURLSessionDownloadTask(mockType: mockType, request: request) {
            guard let url = request.url, let tempDownloadedFileUrl = self.tempDownloadedFileUrl, self.mockType != .downloadError else {
                completionHandler(nil, nil, NSError(domain: "com.rogers.downloadUrl.error", code: 1, userInfo: nil))
                return
            }

            completionHandler(tempDownloadedFileUrl, HTTPURLResponse(url: url, statusCode: self.mockType.statusCode, httpVersion: "1.0", headerFields: ["X-XCODE-MOCK-DATA": "YES"]), self.mockType == .networkError ? NSError(domain: "com.rogers.network.error", code: 1, userInfo: nil) : nil)
            try? FileManager.default.removeItem(at: tempDownloadedFileUrl)
        }
    }
}

final class MockURLSessionDownloadTask: URLSessionDownloadTask {

    typealias CompletionHandler = (() -> Void)

    private var mockType: MockType
    private var request: URLRequest
    private var complete: CompletionHandler

    init(mockType: MockType, request: URLRequest, complete: @escaping CompletionHandler) {
        self.mockType = mockType
        self.request = request
        self.complete = complete
    }

    override func resume() {
        complete()
    }
}

final class MockURLSessionDataTask: URLSessionDataTask {

    typealias CompletionHandler = ((Data?) -> Void)

    private var mockType: MockType
    private var request: URLRequest
    private var complete: CompletionHandler
    private var subdirectory: String?

    init(mockType: MockType, subdirectory: String?, request: URLRequest, complete: @escaping CompletionHandler) {
        self.mockType = mockType
        self.request = request
        self.complete = complete
        self.subdirectory = subdirectory
    }

    override func resume() {
        switch mockType {
        case .success, .downloadError, .successWith(_):
            handleSuccess()
        case .noData:
            complete(nil)
        case .invalidJSON:
            handleInvalidJSON()
        case .networkError:
            complete(nil)
        case .statusError:
            handleStatusError()
        case .nonJSON:
            handleNonJSON()
        case .customResponse(let responseFileName, _):
            handleCustomResponse(fileName: responseFileName)
        }
    }

    private func handleSuccess() {
        guard let lastComponent = request.url?.lastPathComponent else {
            return
        }

        complete(contentsOfFile(fromRequest: request, file: lastComponent))
    }

    private func handleInvalidJSON() {
        struct InvalidObject: ServiceCodable {

            var property: String = ""
        }

        do {
            let data = try JSONEncoder().encode(InvalidObject())
            complete(data)
        } catch let exception {
            assert(false, "Unable to parse InvalidObject \(exception)")
        }
    }

    private func handleStatusError() {
        complete(contentsOfFile(fromRequest: request, file: "statusError"))
    }

    private func handleCustomResponse(fileName: String) {
        complete(contentsOfFile(fromRequest: request, file: fileName))
    }

    private func contentsOfFile(fromRequest: URLRequest, file: String) -> Data? {
        if let subdirectory = subdirectory, let url =  Bundle.main.url(forResource: file, withExtension: "json", subdirectory: subdirectory) {
            return data(from: url)
        } else if let path = request.url?.path, let url =  Bundle(for: type(of: self)).url(forResource: file, withExtension: "json", subdirectory: "/MockResponses\(path)") {
            return data(from: url)
        }

        return nil
    }

    private func data(from url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }

    private func handleNonJSON() {
        let str = "not json"
        if let data = str.data(using: .utf8) {
            complete(data)
        } else {
            complete(nil)
        }
    }
}
