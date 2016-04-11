//
//  LeftRefreshView.swift
//  MakeTheBestOfThing
//
//  Created by Qinting on 16/4/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

import UIKit

enum LeftRefreshViewState{
case Default,Pulling,Resfreshing
}

private let kLeftRefreshViewWidth : CGFloat = 65.0

class LeftRefreshView: UIControl {

    private var scrollView : UIScrollView?
    
    private var beforeState : LeftRefreshViewState = .Default
    private var refreshState : LeftRefreshViewState = .Default{
        didSet {
            switch refreshState {
            case .Default:
                imageView.shouldAnimating = false
                if beforeState == .Resfreshing
                {
                   UIView.animateWithDuration(0.25, animations: { () in
                    var contentInset = self.scrollView!.contentInset
                    contentInset.left -= kLeftRefreshViewWidth
                    self.scrollView?.contentInset = contentInset
                    debugPrint("\(self.dynamicType) \(__FUNCTION__) \(__LINE__)")
                    
                   })
                }
            case .Pulling :
                imageView.shouldAnimating = true
                debugPrint("\(self.dynamicType) \(__FUNCTION__) \(__LINE__)")
            case .Resfreshing :
                UIView.animateWithDuration(0.25, animations: {  () in
                 var contentInset = self.scrollView!.contentInset
                    contentInset.left += kLeftRefreshViewWidth
                    self.scrollView?.contentInset = contentInset
                debugPrint("\(self.dynamicType) \(__FUNCTION__) \(__LINE__)")
                })
                
                sendActionsForControlEvents(.ValueChanged)
            }
            beforeState = refreshState
        }
    
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        if let s = newSuperview where s.isKindOfClass(UIScrollView.self){
            /** 添加监听 监听contentOffset */
        s.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
        scrollView = s as? UIScrollView
            frame = CGRectMake(-kLeftRefreshViewWidth, 0, kLeftRefreshViewWidth, CGRectGetHeight(s.bounds))
        addSubview(imageView)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let leftInset = scrollView!.contentInset.left
        let offsetX = scrollView!.contentOffset.x
        
        let criticalValue = -leftInset - CGRectGetWidth(bounds)
        
        //拖动
        if scrollView!.dragging {
            if refreshState == .Default && offsetX < criticalValue{
            //完全显示出来
                refreshState = .Pulling
            }else if refreshState == .Pulling && offsetX >= criticalValue {
            //没有完全显示出来
                refreshState = .Default
            }
            
        }else{
          //结束拖动
            if refreshState == .Pulling {
            refreshState = .Resfreshing
            }
        }
    }
    
    func endRefresh(){
    refreshState = .Default
    }
    
    deinit {
        if let s = scrollView {
        s.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    //MARK: lazy loading
    private lazy var imageView : LeftImageView = {
        let y = ( CGRectGetHeight(self.bounds) - kLeftRefreshViewWidth)*0.5 - self.scrollView!.contentInset.top - kTabBarHeight
        // 构造一个矩形 65.0 x 65.0 的imageView
        let i = LeftImageView(frame: CGRectMake(0, y, kLeftRefreshViewWidth, kLeftRefreshViewWidth))
        i.image = UIImage(named: "loading0")
        i.contentMode = .Center
        return i
    }()
    
}

private class LeftImageView : UIImageView {
    var shouldAnimating : Bool = false {
        didSet
        {
            if !isAnimating()
            {
                //下载动画
               var images = [UIImage]()
                for i in 0..<3
                {
                  images.append(UIImage(named: "loading\(i)")! )
                }
                self.animationImages = images
                self.animationDuration = 1.0
                startAnimating()
            }else{
            stopAnimating()
            }
            
        }
    }

}