//
//  FetchCoursesTests.swift
//  MVVMDemo Tests
//
//  Created by Sam LoBue on 6/13/21.
//

@testable import MVVMDemo
import XCTest

class CourseControllerTests: XCTestCase {

    var mockSession: MockURLSession?
    var courseController: CourseController?
    
    override func tearDown() {
        mockSession = nil
        courseController = nil
        super.tearDown()
    }
    
    func testFetchCoursesSucceeds() {
        // GIVEN
        // Valid data
        let data = createJSONDataThatSucceedsToDecode()
        mockSession = createMockSession(withData: data, andError: nil)
        guard let mockSession = mockSession else {
            XCTFail()
            return
        }
        
        // WHEN
        // The CourseController fetches data
        courseController = CourseController(withSession: mockSession)
        var error: Error?
        var courses: [Course]?
        let expectation = expectation(description: "courseController fetch")
        
        courseController?.fetchCourses { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            case .success(let resultCourses):
                courses = resultCourses
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        // THEN
        // Courses are present without error
        XCTAssertNotNil(courses, "fetchCourses should return non-nil courses")
        XCTAssertNil(error, "fetchCourses should return a nil error")
    }
    
    func testFetchCoursesFailsToDecode() {
        // GIVEN
        // Invalid data
        let data = createJSONDataThatFailsToDecode()
        mockSession = createMockSession(withData: data, andError: nil)
        guard let mockSession = mockSession else {
            XCTFail()
            return
        }
        
        // WHEN
        // The CourseController fetches data
        courseController = CourseController(withSession: mockSession)
        var decodingError: Error?
        var courses: [Course]?
        let expectation = expectation(description: "courseController fetch")
        
        courseController?.fetchCourses { result in
            switch result {
            case .failure(let resultError):
                decodingError = resultError
            case .success(let resultCourses):
                courses = resultCourses
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        // THEN
        // A decoding error is present with no course objects
        XCTAssertEqual(decodingError?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        XCTAssertNil(courses, "Courses should not be present when they fail to decode")
    }
    
    func testFetchCoursesFailsWithTransportError() {
        // GIVEN
        // A dataTask with a transportError
        mockSession = createMockSession(withData: nil, andError: DataTaskError.transportError)
        guard let mockSession = mockSession else {
            XCTFail()
            return
        }
        
        // WHEN
        // The CourseController fetches data
        courseController = CourseController(withSession: mockSession)
        var error: Error?
        var courses: [Course]?
        let expectation = expectation(description: "courseController fetch")
        
        courseController?.fetchCourses { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            case .success(let resultCourses):
                courses = resultCourses
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        // THEN
        // An error is present with no course objects
        XCTAssertEqual(error?.localizedDescription, DataTaskError.transportError.localizedDescription)
        XCTAssertNil(courses, "Courses should not be present with a transportError")
    }
    
    func testFetchCoursesFailsWithNoData() {
        // GIVEN
        // A dataTask with no data
        mockSession = createMockSession(withData: nil, andError: nil)
        guard let mockSession = mockSession else {
            XCTFail()
            return
        }
        
        // WHEN
        // The CourseController fetches data
        courseController = CourseController(withSession: mockSession)
        var error: Error?
        var courses: [Course]?
        let expectation = expectation(description: "courseController fetch")
        
        courseController?.fetchCourses { result in
            switch result {
            case .failure(let resultError):
                error = resultError
            case .success(let resultCourses):
                courses = resultCourses
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        
        // THEN
        // An error is present with no course objects
        XCTAssertEqual(error?.localizedDescription, DataTaskError.dataMissing.localizedDescription)
        XCTAssertNil(courses, "Courses should not be present when data is missing")
    }
}

private extension CourseControllerTests {
    func createMockSession(withData data: Data?, andError error: Error?) -> MockURLSession? {
        return MockURLSession(completionHandler: (data, nil, error))
    }
    
    func createJSONDataThatSucceedsToDecode() -> Data? {
        guard let jsonData = courseJSONString().data(using: .utf8) else {
            return nil
        }
        return jsonData
    }
    
    func createJSONDataThatFailsToDecode() -> Data? {
        guard let jsonData = "".data(using: .utf8) else {
            return nil
        }
        return jsonData
    }
    
    func courseJSONString() -> String {
        let jsonString = """
                [{
                    "id": 6,
                    "name": "AppStore JSON APIs",
                    "link": "https://www.letsbuildthatapp.com/course/AppStore-JSON-APIs",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/fd78be85-b845-4672-a316-7df0abe80812_medium",
                    "numberOfLessons": 47
                }, {
                    "id": 5,
                    "name": "Tinder Firestore Swipe and Match",
                    "link": "https://www.letsbuildthatapp.com/course/Tinder-Firestore-Swipe-and-Match",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/bc5a4091-d2ea-44ab-b749-5f2ee5354c35_medium",
                    "numberOfLessons": 47
                }, {
                    "id": 1,
                    "name": "Instagram Firebase",
                    "link": "https://www.letsbuildthatapp.com/course/instagram-firebase",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/04782e30-d72a-4917-9d7a-c862226e0a93",
                    "numberOfLessons": 49
                }, {
                    "id": 2,
                    "name": "Podcasts Course",
                    "link": "https://www.letsbuildthatapp.com/course/podcasts",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/32f98d9d-5b9b-4a22-a012-6b87fd7158c2_medium",
                    "numberOfLessons": 39
                }, {
                    "id": 3,
                    "name": "Intermediate Training Core Data",
                    "link": "https://www.letsbuildthatapp.com/course/intermediate-training-core-data",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/0736fecb-5b88-483b-a83d-ca2a5a6d93f9_medium",
                    "numberOfLessons": 32
                }, {
                    "id": 4,
                    "name": "Kindle Basic Training",
                    "link": "https://www.letsbuildthatapp.com/basic-training",
                    "imageUrl": "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/a6180731-c077-46e7-88d5-4900514e06cf_medium",
                    "numberOfLessons": 19
                }]
            """
        return jsonString
    }
}
