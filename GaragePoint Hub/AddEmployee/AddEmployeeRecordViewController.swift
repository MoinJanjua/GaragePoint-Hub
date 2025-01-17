//
//  AddEmployeeRecordViewController.swift
//  GaragePoint Hub
//
//  Created by UCF 2 on 15/01/2025.
//

import UIKit

class AddEmployeeRecordViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var DesignationTF: UITextField!
    @IBOutlet weak var GenderTF: DropDown!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var Dateofjoining: UITextField!
    @IBOutlet weak var Dateofbirth: UITextField!
    @IBOutlet weak var Save_btn: UIButton!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup button gradient
        applyGradientToButton(button: Save_btn)
        
        // Setup Gender Dropdown
        GenderTF.optionArray = ["Male", "Female"]
        GenderTF.didSelect { (selectedText, index, id) in
            self.GenderTF.text = selectedText
        }

        // Setup date pickers
        setupDatePicker(for: Dateofjoining, target: self, doneAction: #selector(doneJoiningPressed))
        setupDatePicker(for: Dateofbirth, target: self, doneAction: #selector(doneBirthPressed))

        // Add tap gesture to hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func doneJoiningPressed() {
        updateDateTextField(Dateofjoining)
    }

    @objc func doneBirthPressed() {
        updateDateTextField(Dateofbirth)
    }

    func updateDateTextField(_ textField: UITextField) {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            textField.text = dateFormatter.string(from: datePicker.date)
        }
        textField.resignFirstResponder()
    }
    
    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveData()
    }

    func saveData() {
        guard let name = NameTF.text, !name.isEmpty,
              let designation = DesignationTF.text, !designation.isEmpty,
              let gender = GenderTF.text, !gender.isEmpty,
              let contact = ContactTF.text, !contact.isEmpty,
              let addressText = address.text, !addressText.isEmpty,
              let joiningDateText = Dateofjoining.text, !joiningDateText.isEmpty,
              let birthDateText = Dateofbirth.text, !birthDateText.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }

        // Validate date formats
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let joiningDate = dateFormatter.date(from: joiningDateText),
              let birthDate = dateFormatter.date(from: birthDateText) else {
            showAlert(title: "Error", message: "Invalid date format. Please use dd-MM-yyyy.")
            return
        }

        // Save the Employee Data
        let randomID = UUID().uuidString
        let newEmployee = Employee(
            id: randomID,
            name: name,
            designation: designation,
            gender: gender,
            contact: contact,
            address: addressText,
            joiningDate: joiningDate,
            birthDate: birthDate
        )
        saveEmployeeDetail(newEmployee)
    }

    func saveEmployeeDetail(_ employee: Employee) {
        var employees = UserDefaults.standard.object(forKey: "EmployeeDetails") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(employee)
            employees.append(data)
            UserDefaults.standard.set(employees, forKey: "EmployeeDetails")
            clearTextFields()
            Displayalert(title: "Success", message: "Employee details saved successfully!")
        } catch {
            print("Error encoding employee: \(error.localizedDescription)")
        }
    }

    func clearTextFields() {
        NameTF.text = ""
        DesignationTF.text = ""
        GenderTF.text = ""
        ContactTF.text = ""
        address.text = ""
        Dateofjoining.text = ""
        Dateofbirth.text = ""
    }

    func Displayalert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
