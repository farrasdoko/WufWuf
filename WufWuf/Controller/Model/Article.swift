//
//  Article.swift
//  WufWuf
//
//  Created by Farras Doko on 06/08/20.
//  Copyright © 2020 wufwuf. All rights reserved.
//

import UIKit


let image1 = UIImage(named: "artikel-demo")
let image2 = UIImage(named: "attachment")
var attributedString = NSMutableAttributedString(string: "\n\n1. Terdapat semacam kabut berwarna putih keruh di mata\n2. Katarak kurang dari 30%, tidak ada gejala yang berarti\n3. Katarak di atas 60%, mulai ada gangguan penglihatan\n4. Anjing yang terkena katarak masih bisa melihat,\n    meskipun hanya melihat perubahan cahaya.\n5. Katarak tidak membuat rasa sakit, hanya saja memang\n    mengganggu penglihatan. Namun jika peradangan\n    berlanjut dapat terjadi glaucoma yang terasa sakit bagi\n    anjing.\n")
let article1: [Any] = ["Opacity terbatas pada area lensa mata atau kapsul atau dapat mempengaruhi keseluruhan struktur. Katarak sempurna mempengaruhi kedua bola mata dimana mengakibatkan kebutaan, ketika daerah kecil yang mengalami katarak non-progresif, hal itu tidak akan mengganggu pengelihatan. \n\nKatarak primer timbul pada beberapa jenis trah; pada jenis lain katarak dapat berkembang menjadi katarak sekunder karena gangguan lain yang diwariskan oleh indukan seperti atrofi retina atau glaukoma yang progresif.\n\n", image1, attributedString, image2]
