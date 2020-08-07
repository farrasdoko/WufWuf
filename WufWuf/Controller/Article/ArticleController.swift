//
//  ArticleController.swift
//  WufWuf
//
//  Created by Farras Doko on 06/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var detailLabel: UITextView!
    
    var parsedData: (title: String?, image: UIImage?, quote: String?, detail: NSMutableAttributedString?)
    var detail = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let quote = parsedData.quote {
            quoteLabel.text = quote
        } else {
            quoteLabel.isHidden = true
        }
        
        

        for artisel in article1 {
            if let artikel = artisel as? String {
                let p = NSAttributedString(string: artikel)
                
                detail.append(p)
            } else if artisel is UIImage {
                
                let textAttatchment = NSTextAttachment()
                textAttatchment.image = artisel as! UIImage
                
                let height = textAttatchment.image?.size.width ?? 0
                let scaleFactor = height / (detailLabel.frame.size.width - 10)
                textAttatchment.image = UIImage(cgImage: (textAttatchment.image?.cgImage)!, scale: scaleFactor, orientation: .up)
                let attrStringWithImage = NSAttributedString(attachment: textAttatchment)
                
                detail.append(attrStringWithImage)
            } else {
                detail.append(artisel as! NSAttributedString)
            }
        }
        detailLabel.attributedText = detail
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
