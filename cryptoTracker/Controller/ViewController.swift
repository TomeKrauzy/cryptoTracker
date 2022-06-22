//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Tomasz Krauzy on 10/03/2022.
//

import UIKit

class ViewController: UIViewController{

    
   
    var processManager = ProcessManager()
   
    @IBOutlet var rateOfExchangeLabel: UILabel!
    
    var pairOfCrypto: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateOfExchangeLabel.text = "LOADING..."
        processManager.delegate = self
        // Zaciągamy dane i wykonujemy ten request
        processManager.performhtppRequest(pairOfCrypto!)
    }
    
}

// MARK: - ProcessManagerDelegate
extension ViewController: ProcessManagerDelegate{
    func didUpdatePrice(rate: Double) {
        DispatchQueue.main.async {
            // DispatchQueue -> concurrently=jenocześnie | Objekt, który zarządza wykonywaniem tasków
            // seryjnie(1 po 2) albo jednocześnie na głównym wątku lub w tle
            // w tym przypadku zadanie będzie wykonane asynchronicznie, więc nasza apka się nie zwiesi
            // tylko będzie ładować dane w tle
            self.rateOfExchangeLabel.text = String(format: "\(self.pairOfCrypto!): %.2f", rate)
        }
    }
    
    
    
    func errorOccured(error: Error) {
        print(error)
    }
}





