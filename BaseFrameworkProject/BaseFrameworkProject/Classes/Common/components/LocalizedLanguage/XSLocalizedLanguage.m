//
//  XSLocalizedLanguage.m
//  UniversalArchitecture
//
//  Created by chewyong on 15/12/18.
//  Copyright © 2015年 isoftstone. All rights reserved.
//

#import "XSLocalizedLanguage.h"
#import "XSConfigEngine.h"


#define XS_LOCALIZED_LANGUAGE @"XSLocalizedLanguage"

@interface XSLocalizedLanguage ()

@property(nonatomic, assign) EN_LANGUAGE_TYPE langeType;

@end


static XSLocalizedLanguage *g_localizedLanguageInstance = nil;

@implementation XSLocalizedLanguage

+ (id)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_localizedLanguageInstance = [[XSLocalizedLanguage alloc] init];
    });
    [g_localizedLanguageInstance languageInit];
    
    return g_localizedLanguageInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self languageInit];
    }
    return self;
}

- (void)languageInit{
    if ([XSConfigEngine sysConfigGetIntForKey:XS_LOCALIZED_LANGUAGE] == 0)//not exsit setting value
    {
        //same with system default
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        if ([currentLanguage hasPrefix:@"zh-Hant"] ||[currentLanguage hasPrefix:@"zh-Hans"])
        {
            self.langeType = EN_LANGUAGE_CHINESE;
        }
        else
        {
            self.langeType = EN_LANGUAGE_ENGLISH;
        }
    }else{
        //value from setting value
        self.langeType = (EN_LANGUAGE_TYPE)[XSConfigEngine sysConfigGetIntForKey:XS_LOCALIZED_LANGUAGE];
    }
}

+ (void)setLanguageType:(EN_LANGUAGE_TYPE)languageType
{
    [XSConfigEngine sysConfigSetInt:languageType forKey:XS_LOCALIZED_LANGUAGE];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LANGUAGE_CHANGED object:nil];
}

- (NSString *)localizedString:(NSString *)key comment:(NSString *)comment
{
    self.langeType = (EN_LANGUAGE_TYPE)[XSConfigEngine sysConfigGetIntForKey:XS_LOCALIZED_LANGUAGE];
    NSString *string = nil;
    switch (self.langeType)
    {
        case EN_LANGUAGE_CHINESE:
            string = NSLocalizedStringFromTable(key, @"Localizable_chinese_simplified", comment);
            break;
        case EN_LANGUAGE_ENGLISH:
            string = NSLocalizedStringFromTable(key, @"Localizable_english", comment);
            break;
        default:
            string = NSLocalizedStringFromTable(key, @"Localizable_english", comment);
            break;
    }
    
    return string;
    
}

+ (NSString *)XSLocalizedString:(NSString *)keys comments:(NSString *)comments
{
    return [[XSLocalizedLanguage getInstance] localizedString:keys comment:comments];
}

+ (int)getLanguageType
{
    return [[XSLocalizedLanguage getInstance] langeType];
}


@end
