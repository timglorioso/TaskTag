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

   var tags: Set<String> {
      var t = Set<String>()
      for task in tasks {
         t.unionInPlace(task.tags)
      }
      return t
   }

   var selectedTags = Set<String>()

   var selectedTasks: [Task] {
      var t = [Task]()
      for task in tasks {
         if selectedTags.intersect(task.tags).isEmpty == false {
            t.append(task)
         }
      }
      return t
   }

   override func viewDidLoad() {
      createSampleData()
   }

   func resetSelectedTags() {
      selectedTags = tags
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return selectedTasks.count
   }

   func tableView(tableView: UITableView,
                  cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let task = selectedTasks[indexPath.row]
      var cell: UITableViewCell

      if task.tags.isEmpty {
         cell = tableView.dequeueReusableCellWithIdentifier("NoTagsCell", forIndexPath: indexPath)
      } else {
         cell = tableView.dequeueReusableCellWithIdentifier("TagsCell", forIndexPath: indexPath)

         var tagsLabel = ""
         for tag in task.tags {
            if tag.isEmpty == false {
               tagsLabel.appendContentsOf("#" + tag + " ")
            }
         }
         cell.detailTextLabel?.text = tagsLabel
      }

      cell.textLabel?.text = task.name

      return cell
   }

   func tableView(tableView: UITableView,
                  editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
      let complete = UITableViewRowAction(style: .Normal, title: "Complete", handler: taskAction)
      complete.backgroundColor = UIColor(red: 0.05, green: 0.85, blue: 0.1, alpha: 1.0)

      let delete = UITableViewRowAction(style: .Normal, title: "Delete", handler: taskAction)
      delete.backgroundColor = UIColor.redColor()

      return [delete, complete]
   }

   func taskAction(action: UITableViewRowAction, forRowAtIndexPath indexPath: NSIndexPath) {
      let theTask = selectedTasks[indexPath.row]
      for (index, task) in tasks.enumerate() {
         if theTask === task {
            tasks.removeAtIndex(index)
         }
      }
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      if segue.identifier == "ShowTags" {

         let tagsViewController = (segue.destinationViewController as! UINavigationController)
            .topViewController as! TagsViewController
         tagsViewController.allTags = Array(tags)
         tagsViewController.selectedTags = selectedTags
      }
   }

   @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {

      if let newTaskViewController = sender.sourceViewController as? NewTaskViewController {

         let newTask = newTaskViewController.newTask!
         tasks.append(newTask)
         selectedTags.unionInPlace(newTask.tags)
         tableView.reloadData()

      } else if let tagsViewController = sender.sourceViewController as? TagsViewController {

         selectedTags = tagsViewController.selectedTags!
         tableView.reloadData()
      }
   }

   func createSampleData() {

      let professionalTag = "professional"
      let schoolTag = "school"
      let leisureTag = "leisure"

      let finishThisAppTask = Task("finish this app", withTags: [professionalTag, schoolTag])
      let finishFontTask = Task("finish font", withTags: [leisureTag])
      let eatPizzaTask = Task("eat pizza", withTags: nil)

      tasks += [finishThisAppTask, finishFontTask, eatPizzaTask]

      resetSelectedTags()
   }
}

