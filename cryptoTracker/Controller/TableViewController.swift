//
//  TableViewController.swift
//  cryptoTracker
//
//  Created by Tomasz Krauzy on 17/05/2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var cryproPairs = ["ETH/USD", "BTC/USD"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newCrypto))
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryproPairs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "komorka", for: indexPath)
        cell.textLabel?.text = cryproPairs[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Funkcjonalność usuwania komorki
        if editingStyle == UITableViewCell.EditingStyle.delete {
            cryproPairs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "szczegol") as? ViewController {
            vc.pairOfCrypto = cryproPairs[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func newCrypto() {
        
        let ac = UIAlertController(title: nil, message: "Enter crypto pair:", preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self, weak ac] _ in
            
            guard let newCrypto = ac!.textFields![0].text?.uppercased() else {
                return
            }
            
            self?.cryproPairs.append(newCrypto)
            self!.tableView.reloadData()
        }))
        
        
        present(ac, animated: true, completion: nil)
    }
    
    
}
