# Task

Students will build a simple task tracking app to practice project planning, progress tracking, MVC separation, intermediate table view features, and Core Data.
Students who complete this project independently are able to:

## Project Planning, Model Objects and Controllers, Persistence with Core Data
* follow a project planning framework to build a development plan
* follow a project planning framework to prioritize and manage project progress
* identify and build a simple navigation view hierarchy
* create a model object using Core Data
* add staged data to a model object controller
* implement a master-detail interface
* implement the UITableViewDataSource protocol
* implement a static UITableView
* create a custom UITableViewCell
* write a custom delegate protocol
* use a date picker as a custom input view
* wire up view controllers to model object controllers
* add a Core Data stack to a project
* implement basic data persistence with Core Data

## View Hierarchy
Set up a basic List-Detail view hierarchy using two UITableViewController's, a TaskListTableViewController and a TaskDetailTableViewController.
* Add a UITableViewController scene that will be used to list tasks
* Embed the scene in a UINavigationController
* Add an Add system bar button item to the navigation bar
* Add a class file TaskListTableViewController.swift and assign the scene in the Storyboard
* Add a UITableViewController scene that will be used to add and view tasks
    * note: We will use a static table view for our Task Detail view, static table views should be used sparingly, but they can be useful for a table view that will never change, such as a basic form.
* Add a segue from the Add bar button item from the first scene to the second scene
* Add a segue from the prototype cell in the first scene to the second scene
* Add a class file TaskDetailTableViewController.swift and assign the scene in the Storyboard
    * note: We will finish building our views later on
## Add a Core Data Stack
You will add a CoreDataStack class that will initialize your persistent store, coordinator, and managed object context. Then you will build your Core Data data model.
* Create a new file called CoreDataStack.swift.
* Import CoreData and then add the following code to the file:

```
enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MedicationManager")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
```

* note: You do not need to memorize this, but do your best to understand what is going on in each line of code in your CoreDataStack

## Implement Core Data Model
* Add a New Entity called Task with attributes for name (String), notes (String), due (Date), and isComplete (Bool).
* Use the Data Model inspector to set notes and due to optional values and give isComplete a default value of false.

Now you need to add a convenience initializer for your Task objects that matches what would normally be a member-wise initializer. NSManagedObjects have a designated initializer called init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) and a convenience initializer called init(context: NSManagedObjectContext). You will write your own convenience initializer that uses the NSManagedObject convenience initializer and sets the properties on a Task object.
* Create a new file called Task+Convenience.swift.
* Add an extension to Task and create your convenience initializer inside of the extension
    * note: Make sure the initializer has parameters for name, notes, due, and context and that each parameter takes in the right type (context will be of type NSManagedObjectContext).
    * note: Remember that notes and due are optional, therefore, you can give them default values of nil. Also, give context a default value of CoreDataStack.context.
* Inside the body of the initializer set your Task properties and call the NSManagedObject convenience initializer and pass in context from your own convenience initializer —> self.init(context: context)

## Controller Basics
Create a TaskController model object controller that will manage and serve Task objects to the rest of the application. The TaskController will also handle persistence using Core Data.
* Create a TaskController.swift file and define a new TaskController class inside.
* Create a shared property as a shared instance.
* Add a tasks Array property with an empty default value.
* Create function signatures for add(taskWithName name: String, notes: String?, due: Date?), update(task: Task, name: String, notes: String?, due: Date?), remove(task: Task), and fetchTasks().

## Controller Staged Data Using a Mock Data Function
Add mock task data to the TaskController. Once there is mock data, teams can serialize work, with some working on the views with visible data and others working on implementing the controller logic. This is a quick way to get objects visible so you can begin building the views.
There are many ways to add mock data to model object controllers. We will do so using a computed property.
* Create a mockTasks: [Task] computed property that will hold a number of staged Task objects
* Initialize a small number of Task objects with varying properties (include at least one ‘isComplete’ task and one task with a due date)
Generally, when you use mock data, you set self.tasks to self.mockTasks in the initializer and then remove it when you no longer need mock data. In this case, we will be setting our mock data through our fetchTasks() function since that is what we will be doing when we use real data.
* in your fetchTasks() function, simply assign your mock data to your tasks array. We will change this later.
At this point, you can wire up your list table view to display the complete or incomplete tasks to check your progress on Part One.

## Basic Task List View
Go to TaskListTableViewController.swift and finish setting up your views.
You will want this view to call your fetchTasks() function, and then to reload the table view each time it appears in order to display newly created tasks.
* Implement the UITableViewDataSource functions using the TaskController tasks array
* Set up your cells to display the name of the task (we’ll create a custom table view cell later so we’ll have to come back to this function later and change some things)

## Detail View Setup
Go to your TaskDetailTableViewController scene in storyboard and finish setting up the views.
You will use a UITextField to capture the name of a task, a UITextView to capture notes, and a ‘Save’ UIBarButtonItem to save the task.
Look at the task detail screenshot in the project folder and set up the Storyboard scene with all of the required user interface elements to appear similarly.
* Update the table view to use static cells and make sure the style is ‘Grouped’
* Create three separate sections, each with one cell (each section will come with 3 cells, so you’ll have to delete two cells from each section)
* Change the name of the header in the first section to ‘Name’ and add a UITextField to the cell with placeholder text
    * note: Placeholder text should tell the user what they should put in the text field
* Change the name of the header in the second section to ‘Due’ and add a UITextField to the cell with placeholder text
* Change the name of the header in the third section to ‘Notes’ and add a text view to the cell
* Resize the UI elements and add constraints so that they fill each cell
* Add a Navigation Item to the Navigation Bar and then add two UIBarButtonItems to the Navigation Bar and change the System Item of one of them to ‘Save’ and to ‘Cancel’ for the other

## Setup the TaskDetailTableViewController class
* Delete boilerplate code from your TaskDetailTableViewController class
    * note: Since the task detail table view is a static table view you don’t need UITableViewDataSource functions, so you can delete those as well.
* Add an optional task property of type Task? and an optional dueDateValue property of type Date?
* Add the appropriate outlets and IBActions from your detail scene in storyboard to your TaskDetailTableViewController class.
    * note: The IBAction for your ‘Save’ bar button item should save a new task if the task property is nil and update the existing task otherwise (even though we haven’t set it yet, use dueDateValue for the date that you pass into your add and update functions.
    * note: If you want, you can create another function called updateTask() that will do this for you and then call that function in your IBAction.
    * note: The IBAction for your ‘Cancel’ bar button item should simply pop the view controller, your ‘Save’ IBAction should do the same after it has updated the task
Your Detail View should follow the ‘updateViews’ pattern for updating the view elements with the details of a model object.
* Add an updateViews() function
* Implement the function to update all view elements that reflect details about the model object (in this case, the name text field, the due date text field, and the notes text view) and also have it check to see if the view has been loaded.
    * note: Dates require some extra work when we try to set them to labels. We’ll implement an extension on Date using DateFormatter to get a prettier label in the next step.
* Call updateViews() in your viewDidLoad()

## Date Formatting
Dates are a notoriously difficult programming problem. Date creation, formatting, and math are all challenging for beginner programmers. This section will walk you through creating helper functions, setting dates, and using a date picker in place of a keyboard to set a date label.
Because Dates do not print in a user readable format, Apple includes the DateFormatter class to convert dates into strings and strings back into dates. 
There are many different ways to work with Dates though. You will have seen some solutions in class. Today, we will present you with another way to format your dates. We will add an extension to Date and make a reusable stringValue() function that returns a formatted string.
You could place this extension code directly into the view controller that will display the view, but creating an extension in a separate file allows you to reuse the code throughout the application and reuse the file in other projects you work on in the future.
* Add a new DateHelpers.swift file and define an extension on Date
* Create a stringValue() -> String function that instantiates a DateFormatter, sets the dateStyle, and returns a string from the date.

```
extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: self)
    }
}

```

* Go back to your updateViews() function and use task.due.stringValue() to set the text for the due label (you may have to cast task.due as a Date first.

## Capture the Due Date
* Add a UIDatePicker  to the detail scene
* Create an IBOutlet named dueDatePicker from the UIDatePicker to the class file
* In viewDidLoad(), set the date picker as the taskDueTextFields input view
    * hint: taskDueTextField.inputView = dueDatePicker
* Create an IBAction from the UIDatePicker to the class file, named datePickerValueChanged
    * note: Choose UIDatePicker as the sender type so that you do not need to cast the object to get the date off of it
* Implement the action to store the updated date value to dueDateValue and to set the taskDueTextField.text to the string value from the date picker’s date


## Segue
Recall that you created two segues from the List View to the Detail View. The segue from the plus button will tell the TaskDetailTableViewController that it should create a new task. The segue from a selected cell will tell the TaskDetailTableViewController that it should display a previously created task and save any changes made to it.
* If you haven’t already, give the segue from a table view cell to the detail view an identifier.
* Add a prepare(for segue: UIStoryboardSegue, sender: Any?) function to the TaskListTableViewController if it’s not there already
* Implement the prepare(for segue: UIStoryboardSegue, sender: Any?) function. Be sure to check the identifier of the segue, get the destination of the segue, then get the index path for the selected row and use that index path to pass the selected task to the task property on the TaskDetailTableViewController
    * note: You will also want to pass the due property from your selected task to the dueDateValue property in your TaskDetailTableViewController
* Go to the TaskDetailTableViewController class and update your task property to a computed property that uses a didSet property observer to call updateViews() every time task gets set. Thus, when you pass the task from your prepare(for segue: UIStoryboardSegue, sender: Any?) function to the task computed property it will update the views to reflect the properties of the selected task.

## Custom Table View Cell
Build a custom table view cell to display tasks. The cell should display the task name and have a button that acts as a checkmark to display and toggle the completion status of the task.
It is best practice to make table view cells reusable between apps. As a result, you will build a ButtonTableViewCell rather than a TaskTableViewCell that can be reused any time you want a cell with a button. You will add an extension to the ButtonTableViewCell for updating the view with a Task.
* Add a new ButtonTableViewCell.swift as a subclass of UITableViewCell
* Assign the new class to the prototype cell on the Task List Scene in Main.storyboard
* Design the prototype cell with a label on the left and a square button on the right margin
    * note: If you are using a stack view, constrain the aspect ratio of the button to 1:1 to force the button into a square that gives the remainder of the space to the label
    * note: If needed, use the image edge inset to shrink the image to not fill the entire height of the content view, you can adjust the image edge insets in the Size Inspector of the UIButton
* Remove text from the button, but add a image of an empty checkbox
    * note: Use the ‘complete’ and ‘incomplete’ image assets included in the projects assets folder
* Create an IBOutlet for the label named primaryLabel
* Create an IBOutlet for the button named completeButton
* Create an IBAction for the button named buttonTapped which you will implement using a custom protocol in the next step

## Implement the ‘update(with:)’ pattern in and extension on the ButtonTableViewCell class.
* Add an updateButton(_ isComplete: Bool) function that updates the button’s image to the desired image based on the isComplete Bool
* Add an extension to ButtonTableViewCell at the bottom of the class file
* Add a function update(withTask task: Task) that updates the label to the name of the task and calls the updateButton(_ isComplete: Bool) function to update the image
* Update the tableView(_:cellForRowAt:) table view data source function in your TaskListTableViewController class to call update(withTask task: Task) instead of setting the text label directly (you will have to cast your cell to be a ButtonTableViewCell)

## Custom Protocol
Write a protocol for the ButtonTableViewCell to delegate handling a button tap to the TaskListTableViewController, adopt the protocol, and use the delegate method to mark the task as complete and reload the cell.
* Add a protocol named ButtonTableViewCellDelegate to the top of the file (outside of the class)
* Define a required buttonCellButtonTapped(_ sender: ButtonTableViewCell) function
* Add an optional delegate property on the ButtonTableViewCell
    * note: var delegate: ButtonTableViewCellDelegate?
* Update the buttonTapped IBAction to check if a delegate is assigned, and if so, call the delegate protocol function
* Conform to the protocol in the TaskListTableViewController class
* Implement the buttonCellButtonTapped delegate function to capture the Task as a property, toggle task.isComplete, and reload the tapped row. Don’t forget to set your delegate in your tableView(_:cellForRowAt:) function!
    * note: You will need to create a function in TaskController called toggleIsCompleteFor(task: Task) that toggles the isComplete Bool on the Task object passed into the function, this is how you will toggle the task.isComplete in your delegate function
At this point you should be able to run your project and toggle tasks for the mock tasks you created.

## Persistence With Core Data
Implement your function signatures in TaskController to be able to persist to Core Data. Begin by importing CoreData.
* At the end of your create, update, and toggle functions, make sure to call your CoreDatastack.saveContext() function
* Remove the line of code where you assigned your mock data to your tasks array, we will no longer be usiing teh mock data.
* Now, in order to fetch objects from your managed object context, you will need an NSFetchRequest. Create out your fetchRequest variable now. It should look something like this:
```
private lazy var fetchRequest: NSFetchRequest<Task> = {
    let request = NSFetchRequest<Task>(entityName: "Task")
    request.predicate = NSPredicate(value: true)
    return request
}()
```
* In your fetchTasks() function, call the fetch() function on your CoreDataStack, using your NSFetchRequest, and assiign the results to your tasks array.
* Update your create, update, and toggle functions, so that immediately after saving your tasks, you call your fetchTasks() function.

 Test the app and be sure to check if persistence is working. Check for and fix any bugs you might find.

## Black Diamonds
* Add the ability to delete tasks
* Add support for projects (task parent object), or tags (task child object) to categorize your tasks
* Add support for due date notifications scheduled to fire when the task is due
* Add a segmented control as the title view that toggles whether the table view should display complete or incomplete tasks
* Add a UITapGestureRecognizer to the TaskDetailTableViewController to dismiss the onscreen keyboard when the users taps somewhere on the screen.
* Add automatic resizing to the table view cell with the Notes text view

# Copyright
© DevMountain LLC, 2020. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.
