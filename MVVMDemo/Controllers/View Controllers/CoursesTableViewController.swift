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

struct CourseNameStrings {
    static let appStore = "AppStore JSON APIs"
    static let tinder = "Tinder Firestore Swipe and Match"
    static let instagram = "Instagram Firebase"
    static let podcast = "Podcasts Course"
    static let coreData = "Intermediate Training Core Data"
    static let kindle = "Kindle Basic Training"
    static let unknownCourse = "Unknown Course"
}

extension UIColor {
    static let appStore = UIColor(named: CourseName.appStore.rawValue)!
    static let tinder = UIColor(named: CourseName.tinder.rawValue)!
    static let instagram = UIColor(named: CourseName.instagram.rawValue)!
    static let podcast = UIColor(named: CourseName.podcast.rawValue)!
    static let coreData = UIColor(named: CourseName.coreData.rawValue)!
    static let kindle = UIColor(named: CourseName.kindle.rawValue)!
}
