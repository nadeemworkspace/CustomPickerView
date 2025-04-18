//
//  CustomPickerView.swift
//  PickerViewExample
//
//  Created by Muhammed Nadeem M A on 18/04/25.
//

import SwiftUI

struct CustomPickerView: UIViewRepresentable {
    
    @Binding var selectedIndex: Int
    let data: [String]
    let placeholder: String

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let parent: CustomPickerView
        let pickerView = UIPickerView()
        weak var textField: UITextField?

        init(_ parent: CustomPickerView) {
            self.parent = parent
            super.init()
            pickerView.delegate = self
            pickerView.dataSource = self
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            parent.data.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            parent.data[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.selectedIndex = row
            textField?.text = parent.data[row]
        }

        @objc func doneTapped() {
            textField?.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        context.coordinator.textField = textField
        // Accessibility
        textField.text = data[selectedIndex]
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.inputView = context.coordinator.pickerView
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            .init(title: "Done", style: .done, target: context.coordinator, action: #selector(Coordinator.doneTapped))
        ]
        textField.inputAccessoryView = toolbar
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = data[selectedIndex]
        context.coordinator.pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
}
