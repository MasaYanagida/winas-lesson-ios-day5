//
//  ViewController.swift
//  Day5Homework
//
//  Created by 柳田昌弘 on 2021/01/08.
//

import UIKit

class ViewController: UIViewController {

    private var contents = [Feedable]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Contents"
        loadContents()
    }
    private func loadContents() {
        Service.content.getList(
            completion: { [weak self] items in
                guard let `self` = self else { return }
                self.contents = items
                self.tableView.reloadData()
            },
            failure: { _, _ in
                // TODO : error handling
            })
    }
    
    @IBOutlet fileprivate dynamic weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "HospitalTableViewCell", bundle: nil), forCellReuseIdentifier: "HospitalTableViewCell")
            tableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurantTableViewCell")
        }
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = contents[indexPath.row] // Feedable
        switch content {
        case let content as Hospital: // Hospital
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalTableViewCell", for: indexPath) as! HospitalTableViewCell
            cell.delegate = self
            cell.hospital = content
            return cell
        case let content as Restaurant:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
            cell.delegate = self
            cell.restaurant = content
            return cell
        default: return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let content = contents[indexPath.row]
        switch content {
        case let hospital as Hospital:
            let controller = HospitalDetailViewController.fromStoryboard()
            controller.hospital = hospital
            navigationController?.pushViewController(controller, animated: true)
        case let restaurant as Restaurant:
            let controller = RestaurantDetailViewController.fromStoryboard()
            controller.restaurant = restaurant
            navigationController?.pushViewController(controller, animated: true)
        default:
            return
        }
    }
}


extension ViewController: HospitalTableViewCellDelegate {
    func hospitalTableViewCell(mapButtonTouchUpInside cell: HospitalTableViewCell) {
        guard let hospital = cell.hospital else { return }
        
        let alert = UIAlertController(title: hospital.name, message: hospital.address, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        let mapViewController = MapViewController<Hospital>()
        mapViewController.item = hospital
        alert.setValue(mapViewController, forKey: "contentViewController")
        mapViewController.preferredContentSize.height = 300
        
        present(alert, animated:true, completion:nil)
        
    }
}

// MARK: - RestaurantTableViewCellDelegate

extension ViewController: RestaurantTableViewCellDelegate {
    func restaurantTableViewCell(mapButtonTouchUpInside cell: RestaurantTableViewCell) {
        guard let restaurant = cell.restaurant else { return }
        
        let alert = UIAlertController(title: restaurant.name, message: restaurant.address, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        let mapViewController = MapViewController<Restaurant>()
        mapViewController.item = restaurant
        alert.setValue(mapViewController, forKey: "contentViewController")
        mapViewController.preferredContentSize.height = 300
        
        present(alert, animated: true, completion: nil)
    }
}

