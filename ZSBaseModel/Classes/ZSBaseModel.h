//
//  ZSBaseModel.h
//  Organization
//
//  Created by Kael on 2017/5/18.
//  Copyright © 2017年 SkyWorth_hightong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import <objc/message.h>

#define kEmpty_string_default @""

//---------------------------------
// 有返回值的IMP
typedef id (* _kIMP) (id, SEL, ...);
// 没有返回值的IMP(定义为VIMP)
typedef void (* _kVIMP) (id, SEL, ...);
//---------------------------------


@interface ZSBaseModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *sex;



#pragma mark - 方法替换
/**
 替换某各类的实例方法

 @param cls 操作的类
 @param newSelector 新方法；
 @param oldSelector 旧的 将要被替换的方法；
 */
+(void)replaceMethodWithInstanceOfClass:(Class)cls newSelector:(SEL)newSelector oldSelector:(SEL)oldSelector;


/**
 替换某各类的 类方法

 @param cls 目标类
 @param newSelector 新方法
 @param oldSelector 旧方法
 */
+(void)replaceMethodWithClass:(Class)cls newSelector:(SEL)newSelector oldSelector:(SEL)oldSelector;


#pragma mark - 重置 NSString 属性默认值

/**
 重置指定类（自己类或者其他类）的 NSString类型默认属性值

 @param obj 指定类
 @param defaultStr 默认值
 */
+(void)zs_resetIvarValueWithObject:(NSObject *)obj andDefaultString:(NSString *)defaultStr;

/**
 给自己类某些属性设置默认值 defaultStr （通过setter方法重置）

 @param defaultStr 默认值
 */
-(void)zs_resetIvarValueWithDefaultString:(NSString *)defaultStr;


/**
 修改NSString 类型的 Getter 并给予默认值 defaultStr (通过getter方法过滤)

 @param defaultStr 默认值
 */
-(void)zs_resetGetterValueDefaultString:(NSString *)defaultStr;


/**
 重置属性，确保安全返回 NSString 不为nil；
 */
-(void)zs_resetDefaultValue;


#pragma mark - 工具方法
/**
 获取属性的 类型type

 @param attribut 属性
 @return 属性类型（NSString形式返回）
 */
+(NSString *)getClassTypeWithAttribut:(const char *)attribut;


#pragma mark - 测试功能方法
-(void)logDog;

-(void)logCat;

@end
