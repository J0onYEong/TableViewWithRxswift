//
//  ViewController.swift
//  TableViewRxswift
//
//  Created by 최준영 on 3/31/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let viewModel = TableListViewModel()
    
    let disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 56
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: String(String(describing: TableViewCell.self)))
        
        return tableView
    }()
    
    let detectArea: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .black.withAlphaComponent(0.1)
        view.isUserInteractionEnabled = false
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        setAutoLayout()
        
        setObservable()
    }
    
    func setAutoLayout() {
        
        view.addSubview(tableView)
        view.insertSubview(detectArea, aboveSubview: tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            detectArea.heightAnchor.constraint(equalToConstant: 100),
            detectArea.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            detectArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detectArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
    }
    
    func setObservable() {
        
        viewModel
            .numberListObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: TableViewCell.self), cellType: TableViewCell.self)) { _, item, cell in
                
                cell.numberLabelView.text = "\(item.number)번"
                cell.stateLabelView.text = item.isInside ? "겹침" : "안겹침"
                cell.backgroundColor = (item.isInside ? UIColor.blue : UIColor.red).withAlphaComponent(0.3)
                
                cell.onStateChange = { [weak self] isInside in
                    
                    self?.viewModel.changeState(isInside: isInside,  id: item.id)
                }
                
            }
            .disposed(by: disposeBag)
        
    }

}

extension ViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let tableView = scrollView as? UITableView else {
            
            return
        }
        
        tableView.visibleCells.forEach { cell in
            
            guard let tableViewCell = cell as? TableViewCell else { return }
            
            // tableView를 기준으로한 Cell의 프레임을 detectAreat뷰의 좌표계로부터의 프레임
            let frameFromDetactArea = tableView.convert(tableViewCell.frame, to: detectArea)
            
            let isInside = (frameFromDetactArea.origin.y+frameFromDetactArea.height) >= 0 && frameFromDetactArea.origin.y <= detectArea.bounds.height
            
            tableViewCell.onStateChange?(isInside)
        }
    }
    
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        
//        // 스크롤이 뭠췄을 때 호출
//        print("뭠춤")
//    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            
//            // 스크롤뷰가 터치에 의해 멈출 경우
//
//        } else {
//            
//            // 스크롤뷰가 감속을 시작하는 경우(드래그중 손을 뗌)
//        }
//    }
}

