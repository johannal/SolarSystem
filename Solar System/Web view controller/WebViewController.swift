//
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progressIndicator.startAnimating()
        self.webView.navigationDelegate = self
                
        if let url = self.url {
            self.webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.doneLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.doneLoading()
    }
    
    private func doneLoading() {
        self.webView.isHidden = false
        self.progressIndicator.stopAnimating()
        
        // Hack to quickly dismiss the web view controller, since automating UI with web views is extremely slow
        if let _ = ProcessInfo.processInfo.environment["TESTING_ENVIRONMENT"] {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.parent?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
