//
//  DemodexScannerScreenViewController.swift
//  WufWuf
//
//  Created by michael tamsil on 11/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DemodexScannerScreenViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var viewDiagnosa: UIView!
    @IBOutlet weak var tombolPeta: UIButton!
    @IBOutlet weak var viewSaran: UIView!
    @IBOutlet weak var viewPenanganan: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHiddenInfos(true)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[.originalImage] as? UIImage {
            self.imageView2.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not conver UIImage into CIImage")
            }
            detect(ciimage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(_ image: CIImage) {
        guard let model = try? VNCoreMLModel(for: DemodexDogImageClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            if let firstResult = results.first {
                //MARK: PUT INFO HERE
                
                print(firstResult.identifier)
                self.isHiddenInfos(true)
                if (firstResult.identifier == "Healthy"){
                    self.judul.text = "Wow, kulit anjing anda sehat"
                    self.judul.isHidden = false
                }else{
                    self.judul.text = "Kulit anjing anda memiliki penyakit demodex"
                    self.isHiddenInfos(true)
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func isHiddenInfos(_ bool: Bool){
        judul.isHidden = bool
        viewDiagnosa.isHidden = bool
        tombolPeta.isHidden = bool
        viewSaran.isHidden = bool
        viewPenanganan.isHidden = bool
    }
}
