//
//  AppData.swift
//  TestApp
//
//  Created by Nikita Kurochka on 25.05.2022.
//

import UIKit

class AppData: NSObject {

    fileprivate override init() {
            super.init()
            
        if !UserDefaults.standard.bool(forKey: "isDataLoaded"){
            defaultLoad()
            UserDefaults.standard.set(true, forKey: "isDataLoaded")
        }   else {
            loadData()
        }
        
        }

    var pidorsArray: [PidorItem] = []
    var photosArray: [Photoitem] = []
    var defaultData: UserDefaults = UserDefaults.standard
    func saveValue(value: Any, forKey: String){
        defaultData.set(value, forKey: forKey)
    }
    
    func readValue(forKey: String!)-> Int {
        
//            print( defaultData.value(forKey: forKey)! )
        return defaultData.value(forKey: forKey) as? Int ?? 0
       
    }
    func allTaps ()-> Int{
        let allTaps = readValue(forKey: "yesCounter") + readValue(forKey: "noCounter")
        
        return allTaps
    }
    func countPercent (forKey: String! ) -> Float {
        let drop = Float(readValue(forKey: forKey))
        let allTaps = Float(allTaps())
        let percent = Float(drop / allTaps)
        return Float(percent)
    }
    
    
    func loadData() {
        let decoder = JSONDecoder()
        do {
            pidorsArray =  try! decoder.decode([PidorItem].self, from: UserDefaults.standard.data(forKey: "PidorsData")!)
            print(pidorsArray)
        
        } catch {
            
        }

    }
    
    
    func defaultLoad() {
        let imagesArray = ["kurka","den","SANYA","vetas","vadim","roman","glebas","tysovka","tysovka_2","sanya_chil","den_finish", "vetal"]
        let textArray = ["Це Курка и він кусок придурка","Це Ден і він щось з чимось","Це саня і тут усе зрозуміло","Це Віталик вин як би рогалик і як би ні","Це Вадим з усіх бовдурив він такий один","Це Рома і він шукає тепло у цьому світі","Це Глебас шукає дивний напас","І вони завжді тусують разом колі є час де завгодно у квартіри","Або на дачі Вадима","Після такіх тусовок хтось випочіває так","Або так","Чи становляться такими як він"]
        let colorsArray: [UIColor] = [UIColor.green, UIColor.brown, UIColor.yellow, UIColor.purple,UIColor.green, UIColor.brown, UIColor.yellow, UIColor.purple,UIColor.green, UIColor.brown, UIColor.yellow, UIColor.purple]
    
        for (i,image) in imagesArray.enumerated() {
            let pidor = PidorItem()
            if i == 5{
                let img = UIImage(named: "roman")
                print(img)
            }
            pidor.image = UIImage(named: image)?.jpegData(compressionQuality: 0.5)
            pidor.text = textArray[i]
            pidor.color = colorsArray[i].encode()
            pidorsArray.append(pidor)
        }
        
        saveData()
    }
    
    func saveData() {
        let encoder = JSONEncoder()

            if let data = try? encoder.encode(pidorsArray) {
                UserDefaults.standard.set(data, forKey: "PidorsData")
            }
    }
    
    
        static let shared: AppData = AppData()

    
}
