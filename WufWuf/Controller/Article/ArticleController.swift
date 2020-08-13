//
//  ArticleController.swift
//  WufWuf
//
//  Created by Farras Doko on 06/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class ArticleController: UIViewController {
    
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var detailLabel: UITextView!
    
    var parsedData: (title: String?, image: UIImage?, detail: NSMutableAttributedString?)
    var detail = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                navigationItem.title = parsedData.title
                bannerImg.image = parsedData.image
    }
    
    func getArticle(_ detail: [Any]) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()
        for article in detail {
            if let articleString = article as? String {
                let p = NSAttributedString(string: articleString, attributes: [.font:UIFont.systemFont(ofSize: 17)])
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
    
    @IBAction func onChanged(_ sender: UISegmentedControl) {
        switch title {
        case "Katarak":
            switch sender.titleForSegment(at: sender.selectedSegmentIndex) {
            case "Pengertian":
                detailLabel.attributedText = getArticle(katarakPengertian)
                bannerImg.image = UIImage(named: "katarak-pengertian")
                break
            case "Penyebab":
                detailLabel.attributedText = getArticle(katarakPenyebab)
                bannerImg.image = UIImage(named: "katarak-penyebab")
                break
            case "Gejala":
                detailLabel.attributedText = getArticle(katarakGejala)
                bannerImg.image = UIImage(named: "katarak-gajala")
                break
            default:
                break
            }
        case "Demodex":
            
            switch sender.titleForSegment(at: sender.selectedSegmentIndex) {
            case "Pengertian":
                detailLabel.attributedText = getArticle(demodexPengertian)
                bannerImg.image = UIImage(named: "demodex-pengertian")
                break
            case "Penyebab":
                detailLabel.attributedText = getArticle(demodexPenyebab)
                bannerImg.image = UIImage(named: "demodex-penyebab")
                break
            case "Gejala":
                detailLabel.attributedText = getArticle(demodexGejala)
                bannerImg.image = UIImage(named: "demodex-gejala")
                break
            default:
                break
            }
        default:
            break
        }
        
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
    
}
