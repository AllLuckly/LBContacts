# LBContacts

> [博主app上线啦，快点此来围观吧](https://itunes.apple.com/us/app/it-blog-zi-xueios-kai-fa-jin/id1067787090?l=zh&ls=1&mt=8)<br>

技术交流群：534926022（免费）   511040024(0.8/人付费)

获取通讯录的联系人以及发短信给联系人。
必须导入的依赖库<br>
`AddressBookUI.framework`<br>
`AddressBook.framework`<br>
`MessageUI.framework`<br>
```

@property (nonatomic, retain) NSString *name;//联系人姓名
@property (nonatomic, retain) NSString *email;//联系人邮箱
@property (nonatomic, retain) NSString *tel;//联系人电话

//获取通讯录联系人的数据源
- (NSMutableArray *)getBook

//发信息
-(void)sendSmsMessageWithPhoneNumber:(NSString *)phoneNumber

```
> [点击此--->更多开发技巧](http://allluckly.cn/) <br>
更多使用方法请参考Demo，下面是模拟机上的操作，真机才能发短信哦 <br>
<br>
<br>
![(LBContacts)](https://github.com/AllLuckly/LBContacts/blob/master/Untitled.gif?raw=true)


