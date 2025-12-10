import UIKit

class FilterViewCell: UICollectionViewCell {
    static let identifier = "FilterViewCell"

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .systemBlue : .clear
            titleLabel.textColor = isSelected ? .white : .systemBlue
        }
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    private func setupUI() {
        contentView.layer.cornerRadius = 18
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.backgroundColor = .clear
        titleLabel.textColor = .systemBlue
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textAlignment = .center
    }
}
