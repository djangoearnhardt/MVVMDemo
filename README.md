# MVVMDemo

Fetch data, then present the data results with the Model-View-ViewModel design pattern.

The goal of this project is to refactor an existing MVC design pattern. The UITableViewCell was making business decisions about each data object and being passed a Course. The UITableViewCell now styles it's view (CourseView) and delegates button taps from decisions made in the CourseViewModel.
