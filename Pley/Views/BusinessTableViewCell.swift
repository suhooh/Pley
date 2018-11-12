import UIKit
import Cosmos

class BusinessTableViewCell: UITableViewCell {
    static let reuseIdendifier = String(describing: BusinessTableViewCell.self)
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var priceAndCagegoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(with business: Business, index: Int) {
        nameLabel.text = "\(index + 1). \(business.name)"
        ratingView.rating = business.rating ?? 0

        let distance = business.distance == nil ? "" : String(format: " \u{2022} %0.2fkm", business.distance! / 1000 )
        reviewLabel.text = "\(business.reviewCount ?? 0) reviews\(distance)"

        var priceString = ""
        if let price = business.price, !price.isEmpty {
            priceString = "\(price) \u{2022} "
        }
        var categoryString = ""
        if let categories = business.categories {
            categoryString = categories.compactMap({ $0.title }).joined(separator: ", ")
        }
        priceAndCagegoriesLabel.text = "\(priceString)\(categoryString)"

        if let address = business.location?.displayAddress, !address.isEmpty {
            addressLabel.text = address.joined(separator: ", ")
        }

        if let imageUrlString = business.imageUrl, let imageUrl = URL(string: imageUrlString) {
            mainImageView.contentMode = .scaleAspectFill
            mainImageView.kf.setImage(with: imageUrl)
        } else {
            mainImageView.contentMode = .center
            mainImageView.image = UIImage(named: "flower")
        }
    }

    // prevent background color from being cleared
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = ratingView.superview?.backgroundColor
        super.setSelected(selected, animated: animated)
        if selected { ratingView.superview?.backgroundColor = color }
    }

    // prevent background color from being cleared
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = ratingView.superview?.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        if highlighted { ratingView.superview?.backgroundColor = color }
    }
}
