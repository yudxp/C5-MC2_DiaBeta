//
//  SampleViewController.swift
//  DiaBeta
//
//  Created by Yudha Hamdi Arzi on 20/06/22.
//

import UIKit
import Charts
import TinyConstraints

class SampleViewController: UIViewController, ChartViewDelegate {
  @IBOutlet weak var dailyLabel: UILabel!
  @IBOutlet weak var weeklyLabel: UILabel!
  @IBOutlet weak var monthlyLabel: UILabel!
  @IBOutlet weak var higheshContainer: UIView!
  @IBOutlet weak var lowestContainer: UIView!
  @IBOutlet weak var highGlucoseValue: UILabel!
  @IBOutlet weak var lowGlucoseValue: UILabel!
  
  private var allGlucoseValue: [GulaDarah] = []
  var circleColor = [NSUIColor]()
  
  func colorPicker(value : Double) -> NSUIColor {
    if value > 130 {
      return NSUIColor.red
    }
    else if value >= 70 && value <= 130 {
      return NSUIColor.green
    }
    else {
      return NSUIColor.black
    }
  }
  
    lazy var scatterChartView: ScatterChartView = {
    let chartView = ScatterChartView()
      chartView.backgroundColor = .white
      chartView.rightAxis.enabled = false
    let yAxis = chartView.leftAxis
      yAxis.labelFont = .boldSystemFont(ofSize: 12)
      yAxis.setLabelCount(10, force: false)
      yAxis.labelTextColor = .black
      yAxis.axisLineColor = .black
      yAxis.labelPosition = .outsideChart
      yAxis.drawGridLinesEnabled = true
      let floatValue: [CGFloat] = [1,25]
      yAxis.gridLineDashPhase = CGFloat(0.2)
      yAxis.gridLineDashLengths = floatValue
      yAxis.gridLineWidth = CGFloat(1.5)
    let botAxis = chartView.xAxis
      botAxis.labelPosition = .bottom
      botAxis.labelFont = .boldSystemFont(ofSize: 12)
      botAxis.setLabelCount(5, force: false)
      botAxis.labelTextColor = .black
      botAxis.axisLineColor = .black
      botAxis.drawGridLinesEnabled = false
    //x axis lookslike integer
    chartView.xAxis.granularityEnabled = true
    chartView.xAxis.granularity = 1.0
    
    return chartView
  }()
  
  override func viewDidLoad() {
        super.viewDidLoad()
        dailyLabel.layer.cornerRadius = 20
        dailyLabel.clipsToBounds = true
        weeklyLabel.layer.cornerRadius = 20
        weeklyLabel.clipsToBounds = true
        monthlyLabel.layer.cornerRadius = 20
        monthlyLabel.clipsToBounds = true
        higheshContainer.layer.cornerRadius = 12
        lowestContainer.layer.cornerRadius = 12
        let maxGlucoseData:GulaDarah = DBHelper.shared.getHighest()
        let minGlucoseData:GulaDarah = DBHelper.shared.getLowest()
        readWeekGlucose()
        highGlucoseValue.text = String(maxGlucoseData.jumlah)
        lowGlucoseValue.text = String(minGlucoseData.jumlah)
        navigationItem.title = "Glucose History"
        
    view.addSubview(scatterChartView)
    scatterChartView.centerInSuperview(offset: CGPoint(x: 0, y: 80), priority: .required, isActive: true , usingSafeArea: false)
    scatterChartView.width(to: view)
    scatterChartView.heightToWidth(of: view)
    scatterChartView.legend.enabled = false
    setData()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    readWeekGlucose()
  }

  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
      print(entry)
  }
  
  func setData() {

    let set1 = ScatterChartDataSet(entries: yValue, label: "Glucose level")
    set1.colors = valueColor
    set1.shapeRenderer = CircleShapeRenderer()
    
    set1.drawHorizontalHighlightIndicatorEnabled = false
    set1.highlightColor = .blue
    
    let data = ScatterChartData(dataSet: set1)
    data.setDrawValues(false)
    
    scatterChartView.data = data
  }
  
  var yValue: [ChartDataEntry] = []
  var valueColor = [NSUIColor]()
  
  func readWeekGlucose() {
    allGlucoseValue = DBHelper.shared.getWeekGula(Date())
    
    for (index, _) in allGlucoseValue.enumerated() {
      let dateFormatter = DateFormatter()
      let date = allGlucoseValue[index].timestamp!
      dateFormatter.dateFormat = "dd"
      let dateResult = dateFormatter.string(from: date)
      let tempData = ChartDataEntry(x: Double(dateResult)!, y: Double(allGlucoseValue[index].jumlah))
      valueColor.append(colorPicker(value: Double(allGlucoseValue[index].jumlah)))
      yValue.append(tempData)
    }
  }
  
  
}

