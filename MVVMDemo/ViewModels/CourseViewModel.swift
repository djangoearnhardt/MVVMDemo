//
//  CourseViewModel.swift
//  MVC Starter
//
//  Created by Sam LoBue on 2/11/21.
//

import UIKit

struct CourseViewModel {
    
    let name: CourseName
    let titleText: String
    let detailText: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // init the ViewModel from your Model and do the business logic in the ViewModel
    init(course: Course) {
        self.name = CourseName(rawValue: course.name)
        self.titleText = course.name
        if course.numberOfLessons >= 40 {
            detailText = "Lessons 40+ Check it Out!"
            accessoryType = .detailDisclosureButton
        } else {
            detailText = "Lessons: \(course.numberOfLessons)"
            accessoryType = .none
        }
    }
}
