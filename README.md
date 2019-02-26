# TenLock
IOS项目-十之锁
## 玩法介绍
- 将小球拖动到空洞位置，使得每条线上的数字之和为10，视为获得胜利
## 所学技术
1. swift语法巩固
2. swift的代理使用
3. swift和objective-c混合编程
4. swift对plist的操作
5. swift`uiview.animation`的使用
6. uiscrollview的使用拓展
7. swift单例的使用
8. uiview的拖动事件
9. swift帧动画
10. 获取当前view的viewcontroller
    ```objc
    //获取viewcontroller
    func parentViewController() -> UIViewController? {
        
        var n = self.next
        
        while n != nil {
            
            if (n is UIViewController) {
                
                return n as? UIViewController
            }
            
            n = n?.next
        }
        
        return nil
    }
    ```

## 所用资源
1. 来自[爱给网](http://www.aigei.com/)的图片和音频
2. 公司美工辛苦劳动的作品
