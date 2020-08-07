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
            let quoteString = NSAttributedString(string: quote, attributes: [ .font:UIFont.italicSystemFont(ofSize: 14)])
            quoteLabel.attributedText = quoteString
        } else {
            quoteLabel.isHidden = true
        }
//        titleLabel.text = parsedData.title
//        bannerImg.image = parsedData.image
        detailLabel.attributedText = getArticle(article1)
    }
    
    func getArticle(_ detail: [Any]) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()
        for article in detail {
            if let articleString = article as? String {
                let p = NSAttributedString(string: articleString)
                string.append(p)
            } else if article is UIImage {
                let image = NSTextAttachment(image: resizeImage(article as! UIImage, 190))
                let imageString = NSAttributedString(attachment: image)
                let imageCentered = NSMutableAttributedString(attributedString: imageString)
                
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = .center
                imageCentered.addAttribute(.paragraphStyle, value: paragraph, range: NSMakeRange(0, 1))
                
                string.append(imageCentered)
            } else {
                string.append(article as! NSAttributedString)
            }
        }
        return string
    }
    
    func resizeImage(_ image: UIImage,_ height: CGFloat) -> UIImage {
        let scale = height / image.size.height
        let width = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
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
