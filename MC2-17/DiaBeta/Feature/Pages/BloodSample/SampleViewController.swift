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
  
  lazy var lineChartView: LineChartView = {
    let chartView = LineChartView()
    chartView.backgroundColor = .white
    chartView.rightAxis.enabled = false
    
    let yAxis = chartView.leftAxis
    yAxis.labelFont = .boldSystemFont(ofSize: 12)
    yAxis.setLabelCount(10, force: false)
    yAxis.labelTextColor = .white
    yAxis.axisLineColor = .white
    yAxis.labelPosition = .outsideChart
    
    chartView.xAxis.labelPosition = .bottom
    chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
    chartView.xAxis.setLabelCount(31, force: false)
    chartView.xAxis.labelTextColor = .white
    chartView.xAxis.axisLineColor = .systemBlue
    
    
    chartView.animate(xAxisDuration: 1)
    
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
        navigationItem.title = "Glucose History"
        
    view.addSubview(lineChartView)
    lineChartView.centerInSuperview()
    lineChartView.width(to: view)
    lineChartView.heightToWidth(of: view)
    setData()
    }

  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
      print(entry)
  }
  
  func setData() {
    let set1 = LineChartDataSet(entries: yValues, label: "Glucose")
    
    set1.mode = .cubicBezier //remove sharp edge
    set1.drawCirclesEnabled = false
    set1.lineWidth = 3
    set1.setColor(.red)
    
    set1.drawHorizontalHighlightIndicatorEnabled = false
    set1.highlightColor = .blue
    
    let data = LineChartData(dataSet: set1)
    data.setDrawValues(false)
    
    lineChartView.data = data
  }
  
  let yValues: [ChartDataEntry] = [
    ChartDataEntry(x: 2.0, y: 101.0),
    ChartDataEntry(x: 3.0, y: 145.0),
    ChartDataEntry(x: 4.0, y: 120.0),
    ChartDataEntry(x: 5.0, y: 132.5),
    ChartDataEntry(x: 6.0, y: 111.0),
    ChartDataEntry(x: 7.0, y: 133.0),
    ChartDataEntry(x: 8.0, y: 120.0),
    ChartDataEntry(x: 9.0, y: 159.0),
    ChartDataEntry(x: 10.0, y: 125.0)
  ]
  
}

