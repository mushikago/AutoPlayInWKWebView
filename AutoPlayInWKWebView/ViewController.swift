//
//  ViewController.swift
//  AutoPlayInWKWebView
//
//  Created by Tetsuya Shiraishi on 2015/06/24.
//  Copyright (c) 2015年 Tetsuya Shiraishi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    let wkwv:WKWebView = WKWebView(frame: CGRectMake(0, 0, 300, 300), configuration: WKWebViewConfiguration())
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wkwv.navigationDelegate = self
        
        
//        let _path:String = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "sound")!
        let _path:String = "http://adobe.com"
        wkwv.loadRequest(NSURLRequest(URL: NSURL(string: _path)!))
        
        self.view.addSubview(wkwv)
        
        //estimatedProgress
        wkwv.addObserver(self, forKeyPath:"estimatedProgress", options:.New, context:nil)
        
    }
    
    deinit {
        wkwv.removeObserver(self, forKeyPath: "estimatedProgress")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        switch keyPath {
        case "estimatedProgress":
            if let progress = change[NSKeyValueChangeNewKey] as? Float {
                println("loaded:\(progress)")
            }
        default:
            break
        }
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        println("didFinishNavigation")
    }
    
}

