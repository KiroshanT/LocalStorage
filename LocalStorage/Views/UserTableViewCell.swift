//
//  UserTableViewCell.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    
    var data: User! = nil {
        didSet {
            thumbnail.kf.setImage(with: URL(string: data.thumbnail))
            labelName.text = "\(data.title) \(data.first_name) \(data.last_name)"
            labelGender.text = data.gender
            labelDob.text = Common.getDateOfBirthFormat(dateAndTime: data.dob)
        }
    }
    
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    var labelGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    var labelDob: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        commonInit(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(view: UIView) {
        view.addSubview(thumbnail)
        view.addSubview(labelName)
        view.addSubview(labelGender)
        view.addSubview(labelDob)
        
        NSLayoutConstraint.activate([
            thumbnail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            thumbnail.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            thumbnail.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            thumbnail.widthAnchor.constraint(equalToConstant: 60),
            thumbnail.heightAnchor.constraint(equalToConstant: 60),
            
            labelName.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10),
            labelName.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            labelName.bottomAnchor.constraint(equalTo: labelGender.topAnchor),
            
            labelGender.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10),
            labelGender.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelGender.topAnchor.constraint(equalTo: labelName.bottomAnchor),
            labelGender.bottomAnchor.constraint(equalTo: labelDob.topAnchor),
            
            labelDob.leftAnchor.constraint(equalTo: thumbnail.rightAnchor, constant: 10),
            labelDob.rightAnchor.constraint(equalTo: view.rightAnchor),
            labelDob.topAnchor.constraint(equalTo: labelGender.bottomAnchor),
            labelDob.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
