//
//  TransactionBarChartView.swift
//  PoCCharts
//
//  Created by Guadoo on 2023/3/13.
//

import SwiftUI
import Charts

struct TransactionBarChartView: UIViewRepresentable {
    
    let entries: [BarChartDataEntry]
    let barChart = BarChartView()
    
    @Binding var selectedYear: Int
    @Binding var selectedItem: String
    
    func makeUIView(context: Context) -> Charts.BarChartView {
        barChart.delegate = context.coordinator
        return barChart
    }
    
    func updateUIView(_ uiView: Charts.BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = "Transactions"
        uiView.noDataText = "No Data"
        uiView.data = BarChartData(dataSet: dataSet)
        
        //uiView.leftAxis.enabled = false
        //formatRightAxis(rightAxis: uiView.rightAxis)
        
        uiView.rightAxis.enabled = false
        formatLeftAxis(leftAxis: uiView.leftAxis)
        
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        
        uiView.doubleTapToZoomEnabled = false
        uiView.pinchZoomEnabled = false
        formatDataSet(dataSet: dataSet)
        
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: TransactionBarChartView
        init(parent: TransactionBarChartView) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let month = WineTransaction.months[Int(entry.x)]
            let quantity = entry.y
            parent.selectedItem = "\(month) \(quantity)"
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.colors = [.red]
        dataSet.valueColors = [.red]
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
    }
    
    func formatRightAxis(rightAxis: YAxis) {
        rightAxis.labelTextColor = .red
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        rightAxis.axisMinimum = 0
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .red
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0
    }
    
    func formatXAxis(xAxis: XAxis) {
        xAxis.valueFormatter = IndexAxisValueFormatter(values: WineTransaction.months)
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .red
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = .red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
    
}

struct TranscationBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionBarChartView(entries: WineTransaction.dataEntriesForYear(2019, transactions: WineTransaction.allTransactions), selectedYear: .constant(2019), selectedItem: .constant(""))
    }
}
