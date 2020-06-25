//
//  SignUpViewController.swift
//  test-app
//
//  Created by Juan Ortiz on 17-06-20.
//  Copyright © 2020 Juan Ortiz. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var SignUP: UIButton!
    
    @IBOutlet weak var Error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
       
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        Error.alpha = 0
        Utilities.styleTextField(FirstName)
        Utilities.styleTextField(LastName)
        Utilities.styleTextField(Email)
        Utilities.styleTextField(Password)
        Utilities.styleFilledButton(SignUP)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func validateFields() -> String? {
        if  FirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            LastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Email.text?.trimmingCharacters(in:    .whitespacesAndNewlines) == "" ||
            Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill the field"
        }
        
        let cleanedPassword = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "The password is insecured, at least 8charecter need it"
        }
        
        return nil
    }
    @IBAction func SignUpTapped(_ sender: Any) {
        
        
        let firstName = FirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = LastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let mail = Email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        //validar datos
        let error = validateFields()
        if error != nil {
            showError(error!)
        }else{
            Auth.auth().createUser(withEmail: mail, password: pass) { (result, err) in
                
                if err != nil{
                    
                    self.showError("Erro creating user")
                    
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["Firstname": firstName,"Lastname": lastName,"uid":result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("error saving data")
                        }
                    }
                    self.TransitionToHome()
                }
            }
        }
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
