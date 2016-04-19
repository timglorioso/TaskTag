//
//  ListViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var tableView: UITableView!

   var tasks = [Task]()
   var tags = [String]()

   override func viewDidLoad() {
      createSampleData()
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tasks.count
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let task = tasks[indexPath.row]
      var cell: UITableViewCell

      if task.tags.isEmpty {
         cell = tableView.dequeueReusableCellWithIdentifier("NoTagsCell", forIndexPath: indexPath)
      } else {
         cell = tableView.dequeueReusableCellWithIdentifier("TagsCell", forIndexPath: indexPath)

         var tagsLabel = ""
         for tag in task.tags {
            tagsLabel.appendContentsOf("#" + tag + " ")
         }
         cell.detailTextLabel?.text = tagsLabel
      }

      cell.textLabel?.text = task.name

      return cell
   }

   @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {

      if let newTaskViewController = sender.sourceViewController as? NewTaskViewController {

         let newTask = newTaskViewController.newTask!
         let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)

         tasks.append(newTask)
         tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
      }
   }

   func createSampleData() {

      let professionalTag = "professional"
      let schoolTag = "school"
      let leisureTag = "leisure"
      tags += [professionalTag, schoolTag, leisureTag]

      let finishThisAppTask = Task("finish this app", withTags: [professionalTag, schoolTag])
      let finishFontTask = Task("finish font", withTags: [leisureTag])
      let eatPizzaTask = Task("eat pizza", withTags: nil)
      tasks += [finishThisAppTask, finishFontTask, eatPizzaTask]
   }
}

