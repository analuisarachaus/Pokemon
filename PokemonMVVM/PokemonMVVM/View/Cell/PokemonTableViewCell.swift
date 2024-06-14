//
//  PokemonTableViewCell.swift
//  PokemonMVVM
//
//  Created by Ana Luisa Rachaus on 12/06/24.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    var viewModel: PokemonCellViewModel? {
        didSet {
            configureCell()
        }
    }

    private lazy var imagePokemon: UIImageView = {
        let imagePokemon = UIImageView()
        imagePokemon.translatesAutoresizingMaskIntoConstraints = false
        imagePokemon.contentMode = .scaleAspectFit
        imagePokemon.layer.cornerRadius = 12
        imagePokemon.layer.masksToBounds = true
        return imagePokemon
    }()

    private lazy var namePokemon: UILabel = {
        let namePokemon = UILabel()
        namePokemon.translatesAutoresizingMaskIntoConstraints = false
        namePokemon.textColor = .systemYellow
        namePokemon.font = .boldSystemFont(ofSize: 25)
        namePokemon.numberOfLines = 0
        return namePokemon
    }()

    private func addSubview() {
        addSubview(imagePokemon)
        addSubview(namePokemon)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imagePokemon.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imagePokemon.heightAnchor.constraint(equalToConstant: 160),
            imagePokemon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imagePokemon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200),

            namePokemon.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            namePokemon.leadingAnchor.constraint(equalTo: imagePokemon.trailingAnchor, constant: 5),
            namePokemon.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func configureCell() {
        Task {
            guard let imageData = await viewModel?.fetchImage() else { return }
            Task { @MainActor in
                imagePokemon.image = UIImage(data: imageData)
            }
        }

        namePokemon.text = viewModel?.pokemon.name.capitalized
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
