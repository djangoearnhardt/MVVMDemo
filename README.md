# MVVMDemo

Fetch data, then present the data results with the Model-View-ViewModel design pattern.

The goal of this project is to refactor an existing MVC design pattern. 

The UITableViewCell was making business decisions about each data object and being passed a Course. 
The UITableViewCell now styles it's view (CourseView) and delegates button taps from decisions made in the CourseViewModel.

Features:

1. Each cell is styled from the Course object it is handed
2. The styling is done safely with an enum CourseName, adhering to the DRY principle
3. Each cell's button recognizes which Course it interacts with, and presents an associated alert

<br>
<p align="center">
<img src="https://user-images.githubusercontent.com/14178930/108271533-cd7a3900-7125-11eb-8571-526843b5f744.png" width="250">
</p>
