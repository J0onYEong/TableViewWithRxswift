//
//  TableViewCell.swift
//  TableViewRxswift
//
//  Created by 최준영 on 3/31/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let numberLabelView: UILabel = {
       
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let stateLabelView: UILabel = {
       
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var onStateChange: ( (Bool) -> Void )?
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutoLayout()
    }
    
    func setAutoLayout() {
        
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(numberLabelView)
        self.addSubview(stateLabelView)
        
        NSLayoutConstraint.activate([
            
            numberLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            numberLabelView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            stateLabelView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stateLabelView.leadingAnchor.constraint(equalTo: numberLabelView.trailingAnchor, constant: 10),

        ])
    }

}
