//
//  MCPicModle.m
//  PortableTreasure
//
//

#import "MCPicModle.h"

@implementation MCPicModle

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> \n{picName : %@ \n pic : %@ \n}", [self class], self,self.picName, self.pic];
}

@end
