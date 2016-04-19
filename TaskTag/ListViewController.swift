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
   var selectedTags = [String]()

   override func viewDidLoad() {
      createSampleData()
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      if tags == selectedTags {
         return tasks.count
      } else {
         var selectedTaskCount = 0
         for task in tasks {
            for tag in selectedTags {
               if task.tags.contains(tag) {
                  selectedTaskCount += 1
               }
            }
         }
         return selectedTaskCount
      }
   }

   func tableView(tableView: UITableView,
                  cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

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

   func tableView(tableView: UITableView,
                  heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

      if tasks[indexPath.row].tags.isEmpty {
         return 44.0
      } else {
         return 55.0
      }
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

      if segue.identifier == "ShowTags" {

         let tagsViewController = (segue.destinationViewController as! UINavigationController)
            .topViewController as! TagsViewController
         tagsViewController.allTags = tags
      }
   }

   @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {

      if let newTaskViewController = sender.sourceViewController as? NewTaskViewController {

         let newTask = newTaskViewController.newTask!
         let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)

         saveNewTask(newTask)
         tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
         
      } else if let tagsViewController = sender.sourceViewController as? TagsViewController {

         selectedTags = tagsViewController.selectedTags
         tableView.reloadData()
      }
   }

   func saveNewTask(task: Task) {

      tasks.append(task)
      for tag in task.tags {
         if tags.contains(tag) == false {
            tags.append(tag)
         }
      }
   }

   func createSampleData() {

      let professionalTag = "professional"
      let schoolTag = "school"
      let leisureTag = "leisure"
      tags += [professionalTag, schoolTag, leisureTag]
      selectedTags += tags

      let finishThisAppTask = Task("finish this app", withTags: [professionalTag, schoolTag])
      let finishFontTask = Task("finish font", withTags: [leisureTag])
      let eatPizzaTask = Task("eat pizza", withTags: nil)
      tasks += [finishThisAppTask, finishFontTask, eatPizzaTask]
   }
}

