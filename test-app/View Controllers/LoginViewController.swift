//
//  LoginViewController.swift
//  test-app
//
//  Created by Juan Ortiz on 17-06-20.
//  Copyright © 2020 Juan Ortiz. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var Login: UIButton!
    
    @IBOutlet weak var Error: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        Error.alpha = 0
       
        Utilities.styleTextField(Email)
        Utilities.styleTextField(Password)
        Utilities.styleFilledButton(Login)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func LoginTapped(_ sender: Any) {
        //self.TransitionToHome()        //validar datos
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else{
            let mail = Email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: mail, password: pass) { (result,error) in
              
                if error != nil {
                    self.Error.text = error!.localizedDescription
                    self.Error.alpha = 1
                }
                else{
                    self.TransitionToHome()
                }
            }
        }
        
        
    }
    
    func validateFields() -> String? {
          if  Email.text?.trimmingCharacters(in:    .whitespacesAndNewlines) == "" ||
              Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
              return "Please fill the field"
          }
          return nil
      }
    func showError(_ message:String){
            Error.text = message
            Error.alpha = 1
        }
         
     func TransitionToHome(){
         
         let homeViewController =
             storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
     }
}
