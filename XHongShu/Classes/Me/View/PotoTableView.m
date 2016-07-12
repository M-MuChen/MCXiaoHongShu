//
//  PotoTableView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "PotoTableView.h"
@interface PotoTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation PotoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *potoCell = @"potoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:potoCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:potoCell];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"user"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self.delegate1 titleViewName:_dataArray[indexPath.row] groupName:nil];

    }else{
        [self.delegate1 titleViewName:_dataArray[indexPath.row] groupName:_groupArray[indexPath.row-1]];
    }
}
@end
