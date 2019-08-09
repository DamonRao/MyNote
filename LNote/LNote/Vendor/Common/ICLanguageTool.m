//
//  ICLanguageTool.m
//  ICUtils
//
//  Created by jianq on 2017/5/24.
//  Copyright © 2017年 com.jianq. All rights reserved.
//

#import "ICLanguageTool.h"
#define LANGUAGE_SET @"langeuageset"

static ICLanguageTool *sharedModel;

@interface ICLanguageTool()

@property(nonatomic,strong)NSBundle *bundle;
@property(nonatomic,copy)NSString *language;

@end

@implementation ICLanguageTool

+(id)sharedInstance
{
    if (!sharedModel)
    {
        sharedModel = [[ICLanguageTool alloc]init];
    }
    
    return sharedModel;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLanguage];
    }
    
    return self;
}

-(void)initLanguage
{
// 根据系统语言获取语种
    self.language = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    
// 根据内部语言设置的语种
    NSString *tmp = [[NSUserDefaults standardUserDefaults]objectForKey:LANGUAGE_SET];

    if ([tmp isEqualToString:EN] || [tmp isEqualToString:CNS] || [tmp isEqualToString:JA])
    {
        self.language = tmp;
    }

    NSString *path = [[NSBundle mainBundle]pathForResource:self.language ofType:@"lproj"];
    if(path)
    {
         self.bundle = [NSBundle bundleWithPath:path];
    }
   
}
//table 指的是strings 文件的名字
-(NSString *)getStringForKey:(NSString *)key withTable:(NSString *)table
{
    NSString *string;
    if (self.bundle)
    {
        string=NSLocalizedStringFromTableInBundle(key, table, self.bundle, @"");
        if(string == nil) return key;
        return string;
    }

    string=NSLocalizedStringFromTable(key, table, @"");

    if(string == nil) return key;
    
    return string;
}


-(void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:self.language])
    {
        return;
    }
    
    if ([language isEqualToString:EN] || [language isEqualToString:CNS] || [language isEqualToString:JA])
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
    }
    
    self.language = language;
    
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:LANGUAGE_SET];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
