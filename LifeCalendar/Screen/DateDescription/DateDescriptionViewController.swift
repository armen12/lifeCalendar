//
//  DateDescriptionViewController.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 27.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit

class DateDescriptionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: DateDescriptionPresenter!
    var imagePicker = UIImagePickerController()
    var dateImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.presenter.setUp()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NavigationTableViewCell.self)
        self.tableView.register(HeadingTableViewCell.self)
        self.tableView.register(FeelingTableViewCell.self)
        self.tableView.register(NoteTableViewCell.self)
        self.tableView.register(AddImageTableViewCell.self)
    }
    func writeImageToDocs(image:UIImage, path: String) -> String{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

        let destinationPath = URL(fileURLWithPath: documentsPath).appendingPathComponent(path)

        debugPrint("destination path is",destinationPath)
        do {
            try image.pngData()?.write(to: destinationPath)
        } catch {
            debugPrint("writing file error", error)
        }
        return String(describing: destinationPath)
    }

    func readImageFromDocs(path: String) -> UIImage? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

        let filePath = URL(fileURLWithPath: documentsPath).appendingPathComponent(path).path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        } else {
            return nil
        }
    }
}
extension DateDescriptionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withType: NavigationTableViewCell.self, for: indexPath).setupCell(delegate: self)
        case 1:
            return tableView.dequeueReusableCell(withType: HeadingTableViewCell.self, for: indexPath).setupCell(delegate: self)
        case 2:
            return tableView.dequeueReusableCell(withType: FeelingTableViewCell.self, for: indexPath).setupCell(delegate: self)
        case 3:
            return tableView.dequeueReusableCell(withType: NoteTableViewCell.self, for: indexPath).setupCell(delegate: self)
        case 4:
            return tableView.dequeueReusableCell(withType: AddImageTableViewCell.self, for: indexPath).setupCell(delegate: self, image: dateImage)
        default:
            return UITableViewCell()
        }
    }
}
extension DateDescriptionViewController: NavigationTableViewCellProtocol{
    func cancelAction(_ sender: NavigationTableViewCell) {
        self.presenter.cancel()
    }
    
    func saveActoin(_ sender: NavigationTableViewCell) {
        self.presenter.save()
    }
}
extension DateDescriptionViewController: HeadingTableViewCellProtocol{
    func updateHeading(_ sender: HeadingTableViewCell, text: String?) {
        self.presenter.item.titel = text ?? ""
    }
    
    
}
extension DateDescriptionViewController: FeelingTableViewCellProtocol{
    func deadFeelingAction(_ sender: FeelingTableViewCell) {
        self.presenter.item.emotion = Emotion.dead.rawValue
    }
    
    func neutralFeelingAction(_ sender: FeelingTableViewCell) {
        self.presenter.item.emotion = Emotion.neutral.rawValue
    }
    
    func heartFeelingAction(_ sender: FeelingTableViewCell) {
        self.presenter.item.emotion = Emotion.heart.rawValue
    }
    
    func rockFeelingAction(_ sender: FeelingTableViewCell) {
        self.presenter.item.emotion = Emotion.rock.rawValue
    }
    
    func fireFeelingAction(_ sender: FeelingTableViewCell) {
        self.presenter.item.emotion = Emotion.fire.rawValue
    }
    
    
}

extension DateDescriptionViewController: NoteTableViewCellProtocol{
    func updateNote(_ sender: NoteTableViewCell, text: String) {
        self.presenter.item.diaryEntry = text
    }
}

extension DateDescriptionViewController: AddImageTableViewCellProtocol{
    func addImage(_ sender: AddImageTableViewCell) {
        present(imagePicker, animated: true, completion: nil)
    }
}

extension DateDescriptionViewController: DateDescriptionInterface{
    func success() {
        self.setupTableView()
    }
    func error() {
        self.alert(message: "Error")
    }
}

extension DateDescriptionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let savePath =  info[UIImagePickerController.InfoKey.imageURL] as! URL
            let p = savePath.path
            self.dateImage = image
            presenter.item.media = self.writeImageToDocs(image: image, path: p)
            self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .automatic)
        }
    }
}
