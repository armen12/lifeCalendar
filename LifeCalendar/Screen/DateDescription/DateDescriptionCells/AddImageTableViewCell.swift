//
//  AddImageTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
protocol AddImageTableViewCellProtocol: class {
    func addImage(_ sender: AddImageTableViewCell)
}
class AddImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    weak var delegate: AddImageTableViewCellProtocol?
    var arrOfImage = [UIImage]()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupCollectionView()
    }
    func setupCollectionView(){
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(AddImageCollectionViewCell.self)
    }
    func readImageFromDocs(path: String) -> UIImage? {
           let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
           let url = documents.appendingPathComponent(path).path
           if FileManager.default.fileExists(atPath: url) {
               return UIImage(contentsOfFile: url)
           } else {
               return nil
           }
       }
    func setupCell(delegate: AddImageTableViewCellProtocol, item: DateInterval) -> Self{
        self.delegate = delegate
        arrOfImage = []
        for i in item.media!.value{
            arrOfImage.append(self.readImageFromDocs(path: i)!)
        }
        self.imageCollectionView.reloadData()
        return self
    }
    
    @IBAction func addPictureButtonAction(_ sender: UIButton) {
        self.delegate?.addImage(self)
    }
}
extension AddImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.imageCollectionView.dequeueReusableCell(withType: AddImageCollectionViewCell.self, for: indexPath).setupCell(image: arrOfImage[indexPath.row])
    }
}
extension AddImageTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 61, height: 61)
    }
}
