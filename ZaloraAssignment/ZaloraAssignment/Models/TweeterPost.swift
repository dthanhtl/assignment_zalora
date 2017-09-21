//
//  TweeterPosts.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct TweeterPost {
  
  let key: String
  let postContent: String
  let addedByUser: String
  let ref: DatabaseReference?
  let addedDate: Int
  let addedDateString: String
  
  init(postContent: String, addedByUser: String, addedDate: Int, addedDateString: String, key: String = "") {
    self.key = key
    self.postContent = postContent
    self.addedByUser = addedByUser
    self.addedDate = addedDate
    self.addedDateString = addedDateString
    self.ref = nil
  }
  
  init(snapshot: DataSnapshot) {
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    postContent = snapshotValue["postContent"] as! String
    addedByUser = snapshotValue["addedByUser"] as! String
    addedDate = snapshotValue["addedDate"] as! Int
    addedDateString = snapshotValue["addedDateString"] as! String
    ref = snapshot.ref
  }
  
  func toAnyObject() -> Any {
    return [
      "postContent": postContent,
      "addedByUser": addedByUser,
      "addedDate": addedDate,
      "addedDateString": addedDateString
    ]
  }
  
}
