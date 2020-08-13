//
//  TabController.swift
//  WufWuf
//
//  Created by Farras Doko on 13/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let homeStoryboard = UIStoryboard(name: "Homes", bundle: nil)
        let feedController = homeStoryboard.instantiateInitialViewController()
        feedController?.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed-icon")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "filled-feed-icon")?.withRenderingMode(.alwaysOriginal))
        
        let scanController = ArticleController()
        scanController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "scanner-icon")?.withRenderingMode(.alwaysOriginal), tag: 1)
        
        let fileConroller = ArticleController()
        let fileBar = UITabBarItem(title: "File", image: UIImage(named: "feed-icon")?.withRenderingMode(.alwaysOriginal), tag: 2)
        fileBar.isEnabled = false
        fileConroller.tabBarItem = fileBar
        
        viewControllers = [feedController!, scanController, fileConroller]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "":
            let storyboard = UIStoryboard(name: "Homes", bundle: nil)
            guard let screen = storyboard.instantiateInitialViewController() else {break}
            screen.modalPresentationStyle = .fullScreen
            self.present(screen, animated: true, completion: nil)
            break
        default:
            break
        }
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
