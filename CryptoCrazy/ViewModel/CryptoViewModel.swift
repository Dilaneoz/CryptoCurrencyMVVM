//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import Foundation

// view model da indirdiğimiz veriyi işleyip view da göstermeye hazır hale getiririz. her bi view ın kendi viewmodel ı olmak zorunda. bizim tek bir viewcontrollerımız var o yüzden bi viewmodel yeterli ama biz iki tane viewmodel yazıcaz. viewmodeller olabildiğince sade yazılmalı
// view içinde gösterilecek her şeyi burada hazırlayabiliriz
struct CryptoListViewModel {
    
    let cryptoCurrencyList: [CryptoCurrency] // CryptoCurrency ı dizi halinde tutan bir değişken
    
    func numberOfRowsInSection() -> Int { // bu fonksiyon kaç tane CryptoCurrency olucağını vericek böylelikle view da uğraşmıycaz. bu fonksiyonu view daki numberOfRowsInSection içinde kullanıcaz
         return self.cryptoCurrencyList.count
     }
     
     func cryptoAtIndex(_ index: Int) -> CryptoViewModel { // CryptoViewModel ile bağlantı kuruyoruz. bunu da cellForRowAt içinde kullanıcaz
         let crypto = self.cryptoCurrencyList[index]
         return CryptoViewModel(crypto)
     }
}

// extension daha önce oluşturulmuş sınıf ya da yapıya bir eklenti yapma olanağı sağlar. bunu sadece kendi oluşturduğumuz sınıflara değil herhangi bir yere yapabiliriz(swiftin kendi sınıfları dahil). örneğin stringe bile yapabiliriz. o yüzden bir CryptoListViewModel oluşturduğumuzda extensionla istediğimiz fonksiyonları oraya ekleyebiliriz
// hoca farklı kurslarda viewmodelin extensionlar ile yazılabildiğini de göstermek için örnek gösterdi burada ama kendisi extension kullanmayarak yazıyor viewmodelı
extension String {
    func printMyName() {
        print("atil")
    }
}

extension CryptoListViewModel {
  /*
    func numberOfRowsInSection() -> Int {
          return self.cryptoCurrencyList.count
      }
      
      func cryptoAtIndex(_ index: Int) -> CryptoViewModel {
          let crypto = self.cryptoCurrencyList[index]
          return CryptoViewModel(crypto)
      }
 */
    
}

struct CryptoViewModel {
    let crytpoCurrency: CryptoCurrency // CryptoCurrency objesi oluşturduk. dizi değil tekil eleman
    
    init(_ crypto: CryptoCurrency) {
        self.crytpoCurrency = crypto
    }
    
    var name: String {
        return self.crytpoCurrency.currency // bunları tanımladıktan sonra view de currency ismini ve fiyatını göster diyebiliriz
    }
    
    var price: String {
        return self.crytpoCurrency.price
    }
}

extension CryptoViewModel {
    /*
     init(_ crypto: CryptoCurrency) {
        self.crytpoCurrency = crypto
    }
     */
}

extension CryptoViewModel {
    /*
    var name: String {
          return self.crytpoCurrency.currency
      }
      
      var price: String {
          return self.crytpoCurrency.price
      }
 */
    
}

