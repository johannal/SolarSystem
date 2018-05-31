//
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var distanceUnitsTextField: UITextField!
    
    let distanceUnits = ["Astronomical units (au)", "Light years (ly)", "Terameters (Tm)", "Gigameters (Gm)", "Megameters (Mm)", "Kilometers (km)", "Meters (m)"]
    
    lazy var unitsPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.distanceUnitsTextField.inputView = unitsPickerView
        
        let initialRow = 0
        self.distanceUnitsTextField.text = self.distanceUnits[initialRow]
        self.unitsPickerView.selectRow(initialRow, inComponent: 0, animated: false)
    }
    
    // MARK: - Picker view data source & delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distanceUnits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return distanceUnits[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.distanceUnitsTextField.text = self.distanceUnits[row]
    }
}

class NoCaretTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}
