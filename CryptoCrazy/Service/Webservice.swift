//
//  Webservice.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import Foundation

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping ([CryptoCurrency]?) -> ()) { // sonunda download edilip veri geldiğinde bu fonksiyonla o veriyi döndürebilir hale getiricez. önce url isteyip nerden indiriceğimizi soruyoruz. sonra bize bi completion blok veriyor. @escaping fonksiyon tamamlandıktan/döndürüldükten sonra çağırılan ve argüman yollayabildiğimiz bir fonksiyon. yani tamamlanmasını bekliyorsak ve sonunda bi şey döndürmek istiyorsak kullanabiliriz. örneğin internetten bi veri indiricez ve indirdikten sonra sonucunu döndürüceğimiz bir işlem yapıcaksak, bunu kendimiz döndürmek istiyorsak @escaping i kullanmak mantıklıdır. [CryptoCurrency] bu döndürmek istediğimiz data, dizi olucağı için dizi içinde yazıyoruz. () bu kısımda void döndürüceğimizi söylüyoruz. indiriceğimiz data bir adet CryptoCurrency den oluşsaydı dizi içinde yazmaya gerek yoktu. optinal(?) yapıyoruz çünkü internetten gelen verilerde ne olucağı belli olmaz internet kesilir vs.
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) // completion içine ne vericeğimizi yazıyoruz. yani bir hata varsa data yok CryptoCurrency dizisi gelmedi diyoruz
            } else if let data = data { // burda datayı aldıktan sonra direkt o datayı verebiliriz
                
                let crytpoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data) // datayı alıyoruz. JSONDecoder json formatındaki bi veriyi işlememize decode etmemize ve veriye dönüştürmemize yardımcı olan sınıftır. JSONDecoder().decode bize bir decodable soruyor. hangi decodable ı datayı kullanıcaz diyo ve bir şey throws ediyor(hata veriyor). throws ediceği için try içinde yazıyoruz
                print(crytpoList)
                
                if let cryptoList = crytpoList { // if let le optional dan çıkarıyoruz
                    completion(crytpoList)
                }
            }
        }.resume() // işlemi başlatmamızı sağlıyor
    }
}
