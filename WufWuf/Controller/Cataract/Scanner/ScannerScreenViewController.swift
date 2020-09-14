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
import AVFoundation

class ScannerScreenViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
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
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not convert UIImage into CIImage")
            }
            detect(ciimage)
        } else {
            print("can't take userPickedImage")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(_ image: CIImage) {
        DispatchQueue.main.async {
            self.viewSaran.isHidden = true
            self.viewPenanganan.isHidden = true
        }
        
        guard let model = try? VNCoreMLModel(for: CataractDogImageClassifier().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            print(results)
            
            if let firstResult = results.first {
                //MARK: PUT INFO HERE and determine what info will be
                //self.contentLabel.text = firstResult.identifier
//                print(firstResult)

                let category = firstResult.identifier
                                
                switch category {
                    case "Cataract":
                        self.judul.text = "Mata anjing anda memiliki penyakit katarak"
                        DispatchQueue.main.async {
                            self.viewSaran.isHidden = false
                            self.viewPenanganan.isHidden = false
                        }
                        break
                    case "Healthy":
                        self.judul.text = "Wow, mata anjing anda sehat"
                        break
                    default:
                        self.judul.text = "Maaf, gambar tidak dapat mendeteksi mata anjing. Coba ambil foto mata anjing sekali lagi"
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
    
    @IBAction func cameraTapped2(_ sender: Any) {
        
        func openCamera(){
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                openCamera()
                break
            default:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        openCamera()
                    } else {
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
