//
//  MealViewController.swift
//  DiaBeta
//
//  Created by Nikita Felicia on 22/06/22.
//

import UIKit

class MealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var foodTableView: UITableView!
    
    var selectedRow: Int = -1
    var selectedFood: Food?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DateCollectionViewCell
    
        cell2.dateButton.setTitle(dateData[indexPath.row], for: .normal)
        cell2.dateButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        
        cell2.dateButton.layer.cornerRadius = 16
        cell2.dateButton.layer.masksToBounds = true
        cell2.dateButton.layer.borderWidth = 1
        cell2.dateButton.layer.borderColor = UIColor(red: 0/255, green: 123/255, blue: 86/255, alpha: 1).cgColor
        
        
        cell2.dateButton.tag = indexPath.row
        cell2.dateButton.addTarget(self, action : #selector(buttonClicked), for: .touchUpInside)
        if(selectedRow == indexPath.row){
            cell2.dateButton.layer.backgroundColor = UIColor(red: 0/255, green: 123/255, blue: 86/255, alpha: 1).cgColor
            cell2.dateButton.setTitleColor(.white, for: .normal)
        }else{
            cell2.dateButton.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
            cell2.dateButton.setTitleColor(UIColor(red: 47/255, green: 72/255, blue: 88/255, alpha: 1), for: .normal)
        }
        
        return cell2
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        let indexpath1 = IndexPath(row: sender.tag, section: 0)
        print(dateData[indexpath1.row])
        selectedRow = indexpath1.row
        foodInfos = DBHelper.shared.getDateFood(weekDate[selectedRow])
        dateCollectionView.reloadData()
        foodTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateCollectionView.reloadData()
        foodTableView.reloadData()
      }
    
    @IBOutlet var tableView: UITableView!

  
    var weekDate:[Date]=[]
    var dateData:[String]=[]
    
    var foodInfos:[Food] = []
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getWeeks()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title : "Add",
                                                            style : .plain,
                                                            target: self,
                                                            action: #selector(self.ProfileButtonTapped(_:)))
        
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        dateFormatter.dateFormat = "HH:mm"
        foodInfos = DBHelper.shared.getDateFood(weekDate[0])
    
    }
    
     @objc func ProfileButtonTapped(_ sender:UIBarButtonItem!) {
     print("Button Tapped")
     performSegue(withIdentifier: "addMeal", sender: self)
     //If you want pass data while segue you can use prepare segue method
    }
    
  @IBAction func unwindToMeal(_ unwindSegue: UIStoryboardSegue) {
    let sourceViewController = unwindSegue.source
    // Use data from the view controller which initiated the unwind segue
  }

  
    func getWeeks() {
        let dateCur = Date()
        dateFormatter.dateFormat = "MMM d, yyyy"
        var i = 0
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        while (i != -7){
            let datetoAdd = calendar.date(byAdding: .day, value: i, to: dateCur)
            weekDate.append(datetoAdd!)
            print(datetoAdd!)
            let dateString = dateFormatter.string(from: datetoAdd!)
            if(i == 0){
                dateData.append("Today")
            } else {
                dateData.append(dateString)
            }
            print(dateString)
            i-=1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFood = foodInfos[indexPath.row]
        performSegue(withIdentifier: "foodDetail", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        let selisih = foodInfos[indexPath.row].postGula - foodInfos[indexPath.row].preGula
        let category = foodInfos[indexPath.row].category?.joined(separator: ", ")
        let rowDate = dateFormatter.string(from: (foodInfos[indexPath.row].timestamp! as Date))
        cell.myLabel.text = "+ \(selisih)"
        if (foodInfos[indexPath.row].postGula == 0){
            cell.myLabel1.layer.opacity = 1
            cell.myLabel.layer.opacity = 0
        } else{
            cell.myLabel1.layer.opacity = 0
            cell.myLabel.layer.opacity = 1
        }
        if (selisih>=30){
            cell.myLabel.backgroundColor = UIColor.red
        } else {
            cell.myLabel.backgroundColor = UIColor.green
        }
        cell.myLabel2.text = foodInfos[indexPath.row].name
        cell.myLabel3.text = category
        cell.myLabel4.text = rowDate
        cell.myImageView.image = UIImage(data: (foodInfos[indexPath.row].photo)!as Data)
        cell.myImageView.contentMode = .scaleAspectFill
        cell.myImageView.layer.masksToBounds = true
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "foodDetail" {
        let foodDetailVC = segue.destination as! FoodViewController
        foodDetailVC.foodDetail = selectedFood //sesuain sama cell
      }
      else if segue.identifier == "addMeal" {
        print("addMeal")
      }

    }
    
    
}
