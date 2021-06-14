//
//  CourseController.swift
//  MVC Starter
//
//  Created by David on 2/10/21.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    var courseController: CourseControlling = CourseController.shared
    var coursesViewModel = [CourseViewModel]()
    let cellId = "courseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        courseController.fetchCourses { result in
            switch result {
            case .success(let courses):
                guard let courses = courses else { return }
                self.coursesViewModel = courses.map({return CourseViewModel(course: $0)})
                self.tableView.reloadData()
            case .failure(let error):
                print("Failed to fetch courses:", error)
            }
        }
    }
    
    fileprivate func purchaseAlert(courseName: String) {
        let uiAlertController = UIAlertController(title: "\(courseName)", message: "Purchased Successfully", preferredStyle: .alert)
        let uiAlertAction = UIAlertAction(title: ButtonTitleStrings.dismiss, style: .destructive)
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
//        cell.delegate = self
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
