//
//  NoteTableViewCell.swift
//  LifeCalendar
//
//  Created by Armen Nagapetyan on 28.07.2020.
//  Copyright © 2020 Armen Nagapetyan. All rights reserved.
//

import UIKit
protocol NoteTableViewCellProtocol: class{
    func updateNote(_ sender: NoteTableViewCell, text: String)
}
class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTextView: UITextView!
    weak var delegate: NoteTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.noteTextView.clipsToBounds = true
        self.noteTextView.layer.cornerRadius = 8
        self.noteTextView.delegate = self
    }
    func setupCell(delegate: NoteTableViewCellProtocol) -> Self{
        self.delegate = delegate
        return self
    }
}
extension NoteTableViewCell: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.updateNote(self, text: textView.text)
    }
}
