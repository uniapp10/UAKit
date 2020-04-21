//
//  Table.swift
//  SimilarPro
//
//  Created by ZD on 2020/2/25.
//  Copyright © 2020 ZD. All rights reserved.
//

import UIKit

public protocol TableCellModel {
    var clazz: String { get set }
    var height: CGFloat { get set }
}

public typealias TableAction = (_ type: String, _ info: Any?, _ indexPath: IndexPath?) -> ()
 
public enum TableActionType: String {
    case selected
}

open class TableCell: UITableViewCell {
    
    public var action: ((String, Any?, IndexPath?) -> ())?
    public var indexPath: IndexPath!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupLayout()
        setupActions()
    }
    
    open func setupUI() {
        
    }
    
    open func setupLayout() {
        
    }
    
    open func setupActions() {
        
    }
    
    open class func height(data: TableCellModel?) -> CGFloat {
        return data?.height ?? 0.0
    }
    
    open func refresh(data: TableCellModel) {
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
public class Table: UIView {
    
    public var view: UITableView!
    
    public var action: TableAction?
    
    public var automaticHeight: Bool = false {
        didSet {
            if automaticHeight {
                view.rowHeight = UITableView.automaticDimension
                view.estimatedRowHeight = 100
                view.estimatedSectionFooterHeight = 100
                view.estimatedSectionHeaderHeight = 100
            }
        }
    }
    public var data: [[TableCellModel]] = [[]] {
        didSet {
            if !isUploading {
                view.reloadData()
            }
        }
    }
    private var isUploading: Bool = false
    public var canMove: Bool = false
    public var rowHeight: ((_ indexPath: IndexPath) -> CGFloat?)?
    public var headerView: ((_ section: Int)->UIView?)?
    public var headerHeight: ((_ section: Int)->CGFloat)?
    public var footerView: ((_ section: Int)->UIView?)?
    public var footerHeight: ((_ section: Int)->CGFloat)?
    //scrollView callback
    public var scrollViewDidScrollCallback: ((_ scrollView: UIScrollView) -> Void)?
    public var cellWillDispaly: ((UITableViewCell) -> Void)?
    public var didEndDisplaying: ((_ cell: UITableViewCell,_ indexPath: IndexPath) -> Void)?
    
    public init(frame: CGRect, style: UITableView.Style = .plain) {
        super.init(frame: frame)
        
        view = UITableView(frame: frame, style: style)
        setupUI()
    }
    
    func setupUI() {
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        
        view.estimatedRowHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.estimatedSectionHeaderHeight = 0
        
        self.addSubview(view)
        self.addConstraints([NSLayoutConstraint(item: view,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .left,
                                                multiplier: 1.0,
                                                constant: 0),
                             NSLayoutConstraint(item: view,
                                                attribute: .top,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: 0),
                             NSLayoutConstraint(item: view,
                                                attribute: .width,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .width,
                                                multiplier: 1.0,
                                                constant: 0),
                             NSLayoutConstraint(item: view,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .height,
                                                multiplier: 1.0,
                                                constant: 0)])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public extension Table {
    // 更新section的数据
    func reloadSection(section: Int, data: [TableCellModel]) {
        isUploading = true
        self.data[section] = data
        view.reloadSections(IndexSet.init(integer: section), with: .automatic)
        isUploading = false
    }
    // 更新row的数据
    func reloadRow(indexPath: IndexPath,data:TableCellModel) {
        isUploading = true
        self.data[indexPath.section][indexPath.row] = data
        view.reloadRows(at: [indexPath], with: .automatic)
        isUploading = false
    }
    // 插入多行
    func insertRows(indexPaths: [IndexPath], data: [TableCellModel]) {
        isUploading = true
        for (index, indexPath) in indexPaths.enumerated() {
            self.data[indexPath.section].insert(data[index], at: indexPath.row)
        }
        view.insertRows(at: indexPaths, with: .automatic)
        isUploading = false
    }
    // 删除多行
    func deleteRows(indexPaths: [IndexPath], data: [[TableCellModel]], animation: UITableView.RowAnimation = .automatic) {
        isUploading = true
        for (_, indexPath) in indexPaths.enumerated() {
            self.data[indexPath.section].remove(at: indexPath.row)
        }
        view.deleteRows(at: indexPaths, with: animation)
        isUploading = false
    }
    // 插入section
    func insertSection(section: Int, data: [TableCellModel]) {
        isUploading = true
        self.data.insert(data, at: section)
        view.insertSections(IndexSet.init(integer: section), with: .automatic)
        isUploading = false
    }
}

extension Table: UITableViewDataSource, UITableViewDelegate {
    private func getCellClass(name: String) -> UITableViewCell.Type? {
        if let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
            let className = clsName + "." + name
            if let cellC = NSClassFromString(className) as? UITableViewCell.Type {
                return cellC
            }
            return nil
        }
        return nil
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.automaticHeight {
            return UITableView.automaticDimension
        }
        if let heightHandler = self.rowHeight, let height = heightHandler(indexPath) {
            return height
        }
        if let c = getCellClass(name: data[indexPath.section][indexPath.row].clazz) as? TableCell.Type {
            return c.height(data:data[indexPath.section][indexPath.row])
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = data[indexPath.section][indexPath.row].clazz
        if let c = getCellClass(name: data[indexPath.section][indexPath.row].clazz) {
            var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
            if cell == nil || !cell!.isKind(of: c) {
                cell = c.init(style: .default, reuseIdentifier: cellId)
            }
            (cell as? TableCell)?.action = { [weak self] (type: String, info: Any?, cellIndex: IndexPath?) in
                self?.action?(type, info, cellIndex ?? indexPath)
            }
            (cell as? TableCell)?.indexPath = indexPath
            
            (cell as? TableCell)?.refresh(data: data[indexPath.section][indexPath.row])
            return cell!
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let c = cell as? TableCell {
            self.cellWillDispaly?(c)
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView?(section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.footerView?(section)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {       
        return self.footerHeight?(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.action?(TableActionType.selected.rawValue ,self.data[indexPath.section][indexPath.row], indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.canMove
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        isUploading = true
        var section = self.data[sourceIndexPath.section]
        let item = section[sourceIndexPath.row]
        section.remove(at: sourceIndexPath.row)
        self.data[sourceIndexPath.section] = section
        section = self.data[destinationIndexPath.section]
        section.insert(item, at: destinationIndexPath.row)
        self.data[destinationIndexPath.section] = section
        isUploading = false
        self.action?("DragAction", destinationIndexPath, sourceIndexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.didEndDisplaying?(cell, indexPath)
    }
    
    // scrollview
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewDidScrollCallback?(scrollView)
    }
}
