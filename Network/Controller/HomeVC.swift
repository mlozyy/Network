//
//  ViewController.swift
//  Network
//
//  Created by LzCtrl on 5/20/20.
//  Copyright © 2020 LzCtrl. All rights reserved.
//

import UIKit

var users = [UserList]()

class HomeVC: UITableViewController {
    
    let titleSubCellID = "titleSubCellID"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        loadData()
    }
    
    private func setupNavBar() {
        self.title = "Home"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .grouped)
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(TitleSubCell.self, forCellReuseIdentifier: titleSubCellID)
    }
    
    private func loadData() {
        let shared = CoreDataManager.shared
        users = shared.findAllForEntity("UserList") as! [UserList]
    }
    
    @objc
    func addUserButtonPressed() {
        let nav = UINavigationController(rootViewController: NewUserVC())
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        self.present(nav, animated: true, completion: nil)
    }
}

extension HomeVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: titleSubCellID) as! TitleSubCell
        
        cell.title = users[indexPath.row].name
        cell.subTitle = users[indexPath.row].headline
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
