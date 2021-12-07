//
//  BookListTableViewCell.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/06.
//

import UIKit
import Kingfisher

class BookListTableViewCell: UITableViewCell {
    static let identifier = "BookListTableViewCell"
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(book: Book) {
        bookImage.kf.setImage(with: book.image)
        let titleFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!
        bookTitle.attributedText = book.title.htmlEscaped(font: titleFont)
        let authorFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)!
        bookAuthor.attributedText = book.author?.htmlEscaped(font: authorFont)
        let descriptionFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!
        bookDescription.attributedText = book.description.htmlEscaped(font: descriptionFont)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bookImage.layer.cornerRadius = 10
    }

}
