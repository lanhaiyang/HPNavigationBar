## HPNavigationBar


<p align="center" >
  <img src="./README/visionGit.gif" alt="HPSlideSegmentView" title="HPSlideSegmentView">
</p>

### 继承与HPNavgationController

<p align="center" >
  <img src="./README/HPNavgationController.png" alt="HPSlideSegmentView" title="HPSlideSegmentView">
</p>

### 继承与HPNavgationBar

<p align="center" >
  <img src="./README/HPNavigationBar.png" alt="HPSlideSegmentView" title="HPSlideSegmentView">
</p>


### 在UIVIewController中使用 UIViewController+HPNavigation.h 中的扩展

```
self.hp_barBackgroundColor //修改Bar背景颜色

self.hp_barAlpha //修改Bar背景的透明度

self.hp_barEdgeLineAlpha //修改bar底部横线的透明度

self.hp_barEdgeLine //是否显示Bar底部的横线

self.hp_barHidden //是否展示Bar

self.hp_backInteraction //是否可以back 手势返回操作


```

### ** 注意 **

#### 设置UINavigationControllerDelegate `会造成失效问题`

```
self.navigationController?.delegate = self;
```

### 调用
```swift

当前在A 

A->B

- (IBAction)buttonAction:(id)sender {

	let bVC:BVC = Push(storyboardName: "BViewController", identifier: "BViewController")
 
 	bVC.hp_barBackgroundColor = UIColor.clear
 	bVC.hp_barEdgeLineAlpha = 0.01;
 	bVC.hp_barAlpha = 0.01;
 
 	self.navigationController?.pushViewController(bVC, animated: true)
    
}

//当前在B

B->C

- (IBAction)buttonAction:(id)sender {

	let cVC:CVC = Push(storyboardName: "CViewController", identifier: "CViewController")
 
 	cVC.hp_barBackgroundColor = UIColor.red
 	cVC.hp_barEdgeLineAlpha = 0.01;
 	cVC.hp_barAlpha =1;
 
 	self.navigationController?.pushViewController(cVC, animated: true)
    
}

```