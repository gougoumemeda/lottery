//
//  ViewController.swift
//  lottery
//
//  Created by 钩钩么么哒 on 15/2/6.
//  Copyright (c) 2015年 钩钩么么哒. All rights reserved.
//

import UIKit

class lotteryViewController: UIViewController {

    var data:[Int] = []
    var judge:[Bool] = []
    
    var times:Int = 10
    var upperBound:Int = 500
    var hasSelected = 0
    
    var label:[UILabel?] = []
    
    var numTextField: UITextField? //一次抽出的数量
    var totalTextField: UITextField? //总共的数字
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        addLabel()
        addtextField()
        initdata()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        numTextField?.resignFirstResponder()
        totalTextField?.resignFirstResponder()
    }

    func addtextField(){
        totalTextField = UITextField(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        totalTextField?.center = CGPoint(x: self.view.frame.size.width / 2, y: 100)
        totalTextField?.textAlignment = NSTextAlignment.Center
        totalTextField?.placeholder = "点我修改数字的上限(最大1000000,不可修改)"
        self.view.addSubview(totalTextField!)
        
        numTextField = UITextField(frame: CGRectMake(0, 0, self.view.frame.size.width, 20))
        numTextField?.center = CGPoint(x: self.view.frame.size.width / 2, y: 120)
        numTextField?.textAlignment = NSTextAlignment.Center
        numTextField?.placeholder = "点我修改抽出的数量(最大20)"
        self.view.addSubview(numTextField!)
    }
    
    func addButton(){
        var button:UIButton = UIButton(frame: CGRectMake(0, 0, self.view.frame.size.width / 2 - 20, 50))
        button.center = CGPoint(x: self.view.frame.size.width / 4, y: 485)
        button.backgroundColor = UIColor(red: 189.0/255, green: 252.0/255, blue: 201.0/255, alpha: 1)
        button.setTitle("抽奖", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "choujiang:", forControlEvents: UIControlEvents.TouchUpInside)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        self.view.addSubview(button)
        
        var reset:UIButton = UIButton(frame: CGRectMake(0, 0, self.view.frame.size.width / 2 - 20, 50))
        reset.center = CGPoint(x: self.view.frame.size.width / 4 * 3, y: 485)
        reset.backgroundColor = UIColor(red: 189.0/255, green: 252.0/255, blue: 201.0/255, alpha: 1)
        reset.setTitle("重置(清空所有数据)", forState: UIControlState.Normal)
        reset.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        reset.addTarget(self, action: "reset:", forControlEvents: UIControlEvents.TouchUpInside)
        reset.clipsToBounds = true
        reset.layer.cornerRadius = 10.0
        self.view.addSubview(reset)
    }
    
    func addLabel(){
        var logo:UILabel = UILabel(frame: CGRectMake(0, 0, 400, 200))
        logo.center = CGPoint(x: self.view.frame.size.width / 2, y: 60)
        logo.text = "抽奖"
        logo.textAlignment  = NSTextAlignment.Center
        logo.textColor = UIColor.redColor()
        logo.font = UIFont.boldSystemFontOfSize(28)
        self.view.addSubview(logo)
        
        for var i = 0; i < 20; ++i{
            var resLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width / 2 - 20, 30))
            var height:CGFloat = 160 + CGFloat((31 * Int(i / 2)))
            var width:CGFloat = self.view.frame.size.width / 4 * CGFloat(1 + (i % 2 * 2))
            resLabel.center = CGPoint(x: width, y: height)
            resLabel.text = "我是抽奖框"
            resLabel.textAlignment = NSTextAlignment.Center
            resLabel.font = UIFont.systemFontOfSize(14)
            resLabel.textColor = UIColor.grayColor()
            resLabel.layer.borderColor = UIColor.redColor().CGColor
            resLabel.layer.borderWidth = 0.5
            resLabel.layer.cornerRadius = 3
            self.label.append(resLabel)
            self.view.addSubview(resLabel)
        }
    }
    
    func choujiang(sender:UIButton){
        if (judgeData(numTextField!.text) && judgeData(totalTextField!.text)){
            totalTextField?.enabled = false
            times = numTextField!.text.toInt()!
            upperBound = totalTextField!.text.toInt()!
            clearLabel()
            for var count = 0;count < times;{
                var randomdata = Int(arc4random()) % (upperBound)
                if self.hasSelected == self.upperBound{
                    var alert = UIAlertView(title: "警告", message: "所有数字已经抽完", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                    break
                }
                else if judge[randomdata] == true{
                    continue
                }else{
                    judge[randomdata] = true
                    label[count]!.text = String(data[randomdata])
                    ++count
                    ++self.hasSelected
                }
            }
            
        }else{
            var alert = UIAlertView(title: "警告", message: "请输入正确的数字", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    
    func clearLabel(){
        for each in self.label{
            each?.text = "我是抽奖框"
        }
    }
    
    func judgeData(text:String) -> Bool{
        if text == ""{
            return false
        }
        var res = text.utf8
        for each in res{
            if (each < 48 || each > 57){
                return false
            }
        }
        return true
    }
    
    func reset(sender:UIButton){
        clearLabel()
        self.hasSelected = 0
        self.totalTextField?.enabled = true
        for var i = 0; i < upperBound; ++i{
            judge[i] = false
        }
        self.totalTextField?.text = ""
        self.numTextField?.text = ""
    }
    
    
    func initdata(){
        for var i = 1; i <= 1000000; ++i{
            data.append(i)
            judge.append(false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
