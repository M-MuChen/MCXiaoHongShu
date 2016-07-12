//
//  NavTransitioning.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "NavTransitioning.h"
#import "HomeViewController.h"
#import "NotesDetailViewController.h"
#import "NotesCollectionCell.h"

@implementation NavTransitioning

/**
 *  这个接口负责切换的具体内容，也即“切换中应该发生什么”。开发者在做自定义切换效果时大部分代码会是用来实现这个接口
 */

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

/**
 *  UIViewControllerAnimatedTransitioning 的协议都包含一个对象：transitionContext，通过这个对象能获取到切换时的上下文信息，比如从哪个VC切换到哪个VC等。我们从 transitionContext 获取 containerView，这是一个特殊的容器，切换时的动画将在这个容器中进行；UITransitionContextFromViewControllerKey和UITransitionContextToViewControllerKey 就是从哪个VC切换到哪个VC
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    HomeViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NotesDetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    fromVC.currentIndexPath = [[fromVC.collectionView indexPathsForSelectedItems] firstObject];
    
    NotesCollectionCell *cell = (NotesCollectionCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    //snapshotViewAfterScreenUpdates 获取快照 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *snapShotView = [cell.itemImage snapshotViewAfterScreenUpdates:NO];
    //坐标转换
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.itemImage.frame fromView:cell.itemImage.superview];
    
    cell.itemImage.hidden = YES;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageScrollView.hidden = YES;
    fromVC.view.alpha = 0;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.imageScrollView.frame fromView:toVC.imageScrollView.superview];
    } completion:^(BOOL finished) {
        toVC.imageScrollView.hidden = NO;
        fromVC.view.alpha = 1;
        cell.itemImage.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
@end
