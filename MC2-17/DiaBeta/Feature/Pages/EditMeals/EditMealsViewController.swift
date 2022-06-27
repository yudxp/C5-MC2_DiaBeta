//
//  EditMealsViewController.swift
//  DiaBeta
//
//  Created by Muhammad Abdul Fattah on 26/06/22.
//

import UIKit
import Photos

class EditMealsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 
  //Var to CoreDate
//  var imageCoreData: NSData?
//  var namaCoreData: String?
//  var kategoriCoreData: [String] = []
//  var timeStampCoreData: Date?
//  var preGulaCoreData: Int64?
//  var postGulaCoreData: Int64?
//
//  // Temp Var
  var strDate: String?
  var strTime: String?
  var strDateTime: String?
//
//  //COBA POST
//  var foodlist: [Food] = []
  
  var foodDetailSegue: Food?
  
  @IBOutlet weak var cameraPreview: UIImageView!
  @IBOutlet weak var foodUI: UIView!
  @IBOutlet weak var category: UIView!
  @IBOutlet weak var dateTime: UIView!
  @IBOutlet weak var dateView: UIView!
  @IBOutlet weak var timeView: UIView!
  @IBOutlet weak var preGlucoseView: UIView!
  @IBOutlet weak var postGlucoseView: UIView!

//  var foodDetail: Food?
//  @IBOutlet weak var cameraButton: UIButton!
  @IBOutlet weak var foodName: UILabel!
//  @IBOutlet weak var foodName: UITextField!
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
    
//    cameraPreview.image = UIImage(data: (imageCoreData)!as Data)
//    foodName.text = namaCoreData
//    datePicker.date = timeStampCoreData ?? Date()
//    timePicker.date = timeStampCoreData ?? Date()
//    preGlucoseTextField.text = "\(Int64(preGulaCoreData!))"
//    postGlucoseTextField.text = "\(Int64(postGulaCoreData!))"
    

//    let categoryArray = foodDetailSegue?.category!
//    let stringFromArray = categoryArray!.joined(separator: ",")
//    let date = foodDetailSegue?.timestamp
//    let date = getDate(DatePicker: <#T##Date#>)
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    cameraPreview.image = UIImage(data: (foodDetailSegue?.photo)!as Data)
    foodName.text = foodDetailSegue?.name
//    category.text = stringFromArray
//    dateTime.text = dateFormatter.string(from: date!)
    preGlucoseTextField.text = "\(Int(foodDetailSegue?.preGula ?? 0))"
    postGlucoseTextField.text = "\(Int(foodDetailSegue?.postGula ?? 0))"
//    print("bisa sampe sini")
//    cameraPreview.image = UIImage(data: (foodDetail?.photo)!as Data)
    
    
    
//
//    let categoryArray = foodDetail?.category!
//    let stringFromArray = categoryArray!.joined(separator: ",")
//    categoryLbl.text = stringFromArray
  

    
    roundUIView()
    imagePickerController.delegate = self
    cameraPreview.layer.cornerRadius = 8
    cameraPreview.clipsToBounds = true
    cameraPreview.layer.borderWidth = 1
    cameraPreview.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    
    //Check All Permission
//    checkPermission()
    
    //To Get Rid of the Keyboard

//    postGlucoseTextField.returnKeyType = .done
//
//    foodName.delegate = self
//    self.preGlucoseTextField.delegate = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "mealsToCategory" {
//      let destination = segue.destination as! CategoryViewController
//      destination.delegate = self
//    }
//  }
//MARK: - Rounding the View
  private func roundUIView(){
    dateTime.layer.cornerRadius = 8
    dateView.layer.cornerRadius = 5
    timeView.layer.cornerRadius = 5
  }
  
//MARK: - Get Date Data
  
  func getDate(DatePicker: Date){
    let dateFormatr = DateFormatter()
    dateFormatr.dateFormat = "yyyy/MM/dd"
    strDate = dateFormatr.string(from: (DatePicker))
  }
  func getTime(TimePicker: Date){
    let dateFormatr2 = DateFormatter()
    dateFormatr2.dateFormat = "HH:mm"
    strTime = dateFormatr2.string(from: (TimePicker))
  }

//MARK: - To Save
  @IBAction func saveAll(_ sender: Any) {
    
    // To Gate Date and Time
    getDate(DatePicker: datePicker.date)
    getTime(TimePicker: timePicker.date)
    // To Combine the String
    strDateTime = strDate!+" "+strTime!
//
//    print(strDateTime!)
//
//    //To Change the Format into Date Again
//    let dateFormatter = DateFormatter()
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
////
////
//    let date = dateFormatter.date(from:strDateTime!) ?? Date()
//    print (date)
//    let date2 = date ?? Date()
//
//
//    timeStampCoreData = date2
    
    //Get Food dan input preGula
//    namaCoreData = foodName.text!
//    preGulaCoreData =  Int64(preGlucoseTextField.text!)!
//    postGulaCoreData = Int64(postGlucoseTextField.text!)!
    let date = foodDetailSegue?.timestamp
    let postGulaText = Int64(postGlucoseTextField.text ?? "0")!
    
//    let image = cameraPreview.image
//    let imageData = image?.jpegData(compressionQuality: 0.5) as? NSData

    //to Core Data
//    DBHelper.shared.createFood(timestamp: timeStampCoreData!, nama: namaCoreData!, category: kategoriCoreData, image: imageData!, preGula: preGulaCoreData!)
//    print("Ke save pre gula darah")
    DBHelper.shared.editFood(postGula: postGulaText, timestamp: date!)
//    print("Ke save post Gula darah")
    

    //to Core Data for POST MEAL
//
//    foodlist = DBHelper.shared.getAllFood()
//    print(foodlist[foodlist.count-1].category as Any)
//    DBHelper.shared.editFood(postGula: preGula, timestamp: foodlist[foodlist.count-1].timestamp)
    let saveButtonAlert = UIAlertController(
      title: "Good job",
      message: "Meals data added!",
      preferredStyle: .alert)

    let saveAlertAction = UIAlertAction(
      title: "Done",
      style: .default,
      handler: nil)
    saveButtonAlert.addAction(saveAlertAction)
    present(saveButtonAlert, animated: true, completion: nil)
    
  }
  
  
  //MARK: - ToCategory
//
//  @IBAction func tappedCategoryButton(_ sender: Any) {
//    performSegue(withIdentifier: "mealsToCategory", sender: sender)
//  }
  
  
  //MARK: - Image Input
//
//  @IBAction func tappedCameraButton(_ sender: Any) {
//    let picker = UIImagePickerController()
//    picker.sourceType = .camera
//    picker.allowsEditing = true
//    picker.delegate = self
//    present(picker, animated: true)
//
//  }
    
  //MARK: - Check All Permission
//  func checkPermission(){
//    if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
//      PHPhotoLibrary.requestAuthorization({(status: PHAuthorizationStatus) -> Void in ()
//      })
//    }
//    if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
//    } else{
//      PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
//    }
//  }
//
//  func requestAuthorizationHandler(status: PHAuthorizationStatus){
//    if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
//      print("Access granted to use Photo Library")
//    } else{
//      print("We don't have access to your Photos.")
//    }
//  }
//
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//    if picker.sourceType == .photoLibrary{
//      cameraPreview?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//      let camera = info[UIImagePickerController.InfoKey.originalImage] as? NSData
//      //to tem
//      imageCoreData = camera!
//    }
//    else{
//      cameraPreview?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//
//
//    }
//
//    picker.dismiss(animated: true, completion:nil)
//
//  }
//
//
//}

//extension EditMealsViewController: UITextFieldDelegate{
//  func textFieldShouldReturn(_ foodTextField: UITextField) -> Bool {
//    foodTextField.resignFirstResponder()
//    return true
//  }
//}
//
//extension EditMealsViewController: FoodCategoryDelegate {
//  func saveData(category: [String]) {
//          kategoriCoreData = category
////          print(kategoriCoreData)
//  }
}
