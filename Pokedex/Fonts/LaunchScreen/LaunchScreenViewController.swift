//
//  LaunchScreenViewController.swift
//  Gotcha
//
//  Created by Majka on 01/01/2023.
//

import UIKit

protocol LaunchScreenViewControllerDelegate: AnyObject {
    func onAnimationFinished()
}

class LaunchScreenViewController: UIViewController {

    weak var delegate: LaunchScreenViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("Launch screen dead")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(4)
        delegate?.onAnimationFinished()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
