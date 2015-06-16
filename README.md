# LBContacts

获取通讯录的联系人以及发短信给联系人。

```

@property (nonatomic, retain) NSString *name;//联系人姓名
@property (nonatomic, retain) NSString *email;//联系人邮箱
@property (nonatomic, retain) NSString *tel;//联系人电话

//获取通讯录联系人的数据源
- (NSMutableArray *)getBook

//发信息
-(void)sendSmsMessageWithPhoneNumber:(NSString *)phoneNumber

```

更多使用方法请参考Demo
![_config.yml]({{ site.baseurl }}/https://github.com/AllLuckly/LBContacts/blob/master/Untitled.gif?raw=true)
