//
//  Task.swift
//  TaskTag
//
//  Created by Tim Glorioso on 4/18/16.
//  Copyright © 2016 Tim Glorioso. All rights reserved.
//

import Foundation

class Task {

   var name: String
   var isComplete = false

   lazy var tags = Set<String>()

   var dueDate: NSDate?
   var priority = Priority.None
   var timeLeft: Double?

   lazy var steps = [Step]()
   var notes: String?

   init(_ name: String, withTags tags: [String]?) {
      self.name = name

      if tags != nil {
         for tag in tags! {
            self.tags.insert(tag)
         }
      } else {
         self.tags.insert("")
      }
   }

}

class Step {

   var name: String
   var isComplete = false

   init(_ name: String) {
      self.name = name
   }

}

enum Priority {
   case None
   case Low
   case Medium
   case High
}
