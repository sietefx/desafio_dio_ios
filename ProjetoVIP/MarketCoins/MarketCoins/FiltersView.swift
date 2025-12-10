import UIKit

protocol ToolBarFilterViewDelegate: AnyObject {
    func didSelectFilter(_ value: String)
    func cancelFilter(for filtersView: FiltersView)
}

class FiltersView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterOptions.count
    }
    
    
    public weak var delegate: ToolBarFilterViewDelegate?
    
    public var filterOptions: [String] = ["BRL", "USD", "EUR"]
    
    lazy var filterToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Ok",
                                         style: .done,
                                         target: self,
                                         action: #selector(self.doneTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancelar",
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.cancelTapped))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        return toolBar
    }()
    
    lazy var filterPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = .systemGray6
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    @objc private func doneTapped() {
        let row = filterPickerView.selectedRow(inComponent: 0)
        let selectedValue = filterOptions[row]
        delegate?.didSelectFilter(selectedValue)
    }
    
    @objc private func cancelTapped() {
        delegate?.cancelFilter(for: self)
    }

    private func setupView() {
        // Add subviews
        addSubview(filterToolBar)
        addSubview(filterPickerView)

        // Disable autoresizing mask translation for Auto Layout
        filterToolBar.translatesAutoresizingMaskIntoConstraints = false
        filterPickerView.translatesAutoresizingMaskIntoConstraints = false

        // Layout: toolbar on top, picker below filling the rest
        NSLayoutConstraint.activate([
            filterToolBar.topAnchor.constraint(equalTo: topAnchor),
            filterToolBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterToolBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            filterPickerView.topAnchor.constraint(equalTo: filterToolBar.bottomAnchor),
            filterPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterPickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterPickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // UIPickerViewDelegate title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row >= 0 && row < filterOptions.count else { return nil }
        return filterOptions[row]
    }
}
