//
//  ViewController.swift
//  HolidaysCalendar
//
//  Created by Ilja Patrushev on 8.12.2020.
//

import UIKit

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfHolidays.count) Holidays Found"
            }
        }
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
       
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let holiday = listOfHolidays[indexPath.row]
        
        cell.textLabel?.text = holiday.name
        cell.detailTextLabel?.text = holiday.date.iso
        
        
        return cell
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidays{[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
}



