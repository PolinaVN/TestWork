//
//  GalleryImagesViewController.swift
//  TestWork
//
//  Created by Polina on 09.03.2022.
//

import UIKit

final class GalleryImagesViewController: UIViewController {
    
    // MARK: - Visual Components
    private var collectionview: UICollectionView!
    
    // MARK: - Private Properties
    private var cellID = "DetailImageCell"
    private var presenter: GalleryImagesPresenter?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter = GalleryImagesPresenter(view: self)
    }
    
    // MARK: - Private Methods
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ImageCell.self, forCellWithReuseIdentifier: cellID)
        collectionview.showsVerticalScrollIndicator = false
        view.addSubview(collectionview)
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryImagesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailImageViewController()
        guard let imageObject = presenter?.imagesResponse[indexPath.row] else {return}
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else {return}
        let image = cell.showCaseImageView.image
        vc.showCaseImageView.image = image
        vc.presenter = DetailImagePresenter(view: vc.self, image: imageObject)
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.imagesResponse.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? ImageCell, let presenter = presenter else {return UICollectionViewCell()}
        cell.configureCell(index: indexPath.row, presenter: presenter)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

// MARK: - GalleryImagesView
extension GalleryImagesViewController: GalleryImagesView {
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
}
