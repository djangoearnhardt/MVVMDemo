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
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch courses:", err)
                return
            }
                        
            guard let data = data else { return }
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
