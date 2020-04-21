//
//  UARepoVC.swift
//  UAKitBase
//
//  Created by ZD on 2020/4/4.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit
import UAKit

class UARepoVC: UABaseVC {
    var urlStr = ""
    var tableV = UITableView()
    var dataArray: [Repo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GitHub.getRepo(urlStr) { [weak self] (repos) in
            guard let self = self else { return }
            let data = repos.value ?? []
            UALog(data)
            self.dataArray = data
            self.tableV.reloadData()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(tableV)
        tableV.snp.makeConstraints { (snp) in
            snp.edges.equalToSuperview()
        }
        tableV.dataSource = self
    }

}

extension UARepoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        }
        let repo = dataArray[indexPath.row]
        cell?.textLabel?.text = repo.name
        cell?.detailTextLabel?.text = repo.descriptionText
        return cell!
    }
}
