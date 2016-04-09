//
//  MyFirstTableViewController.swift
//  Quiz
//
//  Created by Nikolay Shubenkov on 09/04/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import UIKit

class MyFirstTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model:[String]  = {
        var aLotOfStrings = "An instance of UITableView (or simply, a table view) is a means for displaying and editing hierarchical lists of information. A table view displays a list of items in a single column. UITableView is a subclass of UIScrollView, which allows users to scroll through the table, although UITableView allows vertical scrolling only. The cells comprising the individual items of the table are UITableViewCell objects;        UITableView uses these objects to draw the visible rows of the table. Cells have content—titles and images—and can have, near the right edge, accessory views. Standard accessory views are disclosure indicators or detail disclosure buttons; the former leads to the next level in a data hierarchy and the latter leads to a detailed view of a selected item. Accessory views can also be framework controls, such as switches and sliders, or can be custom views. Table views can enter an editing mode where users can insert, delete, and reorder rows of the table. A table view is made up of zero or more sections, each with its own rows. Sections are identified by their index number within the table view, and rows are identified by their index number within a section. Any section can optionally be preceded by a section header, and optionally be followed by a section footer.        Table views can have one of two styles, UITableViewStylePlain and UITableViewStyleGrouped. When you create a UITableView instance you must specify a table style, and this style cannot be changed. In the plain style, section headers and footers float above the content if the part of a complete section is visible. A table view can have an index that appears as a bar on the right hand side of the table (for example,  through ). You can touch a particular label to jump to the target section. The grouped style of table view provides a default background color and a default background view for all cells. The background view provides a visual grouping for all cells in a particular section. For example, one group could be a person's name and title, another group for phone numbers that the person uses, and another group for email accounts and so on. See the Settings application for examples of grouped tables. Table views in the grouped style cannot have an index.".componentsSeparatedByString(". ")
        print("strings count is \(aLotOfStrings.count)")
        return aLotOfStrings
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //для того, чтобы TableView смог наполнить себя элементами, о которых он не знает ничего, нужно стать для него DataSource и реализовать этот протокол
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
}

extension MyFirstTableViewController: UITableViewDataSource{
    
    //Сколько ячеек должно быть в TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("tableView asked cells count")
        return model.count
    }
    
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "StringCell"
        
        //Запросить у TableView ячейку, прототип который называется StringCell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    
        //row - это номер строки
        let stringIndex = indexPath.row
        let section     = indexPath.section
        
        //получим строку по конкретному индексу ячейки
        cell?.textLabel?.text = model[stringIndex]
        
        print("tableView asked cell for index: \(indexPath)")
        
        return cell!
    }
}















