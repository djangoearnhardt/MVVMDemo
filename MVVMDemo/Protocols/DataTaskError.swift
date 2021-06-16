//
//  DataTaskError.swift
//  MVVMDemo
//
//  Created by Sam LoBue on 6/16/21.
//

import Foundation

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

