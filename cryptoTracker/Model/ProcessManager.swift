//
//  ProcessManager.swift
//  cryptoTracker
//
//  Created by Tomasz Krauzy on 17/03/2022.
//

import Foundation


// W tym pliku jest cała logika pobierania i przetwarzania danych

protocol ProcessManagerDelegate {
    func didUpdatePrice(rate: Double)
    func errorOccured(error: Error)
}



struct ProcessManager {
    // Z Coin API
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as! String
    
    var delegate: ProcessManagerDelegate?
    
    func performhtppRequest(_ for_crypto: String){
        
     
        let urlString = "https://rest.coinapi.io/v1/exchangerate/\(for_crypto)?apikey=\(apiKey)"
        print(urlString)
    
        if let goodURL = URL(string: urlString) {
            // tworzymy sesje z frameworku URLSession
            let session = URLSession(configuration: .default)
    
            let task = session.dataTask(with: goodURL) { dane, response, error in
                if error != nil {
                    self.delegate?.errorOccured(error: error!)
                    return
                }
                
                // mamy dane ale musimy je jeszcze zdekodować
                if let rate = decodeJSON(downloadedData: dane!) {
                    // w tym momenie już menager zrobił swoje, i teraz już reszta po stronie
                    // uzytwkonika, który będzie musiał sobie zdefiniować tą funkcję
                    self.delegate?.didUpdatePrice(rate: rate)
                }
            }
            
            // Ta linia kodu jest ważna, bo uruchamia pobieranie
            task.resume()
            
        }
    }
    
    
    // Funkcja, która będzie dekodowała JSON i zwracała Double, który będzie można potem zapisać
    func decodeJSON(downloadedData: Data) -> Double? {
        // może zwrócić error więc musi być blok do
        do {
            let decodedData = try JSONDecoder().decode(CryptoRate.self, from: downloadedData)
            return decodedData.rate
        }catch {
            print(error)
            return nil
        }
    }
    
    
    
    
    
}






