//
//  addsaleorpurchaseViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class addsaleorpurchaseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Vehicletitle: UITextField!
    @IBOutlet weak var Vehicletype: UITextField! // For user to input vehicle type
    @IBOutlet weak var selecttype: DropDown! // Dropdown for Sale or Purchase
    @IBOutlet weak var sellername: UITextField!
    @IBOutlet weak var buyername: UITextField!
    @IBOutlet weak var Contact: UITextField!
    @IBOutlet weak var vehicleamount: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var Save_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyGradientToButton(button: Save_btn)
        setupDropdownOptions()
        setupGestureRecognizers()
    }
    
    
    func setupDropdownOptions() {
        selecttype.optionArray = ["Sale", "Purchase"] // Options for dropdown
        selecttype.didSelect { [weak self] (selectedText, index, id) in
            // Set the dropdown selection to a variable or field if needed
            self?.selecttype.text = selectedText
        }
    }
    
    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func SaveButtonTapped(_ sender: Any) {
        saveData()
    }
    
    func saveData() {
        guard let title = Vehicletitle.text, !title.isEmpty,
              let type = Vehicletype.text, !type.isEmpty,
              let saleOrPurchaseType = selecttype.text, !saleOrPurchaseType.isEmpty,
              let seller = sellername.text, !seller.isEmpty,
              let buyer = buyername.text, !buyer.isEmpty,
              let contact = Contact.text, !contact.isEmpty,
              let amountText = vehicleamount.text, !amountText.isEmpty,
              let amount = Double(amountText),
              let notesText = notes.text else {
            displayAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        
        if !isValidContact(contact) {
            displayAlert(title: "Error", message: "Please enter a valid 11-digit contact number.")
            return
        }
        
        let record = SaleOrPurchase(
            id: UUID().uuidString,
            vehicleTitle: title,
            vehicleType: type,
            saleOrPurchaseType: saleOrPurchaseType,
            sellerName: seller,
            buyerName: buyer,
            contact: contact,
            amount: amount,
            notes: notesText
        )
        
        saveRecord(record)
    }
    
    func saveRecord(_ record: SaleOrPurchase) {
        var records = UserDefaults.standard.object(forKey: "SaleOrPurchaseRecords") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(record)
            records.append(data)
            UserDefaults.standard.set(records, forKey: "SaleOrPurchaseRecords")
            clearFields()
            displayAlert(title: "Success", message: "Record saved successfully!")
        } catch {
            print("Error saving record: \(error.localizedDescription)")
        }
    }
    
    func clearFields() {
        Vehicletitle.text = ""
        Vehicletype.text = ""
        selecttype.text = ""
        sellername.text = ""
        buyername.text = ""
        Contact.text = ""
        vehicleamount.text = ""
        notes.text = ""
    }
    
    func isValidContact(_ contact: String) -> Bool {
        let regex = "^[0-9]{11}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: contact)
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
