//
//  TweeterHomeViewController.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD


class TweeterHomeViewController: UIViewController {
  
  @IBOutlet weak var tfInputPost: UITextField!
  
  @IBOutlet weak var lblCharCount: UILabel!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: "TweeterHomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellHome")
      tableView.register(UINib(nibName: "TweeterEmptyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellEmpty")
      
    }
  }
  
  var posts: [TweeterPost] = []
  var ref : DatabaseReference!
  var userID = ""
  var count = 0
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    SVProgressHUD.show()
    self.tableView.isHidden = true
    
    
    Auth.auth().addStateDidChangeListener() { auth, user in
      if user != nil {
        
        self.lblCharCount.text = "0/50"
        self.tfInputPost.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        self.userID = (Auth.auth().currentUser?.uid)!
        self.ref = Database.database().reference(withPath: "\(self.userID)_posts")
        self.ref.queryOrdered(byChild: "addedDate").observe(.value, with: { snapshot in
          var newPosts: [TweeterPost] = []
          self.count = 0
          for item in snapshot.children {
            let postItem = TweeterPost(snapshot: item as! DataSnapshot)
            newPosts.append(postItem)
            self.count += 1
          }
          self.posts = newPosts
          self.posts.reverse() // reverse to get the latest post to top

          SVProgressHUD.dismiss()
          self.tableView.isHidden = false
          self.tableView.reloadData()

        })
        
      }else{
        Auth.auth().signInAnonymously() { (user, error) in
          
        }
      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  // MARK: - buttons
  
  
  @IBAction func sendTapped(_ sender: Any) {
    
    if (self.tfInputPost.text?.isEmpty ?? true) {
      let alert = UIAlertController(title: "Tweeter",
                                    message: "Please write something :)",
                                    preferredStyle: .alert)
      
      
      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .default) { _ in
                                        self.tfInputPost.becomeFirstResponder()
                                        
      }
      
      alert.addAction(cancelAction)
      
      present(alert, animated: true, completion: nil)
      
      return
    }
    
    //check, split if needed then send
    let userPost = self.tfInputPost.text!
    
    var splitedPost = userPost.split()
    splitedPost.reverse()
    
    for i in (0..<splitedPost.count) {
      
      var post: String! = splitedPost[i]
      if post.characters.count > 50 {
        let alert = UIAlertController(title: "Tweeter",
                                      message: "Hey yo, please add some 'spaces' dude :)",
                                      preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        return
      }
      
      let addedTime = Date().timeIntervalSince1970
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "hh:mm:ss dd-MM-yyyy"
      
      let dateString = dateFormatter.string(from: Date())
      
      var content = ""
      if (splitedPost.count) > 1 {
        content = "\(splitedPost.count - i)/\(splitedPost.count) \(post!)"
      }else{
        content = post!
      }
      
      let postItem = TweeterPost(postContent: content, addedByUser: self.userID, addedDate: Int(addedTime), addedDateString: dateString, key: "")
      
      self.count += 1
      let keyString = "tweetPost000\(self.count)"
      
      let postItemRef = self.ref.child(keyString)
      
      
      postItemRef.setValue(postItem.toAnyObject())
    }
    
    //reset stuffs
    self.tfInputPost.text = "" // clear textfield
    self.lblCharCount.text = "0/50"
    self.lblCharCount.isHidden = true
    self.tfInputPost.resignFirstResponder()
  }
  
}

// MARK: - table

extension TweeterHomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(self.posts.count == 0) {
      return 1
    }
    return self.posts.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if (self.posts.count == 0) {
      let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellEmpty", for: indexPath) as! TweeterEmptyTableViewCell
      
      
      return cell
    }
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as! TweeterHomeTableViewCell
    
    let post : TweeterPost = self.posts[indexPath.row]
    
    cell.lblPostContent.text = post.postContent
    cell.lblDate.text = post.addedDateString
    
    return cell
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.tfInputPost.resignFirstResponder()
  }
  
}

extension TweeterHomeViewController: UITextFieldDelegate {
  
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.lblCharCount.isHidden = false
    
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.lblCharCount.isHidden = true
  }
  
  func textFieldDidChange(_ textField: UITextField) {
    self.lblCharCount.isHidden = false
    var textToDisplay = ""
    if (textField.text!.characters.count <= 50) {
      textToDisplay = "\(String(describing: textField.text!.characters.count))/50"
    }else {
      
      let splitCount: Int = textField.text!.characters.count / 50 + 1
      
      textToDisplay = "(\(splitCount))\(String(describing: textField.text!.characters.count-50*(splitCount-1)))/50"
    }
    
    
    self.lblCharCount.text = textToDisplay
    
  }
  
}

