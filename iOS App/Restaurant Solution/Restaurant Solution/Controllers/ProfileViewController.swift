//
//  ProfileViewController.swift
//  Restaurant Solution
//
//  Created by Scott McKenzie on 2/17/17.
//  Copyright © 2017 Danny Harding. All rights reserved.
//

import UIKit
import Malert

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    let mainUser = User.sharedInstance
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var myNavBar: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let picker = UIImagePickerController()

    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
    
    func photoFromLibrary() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }

    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
    }
    
    func shootPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    var pickOption = ["Male", "Female"]
    
    
    override func viewDidLoad()
    {
        print("viewDidLoad")
        super.viewDidLoad()
    
        picker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.imageTapped(gesture:)))
        
        // add it to the image view;
        profileImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        profileImage.isUserInteractionEnabled = true
        
        //Make a round image for the profile picture
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        
        //Set the info based on the logged in user
//        self.profileImage.image = mainUser.profilePicture
        self.fullName.text = mainUser.firstName + " " + mainUser.lastName
        self.phoneNumber.text = mainUser.phoneNumber
        self.emailAddress.text = mainUser.email
        self.birthday.text = mainUser.birthday
        self.gender.text = mainUser.gender
        
        birthday.delegate = self
        
        var pickerView = UIPickerView()
        pickerView.delegate = self
        gender.inputView = pickerView
        
        //Set up the log out button
        logout.addTarget(self, action:#selector(self.logoutClick), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector("doneButtonAction"))
        //array of BarButtonItems
        var arr = [UIBarButtonItem]()
        arr.append(flexSpace)
        arr.append(doneBtn)
        toolbar.setItems(arr, animated: false)
        toolbar.sizeToFit()
        self.phoneNumber.inputAccessoryView = toolbar
        self.emailAddress.inputAccessoryView = toolbar
        self.birthday.inputAccessoryView = toolbar
        self.gender.inputAccessoryView = toolbar
        
    }
    
    func goBack() {
        print("Go Back Pressed")
    }
    
    
    func saveData() {
        print("Save Button Pressed")
//        saveData()
    }
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickOption[row])
        self.gender.text = pickOption[row]
    }
    
    
    // MARK: TextField Delegate
    func datePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        birthday.text = dateFormatter.string(from: sender.date)

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = datePicker
        
        let genderPickerView = UIPickerView()
        gender.inputView = genderPickerView
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        birthday.resignFirstResponder()
        return true
    }
    
    // MARK: Helper Methods
    func closekeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closekeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            navigationItem.title = "Your Profile"
    }
    
    func doneButtonAction(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.emailAddress.resignFirstResponder()
        self.birthday.resignFirstResponder()
        self.gender.resignFirstResponder()
        return true
    }
    
    func logoutClick()
    {
        print("Log out button clicked")
        //Clear out the stored user and logout
        clearMainUserData()
    }
    
    func xClick()
    {
        print("x button clicked")
        self.dismiss(animated: true, completion: nil);
    }
    
    func clearMainUserData()
    {
        print("Clearing out the main user data")
        //Clear out the stored user and logout
        mainUser.firstName = ""
        mainUser.lastName = ""
        mainUser.email = ""
        mainUser.birthday = ""
        mainUser.phoneNumber = ""
        mainUser.gender = ""
        mainUser.username = ""
    }
    
    func updateMainUserData()
    {
        print("Clearing out the main user data")
        //Clear out the stored user and logout
        mainUser.email = emailAddress.text!
        mainUser.birthday = birthday.text!
        mainUser.phoneNumber = phoneNumber.text!
        mainUser.gender = gender.text!
        
        //TODO Push this data to the database
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //*** MAKE SURE THIS IS GARBAGE AND REMOVE ***
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Got It!")
        if textField == phoneNumber {
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = (newString as NSString).components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
            
        } else {
            return true
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profileImage.contentMode = .scaleAspectFit //3
        profileImage.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Create Buttons
            let button1 = MalertButtonStruct(title: "Camera") {
                //Do something when click at button
                MalertManager.shared.dismiss()
                self.shootPhoto()
                
            }
            
            //Create Buttons
            let button2 = MalertButtonStruct(title: "Library") {
                //Do something when click at button
                MalertManager.shared.dismiss()
                self.photoFromLibrary()
            }
            
            let button3 = MalertButtonStruct(title: "Cancel") {
                //Do something when click at button
                MalertManager.shared.dismiss()
            }
            
            //Create Malert with title, custom view, buttons and animation type
            //Create Malert with custom view, buttons and animation type
            MalertManager.shared.show(customView: ProfileSourcePickerView.instantiateFromNib(),
                                      buttons: [button1, button2, button3],
                                      animationType: .modalLeft)
            
        }
    }
    
}
