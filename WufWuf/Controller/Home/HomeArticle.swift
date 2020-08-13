//
//  HomeArticle.swift
//  WufWuf
//
//  Created by Rifki Triaditiya Putra on 07/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class HomeArticle: UIViewController {
    
    private enum senderID: String {
        case demodexTap, katarakTap
    }
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var katarakView: UIView!
    @IBOutlet weak var demodexView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToNextScreen))
        gesture.name = senderID.katarakTap.rawValue
        katarakView.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(goToNextScreen))
        gesture2.name = senderID.demodexTap.rawValue
        demodexView.addGestureRecognizer(gesture2)
    }
    
    @objc func goToNextScreen(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: "Article", bundle: nil)
        let articleController = storyboard.instantiateViewController(withIdentifier: "article") as! ArticleController
        
        switch sender.name {
        case senderID.demodexTap.rawValue:
            articleController.navTitle = "Demodex"
            break
        case senderID.katarakTap.rawValue:
            articleController.navTitle = "Katarak"
            break
        default:
            break
        }
        navigationController?.pushViewController(articleController, animated: true)
    }
    
}

