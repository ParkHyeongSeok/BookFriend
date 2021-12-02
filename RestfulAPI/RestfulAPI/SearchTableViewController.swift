//
//  SearchTableViewController.swift
//  RestfulAPI
//
//  Created by 박형석 on 2021/11/29.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.userBindingClosure = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.fetchUserList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.userlist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let target = viewModel.userlist[indexPath.row]
        cell.textLabel?.text = target.body
        return cell
    }

}
