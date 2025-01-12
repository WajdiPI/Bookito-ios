//
//  GoodReadsViewController.swift
//  Bookito
//
//  Created by Katsu on 16/07/2019.
//  Copyright © 2019 Katsu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class GoodReadsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var tvShowArray : NSArray = []
    var id:String?
    
    @IBOutlet weak var tableview: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.viewWithTag(0)
        let img = contentView?.viewWithTag(1) as! UIImageView
        let titre = contentView?.viewWithTag(2) as! UILabel
        let saison = contentView?.viewWithTag(3) as! UITextView
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
        let tvShowDict = tvShowArray[indexPath.row] as! Dictionary<String, Any>
        titre.text = tvShowDict["author"] as? String
        
        saison.text = tvShowDict["review"] as? String
        let imgs = tvShowDict["image"] as? String
        print(titre.text)
        print(imgs)
        print("-------------")
        img.af_setImage(withURL: URL(string: imgs!)!)
       
        return cell!
    }
    
    
    
      // python webService
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://127.0.0.1:5000/"+id!).responseJSON{ response in
            self.tvShowArray = response.result.value as! NSArray
            
            self.tableview.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
