//
//  NetworkClient+Mock.swift
//  MVVMDemo
//
//  Created by Sam LoBue on 6/13/21.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol   {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

class MockURLSession: URLSessionProtocol {
    var dataTask = MockURLSessionDataTask()
    
    var completionHandler: (Data?, URLResponse?, Error?)
    
    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.0,
                          self.completionHandler.1,
                          self.completionHandler.2)
        return dataTask
    }
}

enum DataTaskError: String, Error, CustomStringConvertible, LocalizedError {
    case dataMissing
    case transportError
    
    var description: String {
        self.rawValue
    }
    
    var errorDescription: String? {
        switch self {
        case .dataMissing:
            return NSLocalizedString(
                "Missing data from dataTask request",
                comment: "Data Missing"
            )
        case .transportError:
            return NSLocalizedString(
                "HTTP Transport Error",
                comment: "Transport Error"
            )
        }
    }
}
