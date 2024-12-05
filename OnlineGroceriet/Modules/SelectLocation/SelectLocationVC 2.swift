//
//  SelectLocationVC 2.swift
//  OnlineGroceriet
//
//  Created by Engy on 12/5/24.
//


//
//  SelectLocationVC.swift
//  OnlineGroceriet
//
//  Created by Engy on 11/30/24.
//

import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import DropDown

class SelectLocationVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var supTitleLabel: UILabel!
    @IBOutlet weak var zoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var areaTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!

    // MARK: - Properties
    let searchBar = UISearchBar(frame: .zero)
    let networkManager = NetworkManager()
    let dropDown = DropDown()
    var filteredyNames: [String] = []
    var countryList:Countries = []
    var countryNamesList: [String] {
        return countryList.map{$0.name.common}
    }
    var selectedCountry:String {
        return zoneTextField.text ?? ""
    }
    var areaNamesList: [String] {
        let country =  countryList.first {
            selectedCountry.lowercased() == $0.name.common.lowercased()
        }
        return country?.capital ?? []
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupUI()
        fetchData()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        setupLabels()
        setupTextFields()
        setupButtons()
        configureKeyboardManager()
    }

    private func setupLabels() {
        titleLabel.setCustomFont(font: .gilroyMedium, size: 26)
        supTitleLabel.setCustomFont(font: .gilroyMedium, size: 16)
    }

    private func setupTextFields() {
        let txts = [zoneTextField,areaTextField]
        txts.forEach{
            $0?.selectedTitleColor = ._7_C_7_C_7_C
            $0?.selectedLineColor = ._53_B_175
            $0?.textColor = .black
            $0?.lineColor = .c7Bcb6
            $0?.placeholder = $0?.placeholder?.capitalized
        }
        zoneTextField.setCustomFont(font: .gilroyMedium, size: 18)
        areaTextField.setCustomFont(font: .gilroyMedium, size: 16)
    }

    private func setupButtons() {
        submitButton.addCornerRadius(20)
    }

    private func configureKeyboardManager() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistance = 50
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true

    }
    private func fetchData() {
        Task {
            do { countryList =  try await networkManager.fetchData(urlString: APIHelper.allCountries.path, model: Countries.self)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private func setupSearchableDropDown(textField:UITextField,dataSource:[String]) {
        filteredyNames = dataSource
        dropDown.anchorView = textField
        dropDown.bottomOffset = CGPoint(x: 0, y: textField.frame.height+50)
        dropDown.width = textField.frame.width
        dropDown.direction = .bottom
        dropDown.selectionAction = { index, item in
            textField.text = item
        }
        dropDown.dataSource = dataSource
        dropDown.show()

        dropDown.addSubview(searchBar)
        setSearchConstraints(searchBar: searchBar, textField)
    }

    func setSearchConstraints(searchBar: UISearchBar,_ textField: UITextField) {
        searchBar.backgroundColor = .EBFFF_4
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 5),
                searchBar.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                searchBar.heightAnchor.constraint(equalToConstant: 45),
            ])
    }

    // MARK: - Actions
    @IBAction func zoneButtonClicked(_ sender: Any) {
        setupSearchableDropDown(textField: zoneTextField,dataSource: countryNamesList)
    }

    @IBAction func areaButtonClicked(_ sender: Any) {
        setupSearchableDropDown(textField: areaTextField,dataSource: areaNamesList)
    }

    @IBAction func backButtonClicked(_ sender: Any) {

        dismissDetail()
    }
    @IBAction func submitButtonClicked(_ sender: Any) {
        guard let zone = zoneTextField.text , !zone.isEmpty else {
            displayMessage(massage: .zoneEmpty)
            return
        }
        guard let area = areaTextField.text , !area.isEmpty else {
            displayMessage(massage: .areaEmpty)
            return
        }
        UserDefaultsManager.shared.zone = zone
        UserDefaultsManager.shared.area = area
        UserDefaultsManager.shared.isLogin = true
        UserDefaultsManager.shared.storeData()
        UIWindow.setRootViewController(viewController: MainTabBarVC())
    }

}
// MARK: - UISearchBarDelegate
extension SelectLocationVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dropDown.dataSource = filteredyNames
        } else {
            dropDown.dataSource = filteredyNames.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        dropDown.reloadAllComponents()
    }
}
