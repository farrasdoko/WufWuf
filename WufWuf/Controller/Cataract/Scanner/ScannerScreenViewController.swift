//
//  ScannerScreenViewController.swift
//  WufWuf
//
//  Created by michael tamsil on 07/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ScannerScreenViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var viewDiagnosa: UIView!
    @IBOutlet weak var tombolPeta: UIButton!
    @IBOutlet weak var viewGambar: UIView!
    @IBOutlet weak var viewSaran: UIView!
    @IBOutlet weak var viewPenanganan: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        self.isHiddenInfos(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not convert UIImage into CIImage")
            }
            detect(ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
        self.isHiddenInfos(false)
    }
    
    func detect(_ image: CIImage) {
        guard let model = try? VNCoreMLModel(for: CataractDogImageClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            if let firstResult = results.first {
                //MARK: PUT INFO HERE and determine what info will be
                //self.contentLabel.text = firstResult.identifier
                print(firstResult.identifier)
                self.judul.text = firstResult.identifier
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped2(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func isHiddenInfos(_ bool: Bool){
        judul.isHidden = bool
        viewDiagnosa.isHidden = bool
        tombolPeta.isHidden = bool
        viewGambar.isHidden = bool
        viewSaran.isHidden = bool
        viewPenanganan.isHidden = bool
    }
}
