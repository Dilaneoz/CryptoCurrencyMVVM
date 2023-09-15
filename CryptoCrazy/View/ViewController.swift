//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import UIKit
// burası view ımız
// mvvm bir mimari yapıdır. model-viewmodel-view. model bir struct ya da sınıfla oluşturduğumuz ve içerisinde bulunacak özellikleri verdiğimiz bir yapı. mvc den farklı olarak mvvm de araya bir katman daha geliyor (view model). view mdoel, modelle view arasında duran ve view a sadece kullanıcıya göstereceği şeyleri yapma olanağı sağlayan ve geri kalan işlemleri kendi üstüne alan bir sınıftır. bu olmasa da olurdu. ama mvvm de yazmak hem daha temiz, verimli hem de ileride test yapmak istersek daha kolay yapmamıza olanak tanır
// mvvm kullanıcının gördüğü şeyle app in business mantiğini ayırır. yani kullanıcı arayüzüyle business mantığı tamamen ayrı bi şekilde gider. örneğin internetten bir veri indirilecekse, onunla ilgili bazı işlemeler yapılacaksa, kullanıcının görmeyeceği farklı şeyleri birbirine döndürme işlemleri yapılacaksa ve bu tarz kullanıcıyı ilgilendirmeyen her şey view model ya da view model içindeki sınıflarda yapılmalıdır.
// view da ise sadece kullanıcının göreceği şeyler yapılmalıdır. model ise her yerde aynıdır değişmez

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var colorArray = [UIColor]()
    
    private var cryptoListViewModel: CryptoListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.colorArray = [ // uicolor dizisi oluşturup her seferinde bi tanesini seçmek istiyoruz
        UIColor(red: 74/255, green: 57/225, blue: 204/225, alpha: 1.0), // 74/255 bu şekilde yazarak renklerin nereye denk geliceğini seçiyoruz hoca rastgele sayı verdi. alpha transparanlık
        UIColor(red: 14/255, green: 147/225, blue: 14/225, alpha: 1.0),
        UIColor(red: 104/255, green: 57/225, blue: 54/225, alpha: 1.0),
        UIColor(red: 104/255, green: 127/225, blue: 64/225, alpha: 1.0),
        UIColor(red: 114/255, green: 57/225, blue: 204/225, alpha: 1.0),
        UIColor(red: 154/255, green: 67/225, blue: 224/225, alpha: 1.0)]
        getData()
        
    }
    
    
 private func getData() {
          
     let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")! // url yi yazdık
     
     Webservice().downloadCurrencies(url: url) { cryptos in // web servisi çağırıyoruz url yi verip. bize bir cryptos listesi vericek
         
         if let cryptos = cryptos {
             
             self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos) // yukarıda aldığımız cryptos u buradan sonra tableviewde göstericez. cryptoListViewModel a bütün kriptolardan oluşan listeyi verdik
             
             DispatchQueue.main.async { // reloadData çalıştırmak lazım tableviewda gözükmesi için, internetten indiriceğimiz için DispatchQueue ile yazmak gerek
                 self.tableView.reloadData()
             }
         }
     }
 }
    
 
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection() // viewmodel dan çağırdık. nil şeklinde yazmazsak uygulama çökebilir
 }
 
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
     
     let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
     
     cell.priceText.text = cryptoViewModel.name // viewmodel dan çağırdık
     cell.currencyText.text = cryptoViewModel.price
     cell.backgroundColor = self.colorArray[indexPath.row % 6] // sadece indexPath.row yazamıyoruz çünkü indexPath.row 6 taneden çok daha fazla şey isteyecektir ve bi yerde çökertecektir. buraya bi yerden sonra 100-1000 gibi rakamlar gelicek o yuzden ne gelirse gelsin 6ya böl ve kalanını yazdır diyoruz. böylece hiçbi zaman 5ten büyük bi rakam olmıycak

     return cell
 }
 

}

