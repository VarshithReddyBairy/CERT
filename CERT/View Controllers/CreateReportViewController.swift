//
//  CreateReportViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 12/2/21.
//

import UIKit

class CreateReportViewController: UIViewController {
    
    let fireHazardlevel = ["--Select Level--","Minor","Major","Medium","Spread Threat","Moderate","High","None"]
    let hazmotImpactLevel = ["--Select Type--","Gas","Fluid","Solid","Other Type"]
    let structureDamageLevel = ["--Select Damage Level--","High","Medium","Low"]
    let casualitiesType = ["--Select Casuality--","Walking wounded (Minor)","Broken Arm/Leg (Delay)","Medical care (Immediate)","Deceased"]
    
    //PickerViews
    var fireDamagePickerView = UIPickerView()
    var hazmotDamagePickerView = UIPickerView()
    var structureDamagePickerView = UIPickerView()
    var casualityDamagePickerView = UIPickerView()
    
    //Error labels to show when the user left any field
    @IBOutlet weak var casualityLabel: UILabel!
    @IBOutlet weak var fireHazardLabel: UILabel!
    @IBOutlet weak var strucDamageLabel: UILabel!
    @IBOutlet weak var hazmotDamageLabel: UILabel!
    
    //UITextFields
    @IBOutlet weak var casualityImpactField: UITextField!
    @IBOutlet weak var fireHazardImpactField: UITextField!
    @IBOutlet weak var strucDamageImpactField: UITextField!
    @IBOutlet weak var hazmotDamageImpactField: UITextField!
    
    //submit Button Outlet
    @IBOutlet weak var submitRprtBtnOutlt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        fireDamagePickerView.delegate = self
        fireDamagePickerView.dataSource = self
        fireDamagePickerView.tag = 1
        fireHazardImpactField.inputView = fireDamagePickerView
        fireHazardImpactField.textAlignment = .center
        
        //
        hazmotDamagePickerView.delegate = self
        hazmotDamagePickerView.dataSource = self
        hazmotDamagePickerView.tag = 2
        hazmotDamageImpactField.inputView = hazmotDamagePickerView
        hazmotDamageImpactField.textAlignment = .center
        
        //
        structureDamagePickerView.delegate = self
        structureDamagePickerView.dataSource = self
        structureDamagePickerView.tag = 3
        strucDamageImpactField.inputView = structureDamagePickerView
        strucDamageImpactField.textAlignment = .center
        
        //
        casualityDamagePickerView.delegate = self
        casualityDamagePickerView.dataSource = self
        casualityDamagePickerView.tag = 4
        casualityImpactField.inputView = casualityDamagePickerView
        casualityImpactField.textAlignment = .center
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

}

extension CreateReportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return fireHazardlevel.count
        case 2:
            return hazmotImpactLevel.count
        case 3:
            return structureDamageLevel.count
        case 4:
            return casualitiesType.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return fireHazardlevel[row]
        case 2:
            return hazmotImpactLevel[row]
        case 3:
            return structureDamageLevel[row]
        case 4:
            return casualitiesType[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            fireHazardImpactField.text = fireHazardlevel[row]
            fireHazardImpactField.resignFirstResponder()
        case 2:
            hazmotDamageImpactField.text = hazmotImpactLevel[row]
            hazmotDamageImpactField.resignFirstResponder()
        case 3:
            strucDamageImpactField.text = structureDamageLevel[row]
            strucDamageImpactField.resignFirstResponder()
        case 4:
            casualityImpactField.text = casualitiesType[row]
            casualityImpactField.resignFirstResponder()
        default: break
        }
    }
    
}
