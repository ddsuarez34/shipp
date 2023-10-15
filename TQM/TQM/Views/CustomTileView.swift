import UIKit

class CustomTileView: UIView {
    
    // MARK: - Properties
    public let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "selfie")
        return iv
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        return label
    }()
    
    var numberOfLikes: Int = 0 {
        didSet {
            likesLabel.text = "\(numberOfLikes) likes"
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(imageView)
        addSubview(likesLabel)

        // Layout using AutoLayout
        setupConstraints()
    }
    
    private func setupConstraints() {
        // ImageView constraints
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // LikesLabel constraints
        likesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        likesLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        likesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
