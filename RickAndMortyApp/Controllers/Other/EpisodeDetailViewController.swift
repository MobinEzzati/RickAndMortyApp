//
//  EpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by mobin on 5/2/23.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    private var url : URL?

    init(url: URL?) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "hwllow"
        view.backgroundColor = .systemGreen
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
