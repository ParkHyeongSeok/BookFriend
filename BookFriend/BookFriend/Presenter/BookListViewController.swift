//
//  BookListViewController.swift
//  BookFriend
//
//  Created by 박형석 on 2021/12/05.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SafariServices

class BookListViewController: UIViewController, StoryboardView {
    
    let searchController: UISearchController = {
       let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "검색어를 입력해 주세요."
        sc.hidesNavigationBarDuringPresentation = true
        sc.automaticallyShowsCancelButton = true
        return sc
    }()
    
    let activityView: UIActivityIndicatorView = {
       let av = UIActivityIndicatorView()
        av.hidesWhenStopped = true
        return av
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 15
        layout.sectionInset.right = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(QueryCollectionViewCell.self, forCellWithReuseIdentifier: QueryCollectionViewCell.identifier)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        makeConstraints()
    }
    
    private func configurationUI() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "책 검색"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func makeConstraints() {
        view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        
    }
    
    func bind(reactor: BookListReactor) {
        
        tableView.rx.sentMessage(#selector(tableView.reloadData))
//            .debounce(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .bind(onNext: { _ in
                print("before reload")
            })
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.books }
            .bind(to: tableView.rx.items(cellIdentifier: BookListTableViewCell.identifier, cellType: BookListTableViewCell.self)) { index, item, cell in
                cell.updateUI(book: item)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.queryList }
            .bind(to: collectionView.rx.items(
                    cellIdentifier: QueryCollectionViewCell.identifier,
                    cellType: QueryCollectionViewCell.self)) { index, item, cell in
                cell.updateUI(query: item)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            tableView.rx.itemSelected,
            tableView.rx.modelSelected(BookEntity.self))
            .bind { [unowned self] (indexPath, book) in
                self.tableView.deselectRow(at: indexPath, animated: false)
                self.navigateNewPage(book: book) {
                    reactor.action.onNext(.searchButtonClicked("newQuery"))
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                }
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            collectionView.rx.itemSelected,
            collectionView.rx.modelSelected(String.self))
            .bind { [unowned self] indexPath, query in
                self.collectionView.deselectItem(at: indexPath, animated: false)
                reactor.action.onNext(.searchButtonClicked(query))
            }
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .map { BookListReactor.Action.inputQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked
            .map { BookListReactor.Action.cancelButtonClicked }
            .bind(onNext: {
                reactor.action.onNext(BookListReactor.Action.updateBooks(true))
            })
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.searchButtonClicked
            .map { BookListReactor.Action.searchButtonClicked(nil) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    func navigateNewPage(book: BookEntity, completion: (() -> Void)? = nil) {
        guard let url = book.link else { return }
        let sv = SFSafariViewController(url: url)
        self.present(sv, animated: true, completion: completion)
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let query = reactor?.currentState.queryList[indexPath.item] else { return .zero }
        let cellSize = QueryCollectionViewCell.fittingSize(availableHeight: 30, query: query)
        return cellSize
    }
}

