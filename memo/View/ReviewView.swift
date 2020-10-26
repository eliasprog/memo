//
//  ReviewView.swift
//  memo
//
//  Created by Elias Ferreira on 26/10/20.
//  Copyright © 2020 Academy IFCE. All rights reserved.
//

import UIKit

class ReviewView: UIView {
    
    // MARK: - UIELEMENTS
    
    // Labels
    lazy var labelStudy: UILabel = {
        let label = UILabel()
        label.text = "Estudar: 0"
        label.textColor = .memoBlack
        return label
    }()
    
    lazy var labelTotal: UILabel = {
        let label = UILabel()
        label.text = "Total: 0"
        label.textColor = .memoBlack
        return label
    }()
    
    // Buttons
    lazy var wrongButton: UIButton = {
        let button = UIButton()
        button.setTitle("NÃO SEI", for: .normal)
       // button.titleLabel?.font = UIFont(name: "MyMessyHandwriting", size: 30)
        button.setTitleColor(.memoWhite, for: .normal)
        button.backgroundColor = .memoRed
        //button.addTarget(self, action: #selector(signin), for: .touchUpInside)
        return button
    }()
    
    lazy var hardButton: UIButton = {
        let button = UIButton()
        button.setTitle("DIFÍCIL", for: .normal)
       // button.titleLabel?.font = UIFont(name: "MyMessyHandwriting", size: 30)
        button.setTitleColor(.memoSecondBlue, for: .normal)
        button.backgroundColor = .memoWhite
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.memoSecondBlue.cgColor
        //button.addTarget(self, action: #selector(signin), for: .touchUpInside)
        return button
    }()
    
    lazy var easyButton: UIButton = {
        let button = UIButton()
        button.setTitle("FÁCIL", for: .normal)
       // button.titleLabel?.font = UIFont(name: "MyMessyHandwriting", size: 30)
        button.setTitleColor(.memoWhite, for: .normal)
        button.backgroundColor = .memoSecondBlue
        //button.addTarget(self, action: #selector(signin), for: .touchUpInside)
        return button
    }()
    
    // Stacks
    lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .clear
        stack.spacing = 16
        return stack
    }()
    
    lazy var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        return stack
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .memoWhite
        self.setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wrongButton.layer.cornerRadius = 8
        hardButton.layer.cornerRadius = 8
        easyButton.layer.cornerRadius = 8
    }
    
    func setUpViews() {
        buttonsStack.addArrangedSubview(wrongButton)
        buttonsStack.addArrangedSubview(hardButton)
        buttonsStack.addArrangedSubview(easyButton)
        
        labelsStack.addArrangedSubview(labelStudy)
        labelsStack.addArrangedSubview(labelTotal)
        
        self.addSubviews(
            labelsStack,
            buttonsStack
        )
        self.setUpLabelsStack()
        self.setUpButtonsStack()
    }
}
