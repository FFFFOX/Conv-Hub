//
//  ContentView.swift
//  Conv-Hub
//
//  Created by fox on 2022/7/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var covidDataManager: COVIDDataManager
    var body: some View {
        
        if covidDataManager.isNetworkOK {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("统计截至")
                        Text(covidDataManager.covidData.lastUpdateTime)
                            .font(.title2)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    
                    TotalDataItemView(
                        title: "本土现有确诊",
                        number: covidDataManager.covidData.localConfirm)
                    TotalDataItemView(
                        title: "现有确诊",
                        number: covidDataManager.covidData.nowConfirm)
                    TotalDataItemView(
                        title: "累计确诊",
                        number: covidDataManager.covidData.confirm)
                    TotalDataItemView(
                        title: "无症状感染者",
                        number: covidDataManager.covidData.noInfect)
                    TotalDataItemView(
                        title: "境外输入",
                        number: covidDataManager.covidData.importedCase)
                    TotalDataItemView(
                        title: "累计死亡",
                        number: covidDataManager.covidData.dead)
                    Spacer()
                }
                .onAppear {
                    covidDataManager.getData()
                }
                .background(.black)
                .cornerRadius(20)
            }.background(.black)
            
        } else {
            VStack {
                Text("信息获取中...")
            }
            .onAppear {
                covidDataManager.getData()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let covidDataManager = COVIDDataManager()
        ContentView()
            .environmentObject(covidDataManager)
        
    }
}

