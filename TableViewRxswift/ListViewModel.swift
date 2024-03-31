//
//  ListViewModel.swift
//  TableViewRxswift
//
//  Created by 최준영 on 4/1/24.
//

import Foundation
import RxSwift
import RxCocoa

class TableListViewModel {
    
    let numberListObservable: BehaviorRelay<[NumberElementModel]> = BehaviorRelay(value: [])
    
    init() {
        
        numberListObservable
            .accept(Array(1...100).map({
                NumberElementModel(id: $0, number: $0, isInside: false)
            }))
    }
    
    func changeState(isInside: Bool, id: Int) {
        
        _ = numberListObservable
            .take(1)
            .map { elements in
                
                if let model = elements.first(where: { $0.id == id }) {
                    
                    model.isInside = isInside
                }
                
                return elements
            }
            .subscribe(onNext: {
                
                self.numberListObservable.accept($0)
            })
    }
}
