//
//  NSArray+Extend.m
//  Wifi
//
//  Created by muxi on 14/11/27.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import "NSArray+Extend.h"

@implementation NSArray (Extend)



#pragma mark  数组转字符串
-(NSString *)string{
    
    if(self==nil || self.count==0) return @"";
    
    NSMutableString *str=[NSMutableString string];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,",obj];
    }];
    
    //删除最后一个','
    NSString *strForRight = [str substringWithRange:NSMakeRange(0, str.length-1)];
    
    return strForRight;
}





#pragma mark  数组比较
-(BOOL)compareIgnoreObjectOrderWithArray:(NSArray *)array{
    
    NSSet *set1=[NSSet setWithArray:self];
    
    NSSet *set2=[NSSet setWithArray:array];
    
    return [set1 isEqualToSet:set2];
}


/**
 *  数组计算交集
 */
-(NSArray *)arrayForIntersectionWithOtherArray:(NSArray *)otherArray{
    
    NSMutableArray *intersectionArray=[NSMutableArray array];
    
    if(self.count==0) return nil;
    if(otherArray==nil) return nil;
    
    //遍历
    for (id obj in self) {
        
        if(![otherArray containsObject:obj]) continue;
        
        //添加
        [intersectionArray addObject:obj];
    }
    
    return intersectionArray;
}



/**
 *  数据计算差集
 */
-(NSArray *)arrayForMinusWithOtherArray:(NSArray *)otherArray{
    
    if(self==nil) return nil;
    
    if(otherArray==nil) return self;
    
    NSMutableArray *minusArray=[NSMutableArray arrayWithArray:self];
    
    //遍历
    for (id obj in otherArray) {
        
        if(![self containsObject:obj]) continue;
        
        //添加
        [minusArray removeObject:obj];
        
    }
    
    return minusArray;
}

- (NSArray *)getKeysAndResultsString:(NSString *)name{
    NSMutableArray * mutableArr = [NSMutableArray array];
    NSMutableDictionary *addressBookDict = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < self.count; i ++) {
        id model = self[i];
        NSDictionary * dict = [model mj_keyValues];
        //获取到姓名的大写首字母
        NSString *firstLetterString = [dict[name] getFirstLetter];
        //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
        if (addressBookDict[firstLetterString])
        {
            [addressBookDict[firstLetterString] addObject:model];
        }
        //没有出现过该首字母，则在字典中新增一组key-value
        else
        {
            //创建新发可变数组存储该首字母对应的联系人模型
            NSMutableArray *arrGroupNames = [NSMutableArray array];
            [arrGroupNames addObject:model];
            //将首字母-姓名数组作为key-value加入到字典中
            [addressBookDict setObject:arrGroupNames forKey:firstLetterString];
        }
    }
    // 将addressBookDict字典中的所有Key值进行排序: A~Z
    NSArray *nameKeys = [[addressBookDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    // 将 "#" 排列在 A~Z 的后面
    NSMutableArray *mutableNamekeys = [NSMutableArray arrayWithArray:nameKeys];
    if ([nameKeys.firstObject isEqualToString:@"#"])
    {
        [mutableNamekeys insertObject:nameKeys.firstObject atIndex:nameKeys.count];
        [mutableNamekeys removeObjectAtIndex:0];
        
    }
    // 数组中第一个元素是最终的结果  第二个元素是键
    [mutableArr addObject:addressBookDict];
    [mutableArr addObject:mutableNamekeys];
    return mutableArr;
}
@end
