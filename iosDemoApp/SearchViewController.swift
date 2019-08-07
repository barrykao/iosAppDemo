//
//  SearchViewController.swift
//  iosDemoApp
//
//  Created by 高琨淯 on 2019/8/6.
//  Copyright © 2019 Kun Yu Kao. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet var searchTextField: UITextField!
    
    @IBOutlet var countTextField: UITextField!
    
    @IBOutlet var searchBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBtn.isEnabled = false
        searchTextField.delegate = self
        countTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        searchTextField.text = ""
        countTextField.text = ""
        searchBtn.backgroundColor = UIColor.lightGray
        searchBtn.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if searchTextField.text == "" || countTextField.text == ""{
            searchBtn.backgroundColor = UIColor.lightGray
            searchBtn.isEnabled = false
        }else {
            searchBtn.backgroundColor = UIColor.blue
            searchBtn.isEnabled = true
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if searchTextField.text == "" || countTextField.text == ""{
            searchBtn.backgroundColor = UIColor.lightGray
            searchBtn.isEnabled = false
        }else {
            searchBtn.backgroundColor = UIColor.blue
            searchBtn.isEnabled = true
        }
        
        
    }
    
    
    @IBAction func searchBtn(_ sender: Any) {
        
        print("123")
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchSegue" {
            
            guard let text = searchTextField.text else {return}
            
            let resultVC = segue.destination as! ResultViewController
            resultVC.text = text
            resultVC.per_page = countTextField.text
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
