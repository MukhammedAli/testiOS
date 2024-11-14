//
//  MovieTableViewCell.swift
//  testiOS
//
//  Created by  Mukhammed Ali Khamzayev on 14.11.2024.
//

import Kingfisher
import SnapKit
import UIKit

final class MovieTableViewCell: UITableViewCell {
    struct Constants {
        static let imageURL = "https://movies-tv-shows-database.p.rapidapi.com/?movieid="
    }
 
    static let identifier = "MovieTableViewCell"

    private let titleLabel: UILabel  = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with model: Movie) {
        titleLabel.text = model.title
    }
    
    private func setup() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(16)
        }
    }
}
