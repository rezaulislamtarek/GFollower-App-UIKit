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
    var filterFollowers: [Follower] = []
    var collectionView : UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    var hasMoreFollower : Bool = true
    var isSearching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
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
    
    private func updateData(followers : [Follower]){
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
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        
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
                if self.followers.isEmpty{
                    let message = "This user doesn't have any followers. Go follow them 😎"
                    DispatchQueue.main.async{
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(followers: self.followers)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearching ? filterFollowers[indexPath.item] : followers[indexPath.item]
        
        let destVC = UserInfoVC()
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowerListVC : UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filterFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        isSearching = true
        updateData(followers: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(followers: followers)
    }
    
    
}
