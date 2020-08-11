//
//  InfoController.swift
//  WufWuf
//
//  Created by Farras Doko on 11/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class InfoController: UIViewController {

    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var diagnosaTxt: UILabel!
    @IBOutlet weak var indikasiTxt: UILabel!
    @IBOutlet weak var penangananTxt: UILabel!
    
    @IBOutlet weak var pict1: UIImageView!
    @IBOutlet weak var pict2: UIImageView!
    @IBOutlet weak var pict3: UIImageView!
    @IBOutlet weak var pict4: UIImageView!
    
    private var parsed: (banner: UIImage?, penyakit: String?, tingkat: String?, indikasi: String?, penanganan: String?, pict1: UIImage?, pict2: UIImage?, pict3: UIImage?, pict4: UIImage?)?
    private enum pictRecognizer: String {
        case pict, pict2, pict3, pict4
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func setDiagnosaText() {
        let text = NSMutableAttributedString(string: "Penyakit: p\nTingkat: ")
        guard let penyakit = parsed?.penyakit, let tingkat = parsed?.tingkat else { return }
        
        let penyakitAttr = NSAttributedString(string: penyakit, attributes: [.strokeWidth:-6])
        text.replaceCharacters(in: NSMakeRange(10, 1), with: penyakitAttr)
        
        let tingkatAttr = NSAttributedString(string: tingkat, attributes: [.strokeColor:UIColor.red, .strokeWidth:-9])
        text.append(tingkatAttr)
        
        diagnosaTxt.attributedText = text
    }
    
    func setIndikasiText() {
        indikasiTxt.text = parsed?.indikasi
    }
    
    func setPenangananText() {
        penangananTxt.text = parsed?.penanganan
    }
    
    func setGambar() {
        bannerImg.image = parsed?.banner
        
        pict1.image = parsed?.pict1
        pict2.image = parsed?.pict2
        pict3.image = parsed?.pict3
        pict4.image = parsed?.pict4
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
