//
//  TableDataShow.swift
//  TestApp
//
//  Created by Nikita Kurochka on 28.06.2022.
//

import UIKit

class TableDataShow: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Yebki"
//        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .purple
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(createHero))
        
        
        tableView = UITableView(frame: .zero).then({ tableView in
            view.addSubview(tableView)
            tableView.frame = self.view.frame
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 200
            tableView.register(CustomTableCell.self, forCellReuseIdentifier: "cell")
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
            }
        })
        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.pidorsArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        cell.pidor = AppData.shared.pidorsArray[indexPath.row]
        
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let heroScreen = ShowHeroScreen(pidor: AppData.shared.pidorsArray[indexPath.row])
        heroScreen.modalPresentationStyle = .overCurrentContext
        self.present(heroScreen, animated: false)
//        self.navigationController?.pushViewController(heroScreen, animated: true)
        
        
        
        
    }
    
    @objc func createHero() {
        self.navigationController?.pushViewController(CreateHeroView(), animated: true)
    }

}
