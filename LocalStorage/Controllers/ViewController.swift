//
//  ViewController.swift
//  LocalStorage
//
//  Created by Kiroshan Thayaparan on 6/27/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    private var userModel = UserModel()
    private var userList: [User] = []
    var scrollStatus = false
    var refreshControl = UIRefreshControl()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var offset = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action:  #selector(refreshPullDown), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        fetchUser(offset: offset)
        getBookData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func refreshPullDown() {
        getBookData()
    }
    
    func getBookData() {
        userModel.getUserData(getUserDataCallFinished: { (status) in
            if status {
                self.fetchUser(offset: self.offset)
            }
        })
    }
    
    func fetchUser(offset: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.fetchOffset = offset
        request.fetchLimit = 10
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let user = User(title: data.value(forKey: "title") as! String,
                                first_name: data.value(forKey: "first_name") as! String,
                                last_name: data.value(forKey: "last_name") as! String,
                                email: data.value(forKey: "email") as! String,
                                gender: data.value(forKey: "gender") as! String,
                                dob: data.value(forKey: "dob") as! String,
                                city: data.value(forKey: "city") as! String,
                                phone: data.value(forKey: "phone") as! String,
                                thumbnail: data.value(forKey: "thumbnail") as! String,
                                large_image: data.value(forKey: "large_image") as! String,
                                latitude: data.value(forKey: "latitude") as! String,
                                longitude: data.value(forKey: "longitude") as! String)
                userList.append(user)
            }
            
            if !result.isEmpty {
                scrollStatus = true
            } else {
                scrollStatus = false
            }
            self.offset = userList.count
            refreshControl.endRefreshing()
            tableView.reloadData()
        } catch {
            print("Failed")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        cell.data = userList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.data = userList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.userList.count-1 && scrollStatus { //you might decide to load sooner than
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if tableView.visibleCells.contains(cell) {
                    self.scrollStatus = false
                    self.fetchUser(offset: self.offset)
                }
            }
        }
    }
}

