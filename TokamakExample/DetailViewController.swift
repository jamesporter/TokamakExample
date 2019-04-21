import UIKit
import WebKit

final class DetailViewController: UIViewController {
    var update: Update?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        if let u = update {
            self.title = update?.title
            webView.load((URLRequest(url: URL(string: u.uri )!)))
        }
    }
    
}
