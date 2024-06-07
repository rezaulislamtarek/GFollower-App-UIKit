//
//  FollowerListVCViewController.swift
//  Github Follower UIKit
//
//  Created by Rezaul Islam on 5/6/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section{ case main }
    
    var userName : String!
    var followers: [Follower] = []
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(){
        var spanshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        spanshot.appendSections([.main])
        spanshot.appendItems(followers)
        DispatchQueue.main.async {
            self .dataSource.apply(spanshot, animatingDifferences: true)
        }

    }
    
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
   
    
    
    private func getFollowers(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] result in
            guard let self = self  else { return }
            switch result{
            case .success(let followers):
                self.followers = followers
                self.updateData()
                print(followers.count)
            case .failure(let error):
                self.presentGFAlert(title: "Error", message: error.rawValue, butttonTitle: "Ok")
            }
            
        }
    }
    
}
