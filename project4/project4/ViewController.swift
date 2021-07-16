//
//  ViewController.swift
//  project4
//
//  Created by Erick Vicencio on 7/14/21.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate {
    /*create a new subclass of UIViewController called ViewController and
     tell the compiler that we promise we're safe to use a WKNavigationDelegate
     */
    let thisView = UIViewController()
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "vicencio.dev"]
    override func loadView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        
        /* Delegation:
         programming pattern: way of writing code used extensively in iOS
         a delegate is one thing acting in place of another.
         this one says "when any web page navigation happens, please tell me the
         current view controller
         1) must conform to protocol (methods that need to be implemented)
         2) new methods implemented will be given control over WKWebView's behavior, any not implemented will act like default
         */
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www." + websites[1])!
        thisView.edgesForExtendedLayout = []
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        //who is the observer-self, what property we want observe, which value we want, and a context value.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // Do any additional setup after loading the view.
    }
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page... ", message: nil, preferredStyle: .actionSheet)
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem //only used on ipad to tell iOS where to anchor action sheet
        present(ac, animated: true)
        
    }
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://www." + action.title!)!
        webView.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        title = webView.title
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host{
            for website in websites{
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    /*
     Because you might call the decisionHandler closure straight away, or you might call it later on (perhaps after asking the user what they want to do), Swift considers it to be an escaping closure. That is, the closure has the potential to escape the current method, and be used at a later date.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?){
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

