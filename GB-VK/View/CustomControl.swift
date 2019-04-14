//
//  CustomControl.swift
//  GB-VK
//
//  Created by MacBook-Игорь on 14/04/2019.
//  Copyright © 2019 MacBook-Игорь. All rights reserved.
//

import UIKit

// customcontrol: UIControl
// внутри UILabel & UIView
// на UIView рисую сердечко
// функция изменения цифры лайка + сам контрол.аддТаргет

enum CustomControlState {
    case liked, normal
}

class CustomControl: UIControl {
    
    let likeButton = UIButton()
    let countLikeLabel = UILabel()
    var liked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()

    }
    
    private func setupView() {
        likeButton.backgroundColor = .red
        likeButton.setTitle("1", for: .normal)
        likeButton.setTitle("2", for: .highlighted)
        countLikeLabel.text = "0"
        let stackView = UIStackView(arrangedSubviews: [self.countLikeLabel, self.likeButton])
        self.addSubview(stackView)
        stackView.frame = bounds
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        likeButton.addTarget(self, action: #selector(printText), for: .touchUpInside)
    }
    
    @objc func printText() {
        liked.toggle()
        countLikeLabel.text = liked ? "1" : "0"
        countLikeLabel.textColor = liked ? .red : .black
    }

}

//extension UIBezierPath {
//    convenience init(heartIn rect: CGRect) {
//        self.init()
//
//        //Calculate Radius of Arcs using Pythagoras
//        let sideOne = rect.width * 0.4
//        let sideTwo = rect.height * 0.3
//        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
//
//        //Left Hand Curve
//        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
//
//        //Top Centre Dip
//        self.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
//
//        //Right Hand Curve
//        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
//
//        //Right Bottom Line
//        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
//
//        //Left Bottom Line
//        self.close()
//    }
//}
//
//extension Int {
//    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
//}
//
//class CustomControl: UIControl {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addTarget(self, action: #selector(printText), for: .touchUpInside)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        self.addTarget(self, action: #selector(printText), for: .touchUpInside)
//
//    }
//
//    @objc func printText() {
//        print("Hello world")
//        filled.toggle()
//
//    }
//
//    var filled: Bool = false
//    var strokeWidth: CGFloat = 2.0
//
//    var strokeColor: UIColor? = .red
//
//    override func draw(_ rect: CGRect) {
//        let bezierPath = UIBezierPath(heartIn: self.bounds)
//
//        if self.strokeColor != nil {
//            self.strokeColor!.setStroke()
//        } else {
//            self.tintColor.setStroke()
//        }
//
//        bezierPath.lineWidth = self.strokeWidth
//        bezierPath.stroke()
//
//        if self.filled {
//            self.tintColor.setFill()
//            bezierPath.fill()
//        }
//    }
//
//
//}
