//
//  XTIBaseViewController.swift
//  XTIBaseUIKit
//
//  Created by xtinput on 2021/5/10.
//

import UIKit

open class XTIBaseViewController: UIViewController, UICollectionViewDataSource {
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutTableView()
        self.layoutCollectionView()
    }

    /// 如果TableView或CollectionView是使用自动布局请把该属性设置为true，不然在屏幕旋转后不会调用相关的layout方@objc @objc 法
    public var isAutoLayout: Bool = false

    // MARK: - : TableView

    public var tableViewStyle: UITableView.Style? {
        willSet {
            assert(self.tableViewStyle == nil, "tableViewStyle不能重复赋值")
        }
        didSet {
            assert(self.tableViewStyle != nil, "tableViewStyle不能为nil")
            self.deployTableView()
        }
    }

    /// 请在加载tableView之前定义tableViewStyle
    public lazy var tableView: UITableView = {
        assert(self.tableViewStyle != nil, "请给tableViewStyle赋值")
        let tempTableView = UITableView(frame: .zero, style: self.tableViewStyle!)
        tempTableView.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            tempTableView.contentInsetAdjustmentBehavior = .never
        }
        tempTableView.tableFooterView = UIView()
        tempTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        return tempTableView
    }()

    // MARK: - : CollectionView

    public var flowLayout: UICollectionViewLayout? {
        willSet {
            assert(self.flowLayout == nil, "flowLayout只能设置一次")
        }
        didSet {
            assert(self.flowLayout != nil, "flowLayout不能为nil")
            self.deployCollectionView()
        }
    }

    public lazy var collectionView: UICollectionView = {
        assert(self.flowLayout != nil, "必须设置flowLayout")
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout!)
        tempCollectionView.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            tempCollectionView.contentInsetAdjustmentBehavior = .never
        }
        tempCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell")
        return tempCollectionView
    }()
}

/// 如果需要使用tableView，请在viewDidLoad里调用layoutAndDeployTableView，
extension XTIBaseViewController: UITableViewDelegate, UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    }

    /// tableView布局和设置代理
    @objc open func deployTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        if self.tableView.superview == nil {
            self.view.addSubview(self.tableView)
        }
    }

    @objc open func layoutTableView() {
        if !self.isAutoLayout && self.tableViewStyle != nil {
            self.tableView.frame = self.view.bounds
        }
    }
}

extension XTIBaseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @objc open func deployCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        if self.collectionView.superview == nil {
            self.view.addSubview(self.collectionView)
        }
    }

    @objc open func layoutCollectionView() {
        if !self.isAutoLayout && self.flowLayout != nil {
            self.collectionView.frame = self.view.bounds
        }
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
}
