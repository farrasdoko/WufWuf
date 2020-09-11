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
import AVFoundation

class DemodexScannerScreenViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var viewSaran: UIView!
    @IBOutlet weak var viewPenanganan: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        DispatchQueue.main.async {
            self.viewSaran.isHidden = true
            self.viewPenanganan.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.editedImage] as? UIImage {
            self.imageView2.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not conver UIImage into CIImage")
            }
            detect(ciimage)
            
        }else {
            print("cant take userPickedImage")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(_ image: CIImage) {
        DispatchQueue.main.async {
            self.viewSaran.isHidden = true
            self.viewPenanganan.isHidden = true
        }

        guard let model = try? VNCoreMLModel(for: DemodexDogImageClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            print(results)
            
            if let firstResult = results.first {
                //MARK: PUT INFO HERE and determine what info will be
                // self.contentLabel.text = firstResult.identifier
//                print(firstResult)
                
                let category = firstResult.identifier
                
                switch category {
                    case "Demodex":
                        self.judul.text = "Kulit anjing anda memiliki penyakit demodex"
                        DispatchQueue.main.async {
                            self.viewSaran.isHidden = false
                            self.viewPenanganan.isHidden = false
                        }
                    case "Healthy":
                        self.judul.text = "Wow, kulit anjing anda sehat"
                    default:
                        self.judul.text = "Maaf, gambar tidak dapat mendeteksi kulit anjing. Coba ambil foto kulit anjing sekali lagi"
                }
                
                DispatchQueue.main.async {
                    self.judul.isHidden = false
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
        func openCamera(){
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                openCamera()
                break
            default:
                print("Default")
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        openCamera()
                    }else {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "permohonan penggunaan kamera", message: "mohon mengizinkan penggunaan kamera di menu setting, Halo Dog & hidupkan mode kamera", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                break
        }
    }
    
    @IBAction func photoTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}
