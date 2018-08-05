//
//  TypeCell.swift
//  ToRingMovie
//
//  Created by TR on 8/2/18.
//  Copyright © 2018 ToRing. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {
    var title: String?
    
    lazy var titleLabel: UILabel = {
        let title  = UILabel()
        title.font = UIFont.systemFont(ofSize: TextSizeContant.SMALL)
        title.textColor = UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        title.textAlignment = .center
        return title
    }()
    
    override var isHighlighted: Bool{
        didSet{
            titleLabel.textColor = isHighlighted ? UIColor.init(rgb: ColorCons.APP_COLOR): UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        }
    }

    override var isSelected: Bool{
        didSet{
            titleLabel.textColor = isSelected ? UIColor.init(rgb: ColorCons.APP_COLOR): UIColor.init(rgb: ColorCons.TEXT_SECONDARY)
        }
    }
    
    func setData(title: String){
        self.title = title
        self.titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponent()
    }
    
    func addComponent(){
        self.contentView.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
