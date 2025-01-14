//
//  DetailViewController.swift
//  NasaProject
//
//  Created by Gabriel Mocelin on 12/01/21.
//

import UIKit
import AlamofireImage

final class DetailViewController: UIViewController, SceneViewController {
    typealias T = DetailPresenter
    let presenter: DetailPresenter
    let coordinator: Coordinator

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let explanationLabel = UILabel()

    private let scrollView = UIScrollView()
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, explanationLabel])

    init(coordinator: Coordinator, presenter: DetailPresenter) {
        self.coordinator = coordinator
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewConfiguration()
    }
}

extension DetailViewController: ViewConfigurator {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    func configureViews() {
        view.backgroundColor = Color.background

        if let imageURL = presenter.imageURL, let url = URL(string: imageURL) {
            imageView.af.setImage(withURL: url, cacheKey: imageURL)
        }

        titleLabel.text = presenter.title
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)

        explanationLabel.text = presenter.body.explanation
        explanationLabel.numberOfLines = 0
        explanationLabel.font = .systemFont(ofSize: 16, weight: .regular)

        stackView.axis = .vertical
        stackView.spacing = 16

        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }
}
