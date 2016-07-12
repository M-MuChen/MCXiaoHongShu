//
//  MCWaterFlowLayout.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/27.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCWaterFlowLayout.h"

@interface MCWaterFlowLayout()

@property (nonatomic, weak) id<MCWaterFlowLayoutDelegate> delegate;
/** 存放所有item的attrubutes属性*/
@property (nonatomic, strong) NSMutableArray *itemAttributes;
/** 存放所有段头或断尾的attrubutes属性*/
@property (nonatomic, strong) NSMutableArray *supplementaryAttributes;

@end
@implementation MCWaterFlowLayout

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    self.sectionInset = UIEdgeInsetsMake(0.0f, 10.0f, 10.0f, 10.0f);
    
    _columnCount = 2;
    _itemAttributes = [NSMutableArray array];
    _supplementaryAttributes = [NSMutableArray array];
}

-(void)setHeaderHeight:(CGFloat)headerHeight
{
    _headerHeight = headerHeight;
}

#pragma mark -

- (void)prepareLayout
{
    
    self.contentHeight = 0;
    [self.itemAttributes removeAllObjects];
    [self.supplementaryAttributes removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        CGFloat minimumInteritemSpacing = [self minimumInteritemSpacingForSection:section];
        CGFloat minimumLineSpacing = [self minimumLineSpacingForSection:section];
        UIEdgeInsets sectionInset = [self sectionInsetForSection:section];
        NSInteger columnCount = [self columnCountForSection:section];
        CGFloat headerHeight = [self headerHeightForSection:section];
        CGFloat footerHeight = [self footerHeightForSection:section];
        
        NSMutableDictionary *supplementary = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        self.contentHeight += sectionInset.top;
        
        //header
        if (headerHeight > 0) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, self.contentHeight, self.collectionView.frame.size.width, headerHeight);
            
            [self.itemAttributes addObject:attributes];
            [supplementary setObject:attributes forKey:UICollectionElementKindSectionHeader];
            
            self.contentHeight = CGRectGetMaxY(attributes.frame);
        }
        
        //item
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        NSMutableArray *columnHeights = [[NSMutableArray alloc] initWithCapacity:columnCount];
        
        for (NSInteger i = 0; i < columnCount; i++) {
            columnHeights[i] = @(self.contentHeight);
        }
        
        for (NSInteger i = 0; i < itemCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
            
            NSInteger columnIndex = [columnHeights indexOfObject:[columnHeights valueForKeyPath:@"@min.self"]];
            
            CGSize size = [self itemSizeForIndexPath:indexPath];
            CGFloat x = sectionInset.left + (size.width + minimumInteritemSpacing) * columnIndex;
            
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            if (indexPath.row == 0) {
                attributes.frame = CGRectMake(x, [columnHeights[columnIndex] floatValue], size.width, size.height);
            }
            attributes.frame = CGRectMake(x, [columnHeights[columnIndex] floatValue], size.width, size.height);
            
            [self.itemAttributes addObject:attributes];
            
            columnHeights[columnIndex] = @(CGRectGetMaxY(attributes.frame) + minimumLineSpacing);
        }
        
        self.contentHeight = [[columnHeights valueForKeyPath:@"@max.self"] floatValue];
        
        if (itemCount == 0) {
            self.contentHeight += [UIScreen mainScreen].bounds.size.height;
        }
        
        //footer
        if (footerHeight > 0) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            attributes.frame = CGRectMake(0, self.contentHeight, self.collectionView.frame.size.width, footerHeight);
            
            [self.itemAttributes addObject:attributes];
            [supplementary setObject:attributes forKey:UICollectionElementKindSectionFooter];
            
            self.contentHeight = CGRectGetMaxY(attributes.frame);
        }
        
        [self.supplementaryAttributes addObject:supplementary];
        
        self.contentHeight += sectionInset.bottom;
    }
}

- (CGSize)collectionViewContentSize
{
    CGSize size = CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
    if ([self.delegate respondsToSelector:@selector(beginLoadContentSize:)]) {
        [self.delegate beginLoadContentSize:size];
    }
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, evaluatedObject.frame);
    }]];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item;
    
    for (NSInteger section = 0; section < indexPath.section; section++) {
        index += [self.collectionView numberOfItemsInSection:section];
    }
    
    return self.itemAttributes[index];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return self.supplementaryAttributes[indexPath.section][kind];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark -

- (id<MCWaterFlowLayoutDelegate>)delegate
{
    if (_delegate == nil) {
        _delegate =  (id<MCWaterFlowLayoutDelegate>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (NSInteger)columnCountForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:columnCountForSection:)]) {
        self.columnCount = [self.delegate collectionView:self.collectionView layout:self columnCountForSection:section];
    }
    
    return self.columnCount;
}

- (CGFloat)headerHeightForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
        self.headerHeight = [self.delegate collectionView:self.collectionView layout:self heightForHeaderInSection:section];
    }
    
    return self.headerHeight;
}

- (CGFloat)footerHeightForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
        self.footerHeight = [self.delegate collectionView:self.collectionView layout:self heightForFooterInSection:section];
    }
    
    return self.footerHeight;
}

- (UIEdgeInsets)sectionInsetForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        self.sectionInset = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    
    return self.sectionInset;
}

- (CGFloat)minimumInteritemSpacingForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        self.minimumInteritemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    
    return self.minimumInteritemSpacing;
}

- (CGFloat)minimumLineSpacingForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        self.minimumLineSpacing = [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    }
    
    return self.minimumLineSpacing;
}

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width-self.sectionInset.left-self.sectionInset.right-(self.columnCount-1)*self.minimumInteritemSpacing)/self.columnCount;
    
    self.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        
        self.itemSize = CGSizeMake(self.itemSize.width, floorf(size.height * self.itemSize.width / size.width));
    }
    
    return self.itemSize;
}


@end
