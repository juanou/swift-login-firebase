//
//  HomeViewController.swift
//  test-app
//
//  Created by Juan Ortiz on 17-06-20.
//  Copyright © 2020 Juan Ortiz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var Callapi: UIButton!
    
    let animalArray = ["Cat","Dog","Snape"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func callapi(_ sender: Any) {
        CallAPI()
    }
    
    func numberOfSections(in tableView: UITableView)-> Int {
        return 1
    }

    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return animalArray.count
    }

    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Mycell", for: indexPath)
        cell.textLabel?.text = animalArray[indexPath.row]
        return cell
    }
    
}



func CallAPI(){
    //create the url with NSURL
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")! //change the url

    //create the session object
    let session = URLSession.shared

    //now create the URLRequest object using the url object
    let request = URLRequest(url: url)

    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

        guard error == nil else {
            return
        }

        guard let data = data else {
            return
        }

       do {
          //create json object from data
          if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
             print(json)
          }
       } catch let error {
         print(error.localizedDescription)
       }
    })

    task.resume()
}
