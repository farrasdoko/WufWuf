//
//  HomeArticle.swift
//  WufWuf
//
//  Created by Rifki Triaditiya Putra on 07/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit

class HomeArticle: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataArticle = [Articlee]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var mainLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            collectionView.delegate = self
            collectionView.dataSource = self
            
            initDataArticle()
        }
        
        func initDataArticle() {
            let Article1 = Articlee(title: "Cara menggunakan scanner di aplikasi ini", imageName: "artikel-demo")
            let Article2 = Articlee(title: "Bored", imageName: "attachment")
            //let Article3 = Article(title: "Confused", imageName: "")
                     
            dataArticle.append(Article1)
            dataArticle.append(Article2)
            //dataArticles.append()
            
            // trigger refresh collection view
            collectionView.reloadData()
            }


                 // MARK: Menentukan jumlah item yang akan di tampilkan
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                     // MARK: Menghitung jumlah item array dataEmojies
                     return dataArticle.count
                    }
                 
                 // MARK: mengatur view cell
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                 
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCellArticle", for: indexPath) as! ArticleCollectionViewCell
                     // set nilai ke view dalam cell
                let article = dataArticle[indexPath.row]
                     cell.labelNameArticle.text = article.title!
                     cell.imageViewArticle.image = UIImage(named: article.imageName!)
                return cell
                }
    
                 // MARK: mengatur layout view cell
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                     // Lebar & tinggil cell
                return CGSize(width: collectionView.frame.width, height: 120)
                }
    }

