//
//  BaseViewController.swift
//  POKEAPP
//
//  Created by Phincon on 23/08/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(with alerts: AlertError){
        let alert = UIAlertController(title: alerts.title, message: alerts.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alerts.action.title, style: .default, handler: { _ in
            alerts.action.handle?()
        }))
        present(alert, animated: true, completion: nil)
    }

}
