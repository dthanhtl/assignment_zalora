//
//  TweeterBusiness.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import Foundation

class TweeterBusiness: NSObject {

  
  
}

extension String {
  
  func split() -> [String] {
  
    var splitedStrings : [String] = self.components(separatedBy: " ")
    var charCount = 0
    var currentString = ""
    var splitedAndJoinedStrings : [String]! = [String]()
    
    
    for i in 0 ..< splitedStrings.count {
      var tempString = splitedStrings[i]
      
      charCount = charCount + tempString.characters.count
      
      if charCount < 50 {
        if i == 0 {
          currentString.append("\(tempString)")
        }else{
          currentString.append(" \(tempString)")
          charCount = charCount + 1
        }
      }else{
        splitedAndJoinedStrings.append(currentString)
        currentString = tempString
        charCount = currentString.characters.count
       // added = true
      }
    }
    
    splitedAndJoinedStrings.append(currentString)
    
    
    return splitedAndJoinedStrings
  }
  
}
