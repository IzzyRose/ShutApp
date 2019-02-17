//
//  ViewController.swift
//  ShutApp
//
//  Created by Isabelle Greenberg on 2/16/19.
//  Copyright © 2019 Isabelle Greenberg. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var decibelLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var room: UIPickerView!
    @IBOutlet weak var text: UITextField!
    @IBAction func hushButton(_ sender: Any) {
        let alert = UIAlertController(title: "Thank you for alerting!", message: "You have warned the room in the center about their noise.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Huzzah", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    //var postKey: String?
    
    
    var colors: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref:DatabaseReference!
        ref = Database.database().reference(fromURL: "https://shutapp-cewit.firebaseio.com/");
        //ref.observe(, with: 
        var level = 5.0;
        //var backend = FirebaseApp.app(name: "ShutApp");
        //print(ref.didChangeValue(forKey: "Sound"))
        
        var refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            var fireData = snapshot.value as? Int
        });
        
        //refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
          //  let postDict = snapshot.value as? [String : AnyObject] ?? [:]
        //})
        
        
        //algo from firedata to level
        
        
        //backend?.dictionaryWithValues(forKeys: [Room]);
        //print(backend);
                decibelLabel.text = String(level)
                if level >= 6 {
                    decibelLabel.center.x-=6;
                    
                }
                if level >= 16 {
                    decibelLabel.textColor = UIColor.red;
                    
                }
                else if level >= 12 {
                    decibelLabel.textColor = UIColor.yellow;
                }
                else {
                    decibelLabel.textColor = UIColor.green;
                }
        
        self.room.delegate = self
        self.room.dataSource = self
        self.text.delegate = self
        colors = ["A101","A103","B102","B104"]
    
//        add.frame = CGRect(x: 155, y: 590, width: 55, height: 55)
//        add.layer.cornerRadius = 0.5 * add.bounds.size.width
//        add.clipsToBounds = true
//        add.backgroundColor = .cyan
//        add.setTitle("+", for: .normal)
//        //add.addTarget(self, action: #selector(addAction), for: .touchUpInside)
//
//        //text.addTarget(self, action: #selector(addAction), for: UIControlEvents.touchDown)
//
//        self.view.addSubview(add)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func input() -> String {
        var keyboard = FileHandle.standardInput
        var inputData = keyboard.availableData
        return NSString(data: inputData, encoding:String.Encoding.utf8.rawValue)! as String
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.3
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont (name: "Helvetica Neue", size: 35)
        label.text =  colors[row]
        label.textAlignment = .center
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
//    @objc func addAction(sender: UIButton!) {
//        print("Button tapped")
//        //colors.append("C201");
//        //super.viewDidLoad();
//        textFieldShouldReturn(text)
//        //colors.append(input())
//        self.room.dataSource = self
//        //text.resignFirstResponder()
//    }
    
    //Notification Feedback Generator
    //func notificationOccurred(_: UINotificationFeedbackGenerator.FeedbackType) {
        
    //}
    
    //MFMessageComposeViewController

    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print(text.canResignFirstResponder)
        text.resignFirstResponder()
        colors.append(text.text!)
        self.room.dataSource = self
        text.text = ""
        return true
    }
    
}

