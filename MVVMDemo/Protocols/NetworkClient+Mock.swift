//
//  NetworkClient+Mock.swift
//  MVVMDemo
//
//  Created by Sam LoBue on 6/13/21.
//

import Foundation

// Control mocking func resume in URLSessionDataTask
protocol DataTaskControlling {
    func resume()
}

extension URLSessionDataTask: DataTaskControlling {}

// Control mocking func dataTask in URLSession
protocol URLSessionControlling {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskControlling
}

extension URLSession: URLSessionControlling {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskControlling   {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as DataTaskControlling
    }
}

// A mockable dataTask
class MockDataTask: DataTaskControlling {
    func resume() {}
}

// A mockable urlSession
class MockURLSession: URLSessionControlling {
    var dataTask = MockDataTask()
    
    var completionHandler: (Data?, URLResponse?, Error?)
    
    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskControlling {
        completionHandler(self.completionHandler.0,
                          self.completionHandler.1,
                          self.completionHandler.2)
        return dataTask
    }
}
