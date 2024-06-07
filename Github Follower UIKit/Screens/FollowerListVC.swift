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
    var page = 1
    var hasMoreFollower : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        configureCollectionView()
        getFollowers(page: page)
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
            self.dataSource.apply(spanshot, animatingDifferences: true)
        }
        
    }
    
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    
    
    
    private func getFollowers(page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in

            guard let self = self  else { return }
            self.dismissLoadingView()
            switch result{
            case .success(let followers):
                if followers.count < 100 { hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
                print(followers.count)
            case .failure(let error):
                self.presentGFAlert(title: "Error", message: error.rawValue, butttonTitle: "Ok")
            }
            
        }
    }
    
}


extension FollowerListVC : UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        if offsetY > (contentHight - height)/2 {
            // end of the scrollview
            print("reached end")
            if hasMoreFollower{
                page += 1
                getFollowers(page: page)
            }
        }
        
    }
}
