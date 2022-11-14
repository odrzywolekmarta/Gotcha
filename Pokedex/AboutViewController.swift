//
//  AboutViewController.swift
//  Gotcha
//
//  Created by Majka on 13/11/2022.
//

import UIKit

class AboutViewController: UIViewController {

    let viewModel: AboutViewModelProtocol = AboutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = UIColor(named: Constants.Colors.customBeige)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AboutViewController: AboutViewModelDelegate {
    func onDetailsModelSet() {
       
            
        }
    }

