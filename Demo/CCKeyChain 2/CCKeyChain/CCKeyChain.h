//
//  CCKeyChain.h
//  CCKeyChain
//
//  Created by ColeXm on 16/3/10.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCKeyChain : NSObject

/** 保存&&更新 */
+ (BOOL)setObject:(id)anObject forKey:(NSString*)key;

/** 获取 */
+ (id)objectForKey:(NSString *)key;

/** 移除 */
+ (BOOL)removeObjectForKey:(NSString *)key;

@end
