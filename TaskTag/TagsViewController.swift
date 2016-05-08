//
//  TagsViewController.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/19/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import UIKit

class TagsViewController: UITableViewController {

   var allTags: [String]?

   var requiredTags: Set<String>?
   var optionalTags: Set<String>?

   var cellSelectionStates = [SelectionState]()

   let emptyCheckmark = UIImage(named: "emptyCheckmark")
   let filledCheckmark = UIImage(named: "filledCheckmark")

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return allTags!.count
   }

   override func tableView(tableView: UITableView,
                           cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCellWithIdentifier("TagCell", forIndexPath: indexPath)
      let tagName = allTags![indexPath.row]

      if tagName.isEmpty == false {
         cell.textLabel?.text = allTags![indexPath.row]
      } else {
         cell.textLabel?.text = "untagged"
         cell.textLabel?.textColor = UIColor.lightGrayColor()
      }

      if optionalTags!.contains(tagName) {
         cell.accessoryView = UIImageView(image: emptyCheckmark)
         cellSelectionStates.append(.Optional)
      } else if requiredTags!.contains(tagName) {
         cell.accessoryView = UIImageView(image: filledCheckmark)
         cellSelectionStates.append(.Required)
      } else {
         cellSelectionStates.append(.Omitted)
      }

      let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectTag))
      cell.addGestureRecognizer(singleTapRecognizer)

      return cell
   }

   func selectTag(sender: UITapGestureRecognizer) {
      if sender.state == .Ended {
         let tappedCell = sender.view! as! UITableViewCell
         let tappedIndexPath = tableView.indexPathForCell(tappedCell)!
         let currentState = cellSelectionStates[tappedIndexPath.row]

         switch currentState {
         case .Omitted:
            tappedCell.accessoryView = UIImageView(image: emptyCheckmark)
            cellSelectionStates[tappedIndexPath.row] = .Optional
            if tappedCell.textLabel!.text! == "untagged" {
               optionalTags!.insert("")
               requiredTags!.remove("")
            } else {
               optionalTags!.insert(tappedCell.textLabel!.text!)
               requiredTags!.remove(tappedCell.textLabel!.text!)
            }
         case .Optional:
            tappedCell.accessoryView = UIImageView(image: filledCheckmark)
            cellSelectionStates[tappedIndexPath.row] = .Required
            if tappedCell.textLabel!.text! == "untagged" {
               optionalTags!.remove("")
               requiredTags!.insert("")
            } else {
               optionalTags!.remove(tappedCell.textLabel!.text!)
               requiredTags!.insert(tappedCell.textLabel!.text!)
            }
         case .Required:
            tappedCell.accessoryView = nil
            cellSelectionStates[tappedIndexPath.row] = .Omitted
            if tappedCell.textLabel!.text! == "untagged" {
               optionalTags!.remove("")
               requiredTags!.remove("")
            } else {
               optionalTags!.remove(tappedCell.textLabel!.text!)
               requiredTags!.remove(tappedCell.textLabel!.text!)
            }
         }
      }
   }

   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // ... (nothing?)
   }

}

enum SelectionState {
   case Omitted
   case Optional
   case Required
}
