//
//  EditMealsViewController.swift
//  DiaBeta
//
//  Created by Muhammad Abdul Fattah on 26/06/22.
//

import UIKit
import Photos

class EditMealsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
  var strDate: String?
  var strTime: String?
  var strDateTime: String?
  var foodDetailSegue: Food?
  
  @IBOutlet weak var cameraPreview: UIImageView!
  @IBOutlet weak var foodUI: UIView!
  @IBOutlet weak var category: UIView!
  @IBOutlet weak var dateTime: UIView!
  @IBOutlet weak var dateView: UIView!
  @IBOutlet weak var timeView: UIView!
  @IBOutlet weak var preGlucoseView: UIView!
  @IBOutlet weak var postGlucoseView: UIView!

  @IBOutlet weak var foodName: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var timePicker: UIDatePicker!
  @IBOutlet weak var preGlucoseTextField: UITextField!
  @IBOutlet weak var postGlucoseTextField: UITextField!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  @IBAction func actionText(_ sender: UITextField) {
    sender.resignFirstResponder()
  }
  
  
  var imagePickerController = UIImagePickerController()
  var picker = UIImagePickerController()
  
    override func viewDidLoad() {
    super.viewDidLoad()
    cameraPreview.image = UIImage(data: (foodDetailSegue?.photo)!as Data)
    foodName.text = foodDetailSegue?.name

    preGlucoseTextField.text = "\(Int(foodDetailSegue?.preGula ?? 0))"
    postGlucoseTextField.text = "\(Int(foodDetailSegue?.postGula ?? 0))"

    roundUIView()
    imagePickerController.delegate = self
    cameraPreview.layer.cornerRadius = 8
    cameraPreview.clipsToBounds = true
    cameraPreview.layer.borderWidth = 1
    cameraPreview.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }

//MARK: - Rounding the View
  private func roundUIView(){
    foodUI.layer.cornerRadius = 8
    category.layer.cornerRadius = 8
    dateTime.layer.cornerRadius = 8
    dateView.layer.cornerRadius = 5
    timeView.layer.cornerRadius = 5
    preGlucoseView.layer.cornerRadius = 8
    postGlucoseView.layer.cornerRadius = 8
  }
  
//MARK: - Get Date Data
  
//  func getDate(DatePicker: Date){
//    let dateFormatr = DateFormatter()
//    dateFormatr.dateFormat = "yyyy/MM/dd"
//    strDate = dateFormatr.string(from: (DatePicker))
//  }
//  func getTime(TimePicker: Date){
//    let dateFormatr2 = DateFormatter()
//    dateFormatr2.dateFormat = "HH:mm"
//    strTime = dateFormatr2.string(from: (TimePicker))
//  }

//MARK: - To Save
  @IBAction func saveAll(_ sender: Any) {
    
//    // To Gate Date and Time
//    getDate(DatePicker: datePicker.date)
//    getTime(TimePicker: timePicker.date)
//    // To Combine the String
//    strDateTime = strDate!+" "+strTime!
    
    let date = foodDetailSegue?.timestamp
    let postGulaText = Int64(postGlucoseTextField.text ?? "0") ?? 0
    DBHelper.shared.editFood(postGula: postGulaText, timestamp: (date ?? Date()))
    
    let saveButtonAlert = UIAlertController(
      title: "Good job",
      message: "Meals data complete!",
      preferredStyle: .alert)

    let saveAlertAction = UIAlertAction(
      title: "Done",
      style: .default,
      handler: {_ in self.performSegue(withIdentifier: "unwindToMeals", sender: self)})
      saveButtonAlert.addAction(saveAlertAction)
      present(saveButtonAlert, animated: true, completion: nil)
    
  }
}
