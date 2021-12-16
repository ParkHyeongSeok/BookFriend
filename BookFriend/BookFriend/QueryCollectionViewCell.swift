//
//  QueryCollectionViewCell.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/07.
//

import UIKit
import RxSwift

class QueryCollectionViewCell: UICollectionViewCell {
    static let identifier = "QueryCollectionViewCell"
   
    let queryLabel: UILabel = {
       let label = UILabel()
        label.text = "시선으로부터"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeConstraints()
        configureUI()
    }
    
    static func fittingSize(availableHeight: CGFloat, query: String) -> CGSize {
        let cell = QueryCollectionViewCell()
        cell.updateUI(query: query)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    func updateUI(query: String) {
        queryLabel.text = query
    }
    
    private func configureUI() {
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
    }
    
    private func makeConstraints() {
        contentView.addSubview(queryLabel)
        queryLabel.translatesAutoresizingMaskIntoConstraints = false
        queryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        queryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        queryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        queryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
    }
}
