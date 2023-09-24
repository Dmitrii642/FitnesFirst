//
//  StatisticsTableView.swift
//  FitnesFirst
//
//  Created by Дмитрий Яковлев on 17.09.2023.
//

import UIKit

class StatisticsTableView: UITableView {
    
    private let idStaticticsViewCell = "idStaticticsViewCell"

    override init(frame: CGRect, style: UITableView.Style) {
        super .init(frame: frame, style: style)
        
        cofigure()
        setDelegates()
        
        register(StaticticsTableViewCell.self, forCellReuseIdentifier: idStaticticsViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func cofigure() {
        backgroundColor = .none
        separatorStyle = .none
        bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}
    
//MARK: - UITableViewDataSource
extension StatisticsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStaticticsViewCell, for: indexPath) as? StaticticsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}


//MARK: - UITableViewDelegate
extension StatisticsTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}

    
