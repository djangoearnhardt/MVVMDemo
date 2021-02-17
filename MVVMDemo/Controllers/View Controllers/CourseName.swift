//
//  CourseName.swift
//  MVC Starter
//
//  Created by Sam LoBue on 2/17/21.
//

enum CourseName {
    case appStore
    case tinder
    case instagram
    case podcast
    case coreData
    case kindle
    case custom(String)
    case none
    
    static var allCases: [CourseName] {
        return [.appStore, .tinder, .instagram, .podcast, .coreData, .kindle, .none]
    }
    
    init(rawValue: String?) {
        switch rawValue {
        case CourseNameStrings.appStore:
            self = .appStore
        case CourseNameStrings.tinder:
            self = .tinder
        case CourseNameStrings.instagram:
            self = .instagram
        case CourseNameStrings.podcast:
            self = .podcast
        case CourseNameStrings.coreData:
            self = .coreData
        case CourseNameStrings.kindle:
            self = .kindle
        case .none:
            self = .none
        case .some(let customString):
            self = .custom(customString)
        }
    }
    
    var rawValue: String {
        switch self {
        case .appStore:
            return "appStore"
        case .tinder:
            return "tinder"
        case .instagram:
            return "instagram"
        case .podcast:
            return "podcast"
        case .coreData:
            return "coreData"
        case .kindle:
            return "kindle"
        case .custom(let customString):
            return customString
        case .none:
            return CourseNameStrings.unknownCourse
        }
    }
}

extension CourseName: Equatable {
    static func == (lhs: CourseName, rhs: CourseName) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
