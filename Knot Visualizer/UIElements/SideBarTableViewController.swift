//
//  SideBarTableViewController.swift
//  Knot Visualizer
//
//  Created by Karthik Dharmarajan on 7/27/20.
//  Copyright © 2020 Karthik Dharmarajan. All rights reserved.
//

import UIKit

protocol SideBarTableViewControllerDelegate {
    func sideBarControlDidSelectSection(_ indexPath:IndexPath)
}

class SideBarTableViewController: UITableViewController {
    
    var delegate : SideBarTableViewControllerDelegate?
    var items : Array<Knot> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(KnotCell.self, forCellReuseIdentifier: "cell")
        
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KnotCell
        cell.knot = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.sideBarControlDidSelectSection(indexPath)
    }
}
