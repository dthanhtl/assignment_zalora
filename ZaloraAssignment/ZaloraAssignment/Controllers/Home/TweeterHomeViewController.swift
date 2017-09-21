//
//  TweeterHomeViewController.swift
//  ZaloraAssignment
//
//  Created by Thanh Tran on 9/21/17.
//  Copyright © 2017 Thanh. All rights reserved.
//

import UIKit

class TweeterHomeViewController: UIViewController {
  
  @IBOutlet weak var tfInputPost: UITextField!
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: "TweeterHomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellHome")
      
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
  }
  
  

}

extension TweeterHomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as! TweeterHomeTableViewCell
    cell.lblPostContent.text = "my life is suck as fuck "

    return cell
  }
  
  
}
