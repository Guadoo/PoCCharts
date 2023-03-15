//
//  BarChartView.swift
//  PoCCharts
//
//  Created by Guadoo on 2023/3/13.
//
import Charts
import SwiftUI

struct ShowBarChartView: View {
    
    @State private var selectedYear: Int = 2019
    @State private var barEntires: [BarChartDataEntry] = []
    @State private var selectedItem = ""
    
    var body: some View {
        VStack {
            Text("\(selectedYear)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            
            Button("Change Year") {
                if selectedYear == 2019 {
                    selectedYear = 2020
                } else {
                    selectedYear = 2019
                }
            }
            
            TransactionBarChartView(entries: WineTransaction.dataEntriesForYear(selectedYear, transactions: WineTransaction.allTransactions), selectedYear: $selectedYear, selectedItem: $selectedItem)
            Text(selectedItem)
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        ShowBarChartView()
    }
}
