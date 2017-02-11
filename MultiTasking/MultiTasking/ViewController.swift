//
//  ViewController.swift
//  MultiTasking
//
//  Created by Hikaru on 2016/07/02.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var addresBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var activeWebView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setDefaultTitle()
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWebView")
        let delete = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "deleteWebView")
        navigationItem.rightBarButtonItems = [delete,add]
    }
    
    func setDefaultTitle(){
        title = "Multi Web Browser"
    }
    
    func addWebView() {
        let webView = UIWebView()
        webView.delegate = self
        
        stackView.addArrangedSubview(webView)

        let url = NSURL(string: "http://www.yahoo.co.jp")
        webView.loadRequest(NSURLRequest(URL: url!))
        
        webView.layer.borderColor = UIColor.blueColor().CGColor
        selectWebView(webView)
        
        let recognizer = UITapGestureRecognizer(target: self, action: "webViewTapped:")
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
        
    }
    
    //userが何かのwebviewを選んだ時
    func selectWebView(webView: UIWebView){
        //まずすべてのwebviewのborderを0に
        for view in stackView.arrangedSubviews{
            view.layer.borderWidth = 0
        }
        
        //activeなviewだけボーダーを
        activeWebView = webView
        webView.layer.borderWidth = 3
        updateUIUsingWebView(webView)
        
    }

    func webViewTapped(recognizer: UITapGestureRecognizer){
        if let selectedWebView = recognizer.view as? UIWebView{
            selectWebView(selectedWebView)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizerotherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let webView = activeWebView, address = addresBar.text {
            if let url = NSURL(string: address){
                webView.loadRequest(NSURLRequest(URL: url))
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func deleteWebView(){
        //safely unwrap our webview
        if let webView = activeWebView {
            if let index = stackView.arrangedSubviews.indexOf(webView){
                //we found the current webview in the stack view! remove it from the stack view
                stackView.removeArrangedSubview(webView)
                
                //now remove it from the view hierarchy - this is important!
                webView.removeFromSuperview()
                
                if stackView.arrangedSubviews.count == 0 {
                    //go back to our default UI
                    setDefaultTitle()
                } else {
                    //convert the index value into an integer
                    var currentIndex = Int(index)

                    //if that was the last web view in the stack, go back one
                    if currentIndex == stackView.arrangedSubviews.count {
                        currentIndex = stackView.arrangedSubviews.count - 1
                    }
                    
                    //find the web view at the new index and select it
                    if let newSelectedWebView = stackView.arrangedSubviews[currentIndex] as? UIWebView {
                        selectWebView(newSelectedWebView)
                    }
                }
            }
        }
        
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.horizontalSizeClass == .Compact {
            stackView.axis = .Vertical
        } else {
            stackView.axis = .Horizontal
        }
    }
    
    func updateUIUsingWebView(webView: UIWebView){
        title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        addresBar.text = webView.request?.URL?.absoluteString ?? ""
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView == activeWebView {
            updateUIUsingWebView(webView)
        }
    }
}

