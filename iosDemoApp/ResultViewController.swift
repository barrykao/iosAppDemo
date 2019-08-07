//
//  ResultViewController.swift
//  iosDemoApp
//
//  Created by 高琨淯 on 2019/8/6.
//  Copyright © 2019 Kun Yu Kao. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    
    var photos = [Photo]()

    var text: String?
    var per_page: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let text = text else {return}
        self.navigationItem.title = "搜尋結果 \(text)"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (view.bounds.width - 10) / 2
        layout?.itemSize = CGSize(width: width, height: width + 80)
        fetchData()
        // Do any additional setup after loading the view.
    }
    

    
    func fetchData() {
        
        guard let text = text else {return}
        guard let page = per_page else {return}
        print(text)
        print(page)
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=b059dd83925934bf6508bbf580dc85b2&text=\(text)&per_page=\(page)&format=json&nojsoncallback=1"
        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        print(url)
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if let e = error {
                    print("error \(e)")
                }
                guard let jsonData = data else{return}
                let jsonContent = String(data: jsonData, encoding: .utf8)
                print(jsonContent)
                
                //update core data
                //NSFetchResuletController
                
                let decoder = JSONDecoder()
                do{
                    let searchData = try decoder.decode(SearchData.self, from: jsonData)
                    self.photos = searchData.photos.photo
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }catch{
                    print("error while parsing json \(error)")
                }
                
                
                
                
            }
            task.resume()
            
        }
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
extension ResultViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        let photo = photos[indexPath.item]
        cell.label.text = photo.title
        cell.imageURL = photo.imageUrl
        cell.imageView.image = nil
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == photo.imageUrl, let image = image  {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        
        
        
        return cell
        
    }
    
    
    
    
    
}
