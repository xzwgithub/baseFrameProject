//
//  Entity.m
//  AmwayMCommerce
//
//  Created by 张 黎 on 12-12-28.
//
//

#import "Entity.h"

@implementation Entity

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)dealloc {
//    ISS_RELEASE(_id);
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}


/**
 快速将json转为实体对象
 
 @param json string
 
 @return Entity对象
 */
+ (id)objectWithJson:(NSString *)json {
    return [self yy_modelWithJSON:json];
}
/**
 快速将Dictionary转为实体对象
 
 @param Dictionary
 
 @return Entity对象
 */
+ (id)objectWithDictionary:(NSDictionary*)dict  {
    return [self yy_modelWithDictionary:dict];
}


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

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"_id" : @"id"};
}


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
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return nil;
}

/**
 * 快速将对象转换为Json的方法
 */
- (NSString *)toJsonString {
    NSDictionary *dicitonary = [self yy_modelToJSONObject];
    id jsonData = [NSJSONSerialization dataWithJSONObject:dicitonary options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 * 快速将对象转换为键值对的方法
 */

- (NSDictionary *)toDictionary {
    return [self yy_modelToJSONObject];
}

/**
 * 快速打印属性及对应值的方法
 */
- (NSString *)toString {
    NSMutableString *returnString = [NSMutableString string];
    [returnString appendFormat:@"%@",[self yy_modelToJSONObject]];
    return returnString;
}

/**
 *  将字典数组转成实体数组
 */
+ (NSArray *)toModelArr:(NSArray *)dictArr{
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (NSDictionary *dice in dictArr) {
        id modelObj = [self.class yy_modelWithDictionary:dice];
        [modelArr addObject:modelObj];
    }
    return modelArr;
}

/**
 将实体数组 转成 字典数组
 */
+ (NSArray *)toDictArr:(NSArray <Entity *>*)modelArr{
    NSMutableArray *dicrArr = [NSMutableArray array];
    for (Entity *model in modelArr) {
        [dicrArr addObject:[model toDictionary]];
    }
    return dicrArr;
}


- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

@end
