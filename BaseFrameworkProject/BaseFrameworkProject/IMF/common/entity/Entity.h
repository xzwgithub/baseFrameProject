//
//  Entity.h
//  AmwayMCommerce
//
//  Created by 张 黎 on 12-12-28.
//
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "AppConstants.h"

@interface Entity : NSObject

//所有实体类共有的id。
//@property (nonatomic, assign) unsigned long long _id;
@property (nonatomic, copy) NSString *_id;


/**
 快速将json转为实体对象
 
 @param json string
 
 @return Entity对象
 */
+ (id)objectWithJson:(NSString *)json;

/**
 快速将Dictionary转为实体对象
 
 param Dictionary
 
 @return Entity对象
 */
+ (id)objectWithDictionary:(NSDictionary*)dict;


/**
 自定义属性映射
 
 + (NSDictionary *)modelCustomPropertyMapper {
 NSMutableDictionary *dict = [NSMutableDictionary dictionary];
 [dict setDictionary:[super modelCustomPropertyMapper]];
 [dict addEntriesFromDictionary:@{@"roles":@"roleList"}];
 return dict;
 }

 
 @return A custom mapper for properties.
 */
+ (NSDictionary *)modelCustomPropertyMapper;


/**
 集合类属性，内容是其他类的对象，需要在这里做映射，并涵盖其子类集合类属性的映射
 
 Example:

 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"shadows" : [YYShadow class],
 @"borders" : YYBorder.class,
 @"attachments" : @"YYAttachment" };
 }
 @end
 
 @return A class mapper.
 */
+ (NSDictionary *)modelContainerPropertyGenericClass;

/**
 * 快速将对象转换为Json的方法
 */
- (NSString *)toJsonString;

/**
 * 快速将对象转换为键值对的方法
 */
- (NSDictionary *)toDictionary;


/**
 * 快速打印属性及对应值的方法
 */
- (NSString *)toString;

/**
 *  将字典数组转成实体数组
 */
+ (NSArray *)toModelArr:(NSArray *)dictArr;

/**
 将实体数组 转成 字典数组
 */
+ (NSArray *)toDictArr:(NSArray <Entity *>*)modelArr;

@end
