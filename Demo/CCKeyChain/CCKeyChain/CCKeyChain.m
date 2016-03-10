//
//  CCKeyChain.m
//  CCKeyChain
//
//  Created by ColeXm on 16/3/10.
//  Copyright © 2016年 ColeXm. All rights reserved.
//

#import "CCKeyChain.h"

@implementation CCKeyChain

/** 保存&&更新 */
+ (BOOL)setObject:(id)anObject forKey:(NSString*)key{
    
    if (!anObject || !key) return NO;
    
    NSMutableDictionary *secItem = @{
                              (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                              (__bridge id)kSecAttrService : key,
                              (__bridge id)kSecAttrAccount : key,
                              }.mutableCopy;
    SecItemDelete((__bridge CFDictionaryRef)secItem);
    
    [secItem setObject:[NSKeyedArchiver archivedDataWithRootObject:anObject] forKey:(__bridge id)kSecValueData];
    
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)secItem, &result);
    
    if (status == errSecSuccess){
        return YES;
    }
    return NO;
}

/** 获取 */
+ (id)objectForKey:(NSString *)key{
    if (!key) return nil;
    
    id object = nil;
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : key,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue,
                            (__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitOne
                            };
    
    CFDataRef keyData = NULL;
    OSStatus results = SecItemCopyMatching((__bridge CFDictionaryRef)query,(CFTypeRef *)&keyData);
    
    if (results == errSecSuccess) {
        object =  [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
    }
    if (keyData) CFRelease(keyData);
    
    return object;
}

/** 移除 */
+ (BOOL)removeObjectForKey:(NSString *)key{
    if (!key) return NO;
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : key,
                            (__bridge id)kSecAttrAccount : key
                            };
    
    OSStatus foundExisting = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    
    if (foundExisting == errSecSuccess){
        OSStatus deleted = SecItemDelete((__bridge CFDictionaryRef)query);
        if (deleted == errSecSuccess){
            return YES;
        }
        return NO;
    }
    
    return NO;
}


@end
