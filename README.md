# LMComposeView

[原理详细讲解地址](https://www.jianshu.com/p/02e361fcb1ca)

你是否需要实现一个这种UITableView或UICollectionView(也可以是仅有其中一类)混合公用HeaderView的界面呢？大致效果如下方Demo动态图的效果：<br>
![LMComposeViewDemoGif.gif](https://upload-images.jianshu.io/upload_images/1197929-a072197639798faa.gif?imageMogr2/auto-orient/strip)


### 使用方法 
在使用LMComposeView的时候只要一行代码就能搞定：
```
#import "LMComposeView.h"
@interface DemoController ()<LMComposeViewDelegate>
@property(nonatomic,strong) LMComposeView * composeView;
@end
-(LMComposeView *)composeView{
if (!_composeView) {
_composeView = [[LMComposeView alloc]init];
_composeView.delegate = self;
[self.view addSubview:_composeView];
}
return _composeView;
}
//LMComposeViewDelegate 返回当前选中的是第几个分类列表
-(void)composeViewDidClickSegementButtonWithIndex:(NSInteger)index{

NSLog(@"---滚动到了%ld---",(long)index);
}

- (void)viewDidLoad {
[super viewDidLoad];
//在初始化界面的时候 调用该方法
[self.composeView confirmComposeViewWithScrollViewArray:scrollViewArray withSegmentButtonTitleArray:titleArray withHeaderView:self.headerView withComposeViewFrame:CGRectMake(0, 64,self.view.width, self.view.height-64)];
}
```
