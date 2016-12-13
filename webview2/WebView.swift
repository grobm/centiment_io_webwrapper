//
//  WebView.swift
//  webview2
//
//  Created by Campbell,George on 1/15/16.
//  Copyright © 2016 Campbell,George. All rights reserved.
//

import UIKit
import WebKit

class WebView : WKWebView {
    
    /**
     Initialize the WKWebView.
     */
    init(){
        let webConfig:WKWebViewConfiguration = WKWebViewConfiguration()
        super.init(frame:CGRect.zero,configuration:webConfig)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.allowsBackForwardNavigationGestures = true
        createHomePage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Set the position for the WKWebView.
     */
    func setPosition(_ view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false;
        let height = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: -100)
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item:self,attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 60)
        view.addConstraints([height, width, top])
    }
    
    /**
     Set the url the webview should display.
     */
    func setUrl(_ url:String!) {
        if url != nil {
            let url = URL(string:url)
            let request = URLRequest(url:url!)
            self.load(request)
        }
    }
    
    /**
     Create the home page.
     */
    func createHomePage() {
        self.setUrl("about:blank")
        drawHomePage()
    }
    
    /**
     Draw the home page.
     */
    func drawHomePage() {
        let javaSCriptString="document.body.style.background=\"#ffc\""
        //self.loadHTMLString("<h1>Top20</h1>", baseURL: nil)
        self.evaluateJavaScript(javaSCriptString, completionHandler: nil)
    }
    
    /**
     Go to the home page.
     */
    func setAppHome() {
        print("The first item is \(self.findFirstItem()?.url)")
        let item = findFirstItem()
        if item != nil {
            self.go(to: item!)
            drawHomePage()
        }
    }
    
    /**
     Find the first item in the list of websites.
     */
    func findFirstItem() -> WKBackForwardListItem? {
        var index=0
        if (self.backForwardList.item(at: 0)==nil) {
            return nil
        }
        while self.backForwardList.item(at: index) != nil {
            index -= 1
        }
        return self.backForwardList.item(at: index+1)
    }
    
    /**
     Handle forward navigation.
     */
    func forward() {
        if self.canGoForward {
            self.goForward()
        } else {
            print("Cannot go forward.")
        }
    }
    
    /**
     Handle backward navigation.
     */
    func back(){
        if self.canGoBack {
            self.goBack()
        } else {
            print("Cannot go backwards.")
        }
    }
    
}
