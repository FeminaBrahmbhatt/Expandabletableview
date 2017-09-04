//
//  ViewController.swift
//  Expandable Tableview
//
//  Created by Femina Rajesh Brahmbhatt on 03/09/17.
//  Copyright © 2017 Femina Brahmbhatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tbl: UITableView!
    var sectionarr = NSArray()
    var boolarr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sectionarr = ["India","Srilanka","Singapore","Dubai"]
        
        for _ in 0...sectionarr.count {
            boolarr.add(false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Pragma Mark :- Tableview Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionarr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section+2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellidentifier = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellidentifier)
        }
        
        let collapsed = boolarr.object(at: indexPath.section) as! Bool
        
        if collapsed {
            cell?.textLabel?.text = "Section \(indexPath.section)- Row \(indexPath.row)"
            
        }
        else{
            cell?.textLabel?.text = ""
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lbl_header = UILabel.init(frame: CGRect(x:15,y:0,width:tableView.frame.size.width-15,height:50))
        
        lbl_header.text = sectionarr.object(at: section) as? String
        lbl_header.tag = section
        lbl_header.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target:self , action:#selector(sectiontapped(gesture:)))
        lbl_header.addGestureRecognizer(tap)
        lbl_header.textAlignment = NSTextAlignment.center
        lbl_header.backgroundColor = UIColor.red
        lbl_header.textColor = UIColor.white
        switch section {
        case 0,2:
            lbl_header.backgroundColor = UIColor.lightGray
        default:
            lbl_header.backgroundColor = UIColor.darkGray
        }
        return lbl_header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if boolarr.object(at: indexPath.section) as! Bool==true {
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.boolarr.replaceObject(at: indexPath.section, with: false)
        
        tbl.reloadSections(IndexSet(integer:indexPath.section), with: UITableViewRowAnimation.automatic)
    }
    

    @objc func sectiontapped(gesture:UITapGestureRecognizer) -> Void {
    var indexPath = IndexPath(row: 0, section: (gesture.view?.tag)!)
    
        if indexPath.row == 0 {
            
            let collapsed = boolarr.object(at: indexPath.section) as! Bool
            
            for i in 0...sectionarr.count{
                
                if indexPath.section == i{

                    self.boolarr.replaceObject(at: indexPath.section, with: !collapsed)
                    
                }
                
            }
            
            tbl.reloadSections(IndexSet(integer:indexPath.section), with: UITableViewRowAnimation.automatic)
        }
    
    }
    
}

