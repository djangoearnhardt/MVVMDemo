//
//  CourseController.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import Foundation

protocol CourseControlling {
    func fetchCourses(completion: @escaping (Result<[Course]?, Error>) -> ())
}

class CourseController: CourseControlling {
    private var session: URLSessionControlling
    static let shared = CourseController()
    
    init(withSession session: URLSessionControlling = URLSession.shared) {
        self.session = session
    }
    
    func fetchCourses(completion: @escaping (Result<[Course]?, Error>) -> ()) {
        
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        guard let url = URL(string: urlString) else {
            print("Failed to create URL from:", urlString)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print("Failed to fetch courses:", err)
                return
            }
                        
            guard let data = data else {
                let error = DataTaskError.dataMissing
                completion(.failure(error))
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(courses))
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
                completion(.failure(jsonErr))
            }
        }
        dataTask.resume()
    }
}
