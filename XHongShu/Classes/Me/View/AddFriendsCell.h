//
//  AddFriendsCell.h
//  XHongShu
//
//  Created by 宋江 on 16/6/15.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriendsModel.h"
#import "NotesList.h"
@interface AddFriendsCell : UITableViewCell


@property (nonatomic,strong)AddFriendsModel *addFriendsModel;

@property (nonatomic,strong)NotesList *notesListModel;

@property (weak, nonatomic) IBOutlet UIButton *userPoto;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIImageView *imageView0;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

- (IBAction)addAttention:(id)sender;

- (IBAction)hide:(id)sender;

@end
