//
//  MVC_StarterTests.swift
//  MVC StarterTests
//
//  Created by Sam LoBue on 2/11/21.
//

@testable import MVVMDemo
import XCTest

class MVVMDemo_Tests: XCTestCase {

    func testMath() {
        XCTAssert(1 == 1)
    }

    func testMathTwo() {
        XCTAssertEqual(2, 2)
    }
    
    func testCourseViewModelUnder40() {
        // GIVEN
        // A Course is initialized
        let course = Course(id: 1, name: "Course name", number_of_lessons: 10)
        
        // WHEN
        // A CourseViewModel is initialized from that Course
        let courseViewModel = CourseViewModel(course: course)
        
        // THEN
        // A Course's name is equal to the CourseViewModel's name
        XCTAssertEqual(course.name, courseViewModel.titleText)
        
        // The CourseViewModel detailString appears as we expect
        XCTAssertEqual("Lessons: \(course.number_of_lessons)", courseViewModel.detailText)
        
        // The accessory type is none
        XCTAssertEqual(.none, courseViewModel.accessoryType)
    }
    
    func testCourseViewModelUnder50() {
        // GIVEN
        // A Course is initialized
        let course = Course(id: 1, name: "Course name", number_of_lessons: 50)
        
        // WHEN
        // A CourseViewModel is initialized from that Course
        let courseViewModel = CourseViewModel(course: course)
        
        // THEN
        // A Course's name is equal to the CourseViewModel's name
        XCTAssertEqual(course.name, courseViewModel.titleText)
        
        // The CourseViewModel detailString appears as we expect
        XCTAssertEqual("Lessons 40+ Check it Out!", courseViewModel.detailText, "An unexpected result took place")
        
        // The accessory type is a detail disclosure button
        XCTAssertEqual(.detailDisclosureButton, courseViewModel.accessoryType)
    }
}
