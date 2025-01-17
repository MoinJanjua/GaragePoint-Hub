import UIKit
import SideMenu

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let imagesList = ["Trendingimg1","Trendingimg2","Trendingimg3","Trendingimg4","Trendingimg5","Trendingimg6"]
    let titleList = [
        "Artistic Wallpapers",
        "AI-Generated Designs",
        "Trending Artworks",
        "Premium Selections",
        "Latest Creations",
        "Elegant Dark Themes"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
       
        // Register the custom cell
    }
    
    @IBAction func settingsbtnPressed(_ sender: UIButton) {
        
        let Menu = storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigation") as? SideMenuNavigationController
        Menu?.leftSide = true
        Menu?.settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController = Menu
        present(Menu!, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.titleImage.image = UIImage(named: imagesList[indexPath.row])
        cell.titleLb.text = titleList[indexPath.row]
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.systemYellow.cgColor
        cell.contentView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let availableWidth = collectionViewWidth - (spacing * 3)
        let width = availableWidth / 2
        return CGSize(width: width - 20, height: width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 1
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "AI Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 2
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "Trending Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 3
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "Top Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 4
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "Latest Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 5
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController") as! RecordViewController
            newViewController.isFromHomeName = "Black Wallpaper"
            newViewController.titlestr = titleList[indexPath.row]
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}


extension HomeViewController
{
    private func makeSettings() -> SideMenuSettings
    {
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        presentationStyle.presentingEndAlpha = 0.5
        var settings = SideMenuSettings()
        settings.menuWidth = 260.0
        settings.presentationStyle = presentationStyle
        return settings
    }
}
