//
//  CryptoCurrency.swift
//  CryptoCrazy
//
//  Created by Atil Samancioglu on 19.03.2020.
//  Copyright © 2020 Atil Samancioglu. All rights reserved.
//

import Foundation

struct CryptoCurrency: Decodable { // Decodable olarak tanımlayınca aşağıdaki değişken isimlerini otomatik algılıyor swift. isimleri web servistekiyle aynı yazmak lazım
    let currency: String
    let price: String
}
