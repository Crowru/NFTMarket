//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Руслан  on 06.11.2023.
//

import UIKit

protocol CollectionViewControllerProtocol: AnyObject {
    // MARK: In progress
}

final class CollectionViewController: UIViewController & CollectionViewControllerProtocol {
    
    var collections: CollectionModel
    
    init(collections: CollectionModel) {
        self.collections = collections
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Const {
        static let cellMargins: CGFloat = 9
        static let lineMargins: CGFloat = 8
        static let cellCols: CGFloat = 3
        static let cellHeight: CGFloat = 192
        static let sideMargins: CGFloat = 16
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let coverImage: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.image = UIImage(named: "Beige")
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Beige"
        label.textColor = .black
        return label
    }()
    
    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.text = "Автор коллекции:"
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = "John Doe"
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей."
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.dataSource = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.delegate = self
        
       
       
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
        
    private func setupNavigationBar() {
        let backItem = UIBarButtonItem()
        backItem.title = nil
        backItem.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    func setupAll() {
        let urlString = collections.cover.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        coverImage.kf.setImage(with: url, placeholder: UIImage(named: "Catalog.nulImage"))
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        setupScrollView()
        scrollView.addSubviews(coverImage, nameLabel, authorTitleLabel, authorNameLabel, descriptionLabel, collectionView)
        
        setupCoverImage()
        setupNameLabel()
        setupAuthorTitleLabel()
        setupAuthorNameLabel()
        setupDescriptionLabel()
        setupCollectionView()
        
        let collectionHeight = (Const.cellHeight + Const.lineMargins) * ceil(CGFloat(21) / Const.cellCols)
              collectionView.heightAnchor.constraint(equalToConstant: collectionHeight).isActive = true
}
    
    private func setupScrollView() {
        view.addSubviews(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupCoverImage() {
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImage.heightAnchor.constraint(equalToConstant: 310),
            coverImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNameLabel() {
        scrollView.addSubviews(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.sideMargins)
        ])
    }
    
    private func setupAuthorTitleLabel() {
        NSLayoutConstraint.activate([
            authorTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
            authorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.sideMargins)
        ])
    }
    
    private func setupAuthorNameLabel() {
        authorNameLabel.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapUserNameLabel(_:)))
        authorNameLabel.addGestureRecognizer(guestureRecognizer)
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: authorTitleLabel.topAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorTitleLabel.trailingAnchor, constant: 4),
            authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -Const.sideMargins)
        ])
    }
    
    private func setupDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.sideMargins),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.sideMargins)
        ])
    }
    
    @objc
    func didTapUserNameLabel(_ sender: Any) {

    }
    
    private func setupCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Const.sideMargins),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Const.sideMargins),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCell.identifier,
            for: indexPath
        ) as? CollectionCell else {
            assertionFailure("Error get cell")
            return .init()
        }
        
        
        cell.configure()
        

        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = floor((collectionView.frame.width - Const.cellMargins * (Const.cellCols - 1)) / Const.cellCols)
            return CGSize(width: width, height: Const.cellHeight)
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return Const.cellMargins
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.lineMargins
    }
}

extension CollectionViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
