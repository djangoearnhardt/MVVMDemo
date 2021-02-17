//
//  UIColorExtension.swift
//  MVVMDemo
//
//  Created by Sam LoBue on 2/17/21.
//

import UIKit

/// Extending UIColor to include CourseName raw values, allows another use of CourseName in the Color Assets folder
extension UIColor {
    static let appStore = UIColor(named: CourseName.appStore.rawValue)!
    static let tinder = UIColor(named: CourseName.tinder.rawValue)!
    static let instagram = UIColor(named: CourseName.instagram.rawValue)!
    static let podcast = UIColor(named: CourseName.podcast.rawValue)!
    static let coreData = UIColor(named: CourseName.coreData.rawValue)!
    static let kindle = UIColor(named: CourseName.kindle.rawValue)!
}
