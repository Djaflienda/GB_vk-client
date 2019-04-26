//
//  AddNewGroupCell.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 08/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

class AddNewGroupCell: UITableViewCell {

    //MARK: -@IBOutlet
    
    @IBOutlet private weak var groupImage: UIImageView!
    @IBOutlet private weak var groupName: UILabel!
    @IBOutlet private weak var groupDescription: UILabel!
    @IBOutlet weak var groupButton: UIButton!
    
    //MARK: -Properties
    
    static let reusableID = "AddNewGroupCell"
    
    var groupButtonAction: (() -> ())?
    
    //MARK: -Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.groupButton.addTarget(self, action: #selector(groupButtonTapped), for: .touchUpInside)
    }
    
    //MARK: -Handlers
    
    @objc func groupButtonTapped() {
        groupButtonAction?()
        UIView.animate(withDuration: 0.2) {
            switch self.groupButton.titleLabel?.text {
            case "✚":
                self.removeButtonState()
            case "✔︎":
                self.addButtonState()
            default:break
            }
        }
    }
    
    func configureCell(with data: GroupOLD) {
        self.groupImage.image = UIImage(named: data.groupImage)
        self.groupName.text = data.groupName
        self.groupDescription.text = data.groupDescription
        configureGroupButton(dependOn: data.isParticipating)
    }
    
    private func addButtonState() {
        groupButton.setTitle("✚", for: .normal)
        groupButton.setTitleColor(UIColor.white, for: .normal)
        groupButton.backgroundColor = UIColor(red: 113/255, green: 157/255, blue: 223/255, alpha: 1.0)
    }
    
    private func removeButtonState() {
        groupButton.setTitle("✔︎", for: .normal)
        groupButton.setTitleColor(UIColor.gray, for: .normal)
        groupButton.backgroundColor = .white
    }
    
    private func configureGroupButton(dependOn data: Bool) {
        switch data {
        case true: removeButtonState()
        case false: addButtonState()
        }
    }
}
