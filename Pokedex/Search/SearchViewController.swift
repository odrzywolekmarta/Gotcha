//
//  SearchViewController.swift
//  Gotcha
//
//  Created by Majka on 08/12/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonImage.sd_setImage(with: URL(string: "https://78.media.tumblr.com/c15b061360fa577cfa6fa1868bc45962/tumblr_o2d65b8VYl1so9b4uo1_500.gif"))
        pokemonImage.applyShadow()
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
