//
//  ConvController.swift
//  Conv-Hub
//
//  Created by fox on 2022/7/22.
//

import Foundation

class COVIDDataManager: ObservableObject {
    @Published var isNetworkOK = false
    @Published var covidData = ConvData()
    
    func getData() {
        let urlStr = "https://api.inews.qq.com/newsqa/v1/query/inner/publish/modules/list?modules=statisGradeCityDetail,diseaseh5Shelf"
        // 生成URL对象
        let url: URL = URL(string: urlStr)!
        // 创建网络请求
        let request: URLRequest = URLRequest(url: url)
        let session: URLSession = URLSession.shared
        let dataTask: URLSessionTask = session.dataTask(with: request) { (data, resopnse, error) in
            do {
                // 获取网络数据
                guard let data = data else {
                    print("获取失败，请检查网络")
                    DispatchQueue.main.async {
                        self.isNetworkOK = false
                    }
                    return
                }
                // 将数据序列化为JSON数据
                guard let jsonDic = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary else {
                    print("数据序列化为 JSON 失败")
                    return
                }
                guard let dataDic = jsonDic["data"] as? [String: Any] else {
                    print("data 字段序列化为 JSON 失败")
                    return
                }
                guard let diseaseh5ShelfDic = dataDic["diseaseh5Shelf"] as? [String: Any] else {
                    print("diseaseh5Shelf 字段序列化为 JSON 失败")
                    return
                }
                // 更新时间
                guard let lastUpdateTime = diseaseh5ShelfDic["lastUpdateTime"] as? NSString else {
                    print("获取更新时间失败")
                    return
                }
                // 国内疫情总况
                guard let chinaTotalDic = diseaseh5ShelfDic["chinaTotal"] as? [String: Any] else {
                    print("chinaTotal 字段序列化为 JSON 失败")
                    return
                }
                guard let localConfirm = chinaTotalDic["localConfirm"] as? NSNumber else {
                    print("localConfirm 序列化失败")
                    return
                }
                guard let nowConfirm = chinaTotalDic["nowConfirm"] as? NSNumber else {
                    print("nowConfirm 序列化失败")
                    return
                }
                guard let confirm = chinaTotalDic["confirm"] as? NSNumber else {
                    print("confirm 序列化失败")
                    return
                }
                guard let noInfect = chinaTotalDic["noInfect"] as? NSNumber else {
                    print("noInfect 序列化失败")
                    return
                }
                guard let importedCase = chinaTotalDic["importedCase"] as? NSNumber else {
                    print("importedCase 序列化失败")
                    return
                }
                guard let dead = chinaTotalDic["dead"] as? NSNumber else {
                    print("dead 序列化失败")
                    return
                }
                DispatchQueue.main.async {
                    self.covidData.lastUpdateTime = String(lastUpdateTime)
                    self.covidData.localConfirm = Int(truncating: localConfirm)
                    self.covidData.nowConfirm = Int(truncating: nowConfirm)
                    self.covidData.confirm = Int(truncating: confirm)
                    self.covidData.noInfect = Int(truncating: noInfect)
                    self.covidData.importedCase = Int(truncating: importedCase)
                    self.covidData.dead = Int(truncating: dead)
                    self.isNetworkOK = true
                }
            } catch {
                print("气温获取失败")
                DispatchQueue.main.async {
                    self.isNetworkOK = false
                }
            }
        }
        // 如果任务暂停，重新开始
        dataTask.resume()
    }
}

