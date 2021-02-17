//
//  CellButtonTapping.swift
//  MVVMDemo
//
//  Created by Sam LoBue on 2/17/21.
//

/// Delegate a UIButton tap from a CourseCell
protocol CellButtonTapping: AnyObject {
    func didTapButton(with courseName: String)
}
