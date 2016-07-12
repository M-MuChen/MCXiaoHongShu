//
//  AddFriendsViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/15.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddFriendsCell.h"
#import "AddFriendsModel.h"
@interface AddFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *_moreTopicsBtn;
    NSArray *_imageArray;
    NSMutableArray *_dataArray;
    UITableView *_addFriendsTableView;
    NSMutableArray *_albumArray;
    NSArray *_nameArray;

}
@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self createUI];
    [self barbtnItem];
    [self getFriendsData];
}
- (void)initNavBar
{
    UIButton *btn;
    btn.layer.masksToBounds = YES;
    
    self.navigationItem.title = @"添加好友";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
}
- (void)getFriendsData{
    
    _dataArray = [NSMutableArray array];
    [MCNetworkingLogin getLogin:addFriendspage1String parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        _dataArray = [AddFriendsModel arrayOfModelsFromDictionaries:dataArray];
        [_addFriendsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithImageName:@"search_bar_icon_gray~iphone" target:self action:@selector(search)];
    
    self.navigationItem.rightBarButtonItem = setItem;
}
- (void)createUI{
    
    _imageArray = [NSArray arrayWithObjects:@"message_new_fans~iphone",@"message_new_comments~iphone", nil];
    _nameArray = [NSArray arrayWithObjects:@"微博好友",@"通讯录好友",nil];
    _addFriendsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
    _addFriendsTableView.backgroundColor =  MCColor(242, 246, 249, 1.0);
    _addFriendsTableView.delegate = self;
    _addFriendsTableView.dataSource = self;
    [self.view addSubview:_addFriendsTableView];
    
    _addFriendsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 结束刷新
    [_addFriendsTableView.mj_footer endRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else {
        return _dataArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *FriendsCell= @"FriendsCell";
        UITableViewCell *cell = [_addFriendsTableView dequeueReusableCellWithIdentifier:FriendsCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FriendsCell];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.accessoryType = UITableViewCellEditingStyleDelete;
        }
        cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        cell.textLabel.text = _nameArray[indexPath.row];
        cell.detailTextLabel.text = @"未导入好友";

        return cell;
        
        
    }else{
        static NSString *AddCell= @"AddFriendsCell";
         AddFriendsCell*cell = [_addFriendsTableView dequeueReusableCellWithIdentifier:AddCell];
        if (!cell) {
            cell = [[AddFriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddCell];
        }
        cell.addFriendsModel = _dataArray[indexPath.row];
        return cell;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 220;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
    
}
#pragma mark 加载第二页
- (void)loadMoreData{
    
    [MCNetworkingLogin getLogin:addFriendspage2String parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *dataArray = responseObject[@"data"];
        dataArray = [AddFriendsModel arrayOfModelsFromDictionaries:dataArray];
        [_dataArray addObjectsFromArray:dataArray];
        [_addFriendsTableView reloadData];
    
        [_addFriendsTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [_addFriendsTableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
    
}

#pragma mark 取消
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 搜索
- (void)search{

}
-(void)viewDidLayoutSubviews
{
    if ([_addFriendsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_addFriendsTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_addFriendsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_addFriendsTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
