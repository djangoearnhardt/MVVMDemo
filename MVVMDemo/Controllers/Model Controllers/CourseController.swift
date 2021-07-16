//
//  CourseController.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import Foundation

class CourseController{
    
    static let shared = CourseController()
    
    func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
        
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        
        guard let url = URL(string: urlString) else {
            print("Failed to create URL from:", urlString)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
                        
            guard let data = data else {
                print("Failed to retrieve data from dataTask")
                return
            }
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
        }.resume()
    }
}
