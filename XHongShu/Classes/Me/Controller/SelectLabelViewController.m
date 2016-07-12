//
//  SelectLabelViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SelectLabelViewController.h"

@interface SelectLabelViewController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
{
    UISearchController *_searchConreoller;
    UITableView *_selectTableView;
    NSArray *_dataArray;
}
@end

@implementation SelectLabelViewController
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
 }
- (void)createUI{
    
    
    _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT) style:UITableViewStyleGrouped];
    _selectTableView.delegate = self;
    _selectTableView.dataSource = self;
    [self.view addSubview:_selectTableView];
    
    //    //监听_searchBar的位置变化。
    _searchConreoller = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchConreoller.searchResultsUpdater = self;
    _searchConreoller.searchBar.delegate = self;
    _searchConreoller.dimsBackgroundDuringPresentation = NO;

    [_searchConreoller.searchBar setContentMode:UIViewContentModeLeft];   //左对齐
    [_searchConreoller.searchBar sizeToFit];
    _selectTableView.tableHeaderView = _searchConreoller.searchBar;
    _searchConreoller.searchBar.tintColor =  MCColor(246, 246, 246, 1.0);
    _searchConreoller.searchBar.barTintColor = MCColor(236, 236, 236, 1.0);
    
    [_searchConreoller.searchBar resignFirstResponder];
    //显示 searchBar 取消按钮
    _searchConreoller.searchBar.showsCancelButton = YES;
    for(id cc in [ _searchConreoller.searchBar subviews])
    {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class) isEqualToString:@"UINavigationButton"]) {
                UIButton *button = (UIButton *)view;
                [button setTitle:@"取消" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(searchCancel:) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
    }

    
    switch (_index) {
        case 0:
            _dataArray = [NSArray array];
            _searchConreoller.searchBar.placeholder = @"请输入品牌";
            break;
        case 1:
            _dataArray = [NSArray array];
            _searchConreoller.searchBar.placeholder = @"请输入名称";
            break;
        case 2:
            _dataArray = [[NSArray alloc]initWithObjects:@"人民币",@"瑞士法郎",@"瑞典克朗",@"马来西亚林吉特",@"波兰兹罗提",@"港币",@"日元",@"韩元",@"美元",@"欧元",@"英镑",@"澳元",@"泰铢",@"台币",@"加拿大元",@"新加坡币",@"澳门元",@"迪拉姆",@"新西兰元",nil];
            _searchConreoller.searchBar.placeholder = @"搜索币种";
            break;
        case 4:
            _dataArray = [NSArray array];
            _searchConreoller.searchBar.placeholder = @"请输入国家/城市";
            break;
        case 5:
            _dataArray = [NSArray array];
            _searchConreoller.searchBar.placeholder = @"请输入具体地点";
            break;
            
        default:
            break;
    }


}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count >0?_dataArray.count:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *selectCell = @"selectCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectCell];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.valueBlock(cell.textLabel.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark 搜索取消
- (void)searchCancel:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    if (searchString && ![searchString isEqualToString:@""]) {
   
    }
    
}
#pragma mark 取消
- (void)cancel:(UIButton *)btn{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
