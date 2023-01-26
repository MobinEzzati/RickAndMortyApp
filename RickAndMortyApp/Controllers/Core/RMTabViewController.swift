//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by mobin on 1/25/23.
//

import UIKit
// tabview controller
final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabs()

    }
    private func setUpTabs(){
        let characterVC = RMCharacterViewController()
        let locationvC = RMLocationViewController()
        let episodesVC = RMEpisodesViewController()
        let settingVC = RMSettingViewController()
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationvC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingVC.navigationItem.largeTitleDisplayMode = .automatic
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: locationvC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingVC)
        nav1.tabBarItem = UITabBarItem(title: "character",
                                    image: UIImage(systemName: "person"),
                                    tag: 1)
        nav2.tabBarItem = UITabBarItem(
            title: "location",
            image: UIImage(systemName:  "location.circle"),
            tag: 2)
        nav3.tabBarItem = UITabBarItem(
            title: "episodes",
            image: UIImage(systemName: "tv"),
            tag: 3)
        nav4.tabBarItem = UITabBarItem(
            title: "setting",
            image: UIImage(systemName: "gear"),
            tag: 4)

        
        for nav in [nav1,nav2,nav3,nav4] {
            
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1,nav2,nav3,nav4],
            animated: true)
    }


}

