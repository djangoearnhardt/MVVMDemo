//
//  CourseController.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    var coursesViewModel = [CourseViewModel]()
    let cellId = "courseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        CourseController.shared.fetchCourses { (courses, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            guard let courses = courses else { return }
            self.coursesViewModel = courses.map({return CourseViewModel(course: $0)})
            self.tableView.reloadData()
        }
    }
    
    fileprivate func purchaseAlert(courseName: String) {
        let uiAlertController = UIAlertController(title: "\(courseName)", message: "Purchased Successfully", preferredStyle: .alert)
        let uiAlertAction = UIAlertAction(title: "Dismiss", style: .destructive)
        uiAlertController.addAction(uiAlertAction)
        present(uiAlertController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coursesViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseCell
        let courseViewModel = coursesViewModel[indexPath.row]
        cell.courseViewModel = courseViewModel
        cell.buttonTapped = { courseName in
            self.purchaseAlert(courseName: courseName)
        }
        return cell
    }
    
    fileprivate func setupTableView() {
        
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension CoursesTableViewController: CellButtonTapping {
    func didTapButton(with courseName: String) {
        purchaseAlert(courseName: courseName)
    }
}

