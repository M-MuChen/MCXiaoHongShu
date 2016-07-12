//
//  MessageViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MessageViewController.h"
#import "ThematicActivityCell.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_moreTopicsBtn;
    NSArray *_imageArray;
    NSArray *_dataArray;
    UITableView *_newsTableView;
    NSMutableArray *_albumArray;

}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavBar];
    [self createUI];
    [self getAlbumData];
}

- (void)initNavBar
{
    self.navigationItem.title = @"消息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
}
- (void)getAlbumData{
    _albumArray = [NSMutableArray array];
    [MCNetworkingLogin getLogin:newsAlbumString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *dataArray = responseObject[@"data"];
        _albumArray = [MoreAlbumModel arrayOfModelsFromDictionaries:dataArray];
        [_newsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}
- (void)createUI{
    
    _imageArray = [NSArray arrayWithObjects:@"message_new_fans~iphone",@"message_new_comments~iphone",@"message_new_likes~iphone",@"message_new_collections~iphone",@"message_new_system~iphone", nil];
    _dataArray = [NSArray arrayWithObjects:@"新的粉丝",@"新的评论",@"新的赞",@"新的收藏",@"通知",nil];
    _newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
    _newsTableView.backgroundColor =  MCColor(242, 246, 249, 1.0);
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    [self.view addSubview:_newsTableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
         return _imageArray.count;
    }else if(section == 1){
        return 1;
    }else{
         return _albumArray.count;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *newCell= @"newCell";
        UITableViewCell *cell = [_newsTableView dequeueReusableCellWithIdentifier:newCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newCell];
        }
        cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        cell.textLabel.text = _dataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.accessoryType = UITableViewCellEditingStyleDelete;
        return cell;
        
    }else if(indexPath.section ==1){
        static NSString *newCell= @"newCell";
        UITableViewCell *cell = [_newsTableView dequeueReusableCellWithIdentifier:newCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newCell];
        }
        cell.imageView.image = [UIImage imageNamed:@"message_new_activity~iphone"];
        cell.textLabel.text = @"专题活动";
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        return cell;

    }else{
        ThematicActivityCell *cell = [_newsTableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[ThematicActivityCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.albumModel = _albumArray[indexPath.row];

        return cell;

    }
    
  }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if(indexPath.section == 1){
        return 40;
    }else{
        return 195;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0.01;
    }else{
       return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
         return 14;
    }else if(section == 2){
        return 45;
    }else{
        return 0.1;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section ==0 ||section ==1) {
        return nil;
    }else{
        UIView *headView = [self createFooterView];
        return headView;
        
    }

}
- (UIView *)createFooterView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    _moreTopicsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, VIEW_WEDTH, 30)];
    _moreTopicsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_moreTopicsBtn setTitle:@"查看更多专辑活动" forState:UIControlStateNormal];
    [_moreTopicsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_moreTopicsBtn addTarget:self action:@selector(moreTopics) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_moreTopicsBtn];
    
    return headerView;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat sectionHeaderHeight = 30;//设置你footer高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//    
//}
- (void)moreTopics{
    [MCNetworkingLogin getLogin:moreNewsAlbumString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        dataArray = [MoreAlbumModel arrayOfModelsFromDictionaries:dataArray];
        [_albumArray addObjectsFromArray:dataArray];
        [_newsTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
