//
//  CourseTests.swift
//  MVVMDemo Tests
//
//  Created by Sam LoBue on 6/12/21.
//

@testable import MVVMDemo
import XCTest

public class CourseResultTests: XCTestCase {
    func testDecodeResult() throws {
        let result = try XCTUnwrap(courseResult(), "Courses should decode from JSON")
        if let firstCourse = result.first(where: { $0.id == 1 }) {
            XCTAssertEqual(firstCourse.id, 1)
            XCTAssertEqual(firstCourse.name, "Instagram Firebase")
            XCTAssertEqual(firstCourse.numberOfLessons, 49)
        }
    }
}

extension CourseResultTests {
    private func courseJSONData() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "course", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func courseResult() throws -> [Course]? {
        guard let data = courseJSONData() else {
            return []
        }
        let decoder = JSONDecoder()
        let courseModel = try decoder.decode([Course].self, from: data)
        return courseModel
    }
}
