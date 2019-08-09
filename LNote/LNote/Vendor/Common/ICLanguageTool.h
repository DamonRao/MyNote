//
//  ICLanguageTool.h
//  ICUtils
//
//  Created by jianq on 2017/5/24.
//  Copyright © 2017年 com.jianq. All rights reserved.
//

#define LocalString(key) \
[[ICLanguageTool sharedInstance] getStringForKey:key withTable:@"Language"]

#define CNS @"zh-Hans"
#define EN @"en"
#define JA @"ja"
#import <Foundation/Foundation.h>

@interface ICLanguageTool : NSObject

+(id)sharedInstance;

/**
 *  返回table中指定的key的值
 *
 *  @param key   key
 *  @param table table
 *
 *  @return 返回table中指定的key的值
 */
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table;

/**
 *  设置新的语言
 *
 *  @param language 新语言
 */
-(void)setNewLanguage:(NSString*)language;

@end
