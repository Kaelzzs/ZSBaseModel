//
//  ZSBaseModel.m
//  Organization
//
//  Created by Kael on 2017/5/18.
//  Copyright © 2017年 SkyWorth_hightong. All rights reserved.
//

#import "ZSBaseModel.h"

@implementation ZSBaseModel
+(void)load{

}

/**
 交换实例方法

 @param cls 实例化对象所属类
 @param newSelector 新的选择器
 @param oldSelector 旧的 要被替换掉的选择器
 */
+(void)replaceMethodWithInstanceOfClass:(Class)cls newSelector:(SEL)newSelector oldSelector:(SEL)oldSelector{
    
    Method newMethod = class_getInstanceMethod(cls, oldSelector);
    Method oldMethod = class_getInstanceMethod(cls, newSelector);
    
    method_exchangeImplementations(oldMethod, newMethod);
}


/**
 交换类方法

 @param cls 要操作的类
 @param newSelector 新的类方法
 @param oldSelector 将要被替换掉的类方法
 */
+(void)replaceMethodWithClass:(Class)cls newSelector:(SEL)newSelector oldSelector:(SEL)oldSelector{
    
    Method newMethod = class_getClassMethod(cls, oldSelector);
    Method oldMethod = class_getClassMethod(cls, newSelector);
    
    method_exchangeImplementations(oldMethod, newMethod);
}


+(void)zs_resetIvarValueWithObject:(NSObject *)obj andDefaultString:(NSString *)defaultStr{
    //1、获取属性
    //属性的数量
    u_int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([obj class], &propertyCount);
    
    //2、遍历属性
    for (int i = 0; i<propertyCount; i++) {
        //-------------------
        objc_property_t propertyItem = propertys[i];
        const char *propertyName = property_getName(propertyItem);
        const char *propertyAttri = property_getAttributes(propertyItem);
        //        const char *propertyAttributeValue = property_copyAttributeValue(propertyItem, propertyName);
        
        //3、判断是字符串---------------------
        NSString *typeString = [ZSBaseModel getClassTypeWithAttribut:propertyAttri];
        //可能是不可变字符串  也有可能是 可变字符串；所以这里用 isSubClassOfClass: 来匹配。
        if ([NSClassFromString(typeString) isSubclassOfClass:[NSString class]]) {
            
            //4、获取实例变量的值
            const char *pName = [[NSString stringWithFormat:@"_%s",propertyName] UTF8String];
            Ivar pIvar =  class_getInstanceVariable([obj class],pName);
            NSString *pValue = object_getIvar(obj, pIvar);//属性的值
            
            //5、根据实例变量的值，判断是否替换方法
            //重置默认值
            if (!pValue) {
                //                object_setIvarWithStrongDefault(self, pIvar, defaultStr);
                object_setIvar(obj, pIvar, defaultStr);
                return;
                
            }
            
            
        }
        
    }
}

-(void)zs_resetIvarValueWithDefaultString:(NSString *)defaultStr{

    //1、获取属性
    //属性的数量
    u_int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //2、遍历属性
    for (int i = 0; i<propertyCount; i++) {
        //-------------------
        objc_property_t propertyItem = propertys[i];
        const char *propertyName = property_getName(propertyItem);
        const char *propertyAttri = property_getAttributes(propertyItem);
        //        const char *propertyAttributeValue = property_copyAttributeValue(propertyItem, propertyName);
        
        //3、判断是字符串---------------------
        NSString *typeString = [[self class] getClassTypeWithAttribut:propertyAttri];
        //可能是不可变字符串  也有可能是 可变字符串；所以这里用 isSubClassOfClass: 来匹配。
        if ([NSClassFromString(typeString) isSubclassOfClass:[NSString class]]) {
            
            //4、获取属性getter方法的选择器（属性名字就是getter）
            SEL pItemSelector = NSSelectorFromString([NSString stringWithFormat:@"%s",propertyName]);
            Method propertyGetter = class_getInstanceMethod([self class], pItemSelector);
            
            //5、获取实例变量的值
            const char *pName = [[NSString stringWithFormat:@"_%s",propertyName] UTF8String];
            Ivar pIvar =  class_getInstanceVariable([self class],pName);
            NSString *pValue = object_getIvar(self, pIvar);//属性的值

            //6、根据实例变量的值，判断是否替换方法
            //属性值为空 重写getter 返回默认值
            if (!pValue) {
//                object_setIvarWithStrongDefault(self, pIvar, defaultStr);
                object_setIvar(self, pIvar, defaultStr);
                return;
//                // 重新设置方法的实现
//                //给一个方法添加具体实现
//                method_setImplementation(propertyGetter, imp_implementationWithBlock(^(id target, SEL action) {
//                    // 新增的功能代码 并添加返回值
//                    //                    NSLog(@"我就是新添加的代码");
//                    return [defaultStr copy];
//                }));
                
            }
            
            
        }
        
    }
    
    
}

-(void)zs_resetGetterValueDefaultString:(NSString *)defaultStr{
    //1、获取属性
    //属性的数量
    u_int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //2、遍历属性
    for (int i = 0; i<propertyCount; i++) {
        //-------------------
        objc_property_t propertyItem = propertys[i];
        const char *propertyName = property_getName(propertyItem);
        const char *propertyAttri = property_getAttributes(propertyItem);
        //        const char *propertyAttributeValue = property_copyAttributeValue(propertyItem, propertyName);
        
        //3、判断是字符串---------------------
        NSString *typeString = [[self class] getClassTypeWithAttribut:propertyAttri];
        //可能是不可变字符串  也有可能是 可变字符串；所以这里用 isSubClassOfClass: 来匹配。
        if ([NSClassFromString(typeString) isSubclassOfClass:[NSString class]]) {
            
            //4、获取属性getter方法的选择器（属性名字就是getter）
            SEL pItemSelector = NSSelectorFromString([NSString stringWithFormat:@"%s",propertyName]);
            Method propertyGetter = class_getInstanceMethod([self class], pItemSelector);
            
            //5、获取实例变量的值
            const char *pName = [[NSString stringWithFormat:@"_%s",propertyName] UTF8String];
            Ivar pIvar =  class_getInstanceVariable([self class],pName);
            NSString *pValue = object_getIvar(self, pIvar);//属性的值
            
            //6、根据实例变量的值，判断是否替换方法
            //属性值为空 重写getter 返回默认值
            if (!pValue) {
                // 重新设置方法的实现
                //给一个方法添加具体实现
                method_setImplementation(propertyGetter, imp_implementationWithBlock(^(id target, SEL action) {
                    // 新增的功能代码 并添加返回值
                    //                    NSLog(@"我就是新添加的代码");
                    return [defaultStr copy];
                }));
                
            }
            
            
        }
        
    }

}



#pragma mark - 替换NSString的默认值
-(void)zs_resetDefaultValue{
    //1、获取属性
    //属性的数量
    u_int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //2、遍历属性
    for (int i = 0; i<propertyCount; i++) {
        //-------------------
        objc_property_t propertyItem = propertys[i];
        const char *propertyName = property_getName(propertyItem);
        const char *propertyAttri = property_getAttributes(propertyItem);
//        const char *propertyAttributeValue = property_copyAttributeValue(propertyItem, propertyName);
        
        //3、判断是字符串---------------------
        NSString *typeString = [[self class] getClassTypeWithAttribut:propertyAttri];
        //可能是不可变字符串  也有可能是 可变字符串；所以这里用 isSubClassOfClass: 来匹配。
        if ([NSClassFromString(typeString) isSubclassOfClass:[NSString class]]) {
            
            //4、获取属性getter方法的选择器（属性名字就是getter）
            SEL pItemSelector = NSSelectorFromString([NSString stringWithFormat:@"%s",propertyName]);
            Method propertyGetter = class_getInstanceMethod([self class], pItemSelector);
            
            //5、获取实例变量的值
            const char *pName = [[NSString stringWithFormat:@"_%s",propertyName] UTF8String];
            Ivar pIvar =  class_getInstanceVariable([self class],pName);
            NSString *pValue = object_getIvar(self, pIvar);//属性的值
            
            //6、根据实例变量的值，判断是否替换方法
            //属性值为空 重写getter 返回默认值
            if (!pValue) {
                // 重新设置方法的实现
                //给一个方法添加具体实现
                method_setImplementation(propertyGetter, imp_implementationWithBlock(^(id target, SEL action) {
                    // 新增的功能代码 并添加返回值
//                    NSLog(@"我就是新添加的代码");
                    return kEmpty_string_default;
                }));
                
            }
            
            
        }
        
    }
    
    
}
#pragma mark - 获取某一属性的 类型（以字符串形式返回）
+(NSString *)getClassTypeWithAttribut:(const char *)attribut{
    
    //默认返回空字符串
    NSString *typeString = @"";
    
    NSMutableString *mAttribut = [NSMutableString stringWithFormat:@"%s",attribut];
    NSArray *attriStrs = [mAttribut componentsSeparatedByString:@"\""];
    
    if (attriStrs.count>=2) {
        typeString = attriStrs[1];
    }
    return typeString;
}



#pragma mark - 测试方法 可忽视

-(void)logDog{
    
    NSLog(@"dog");
}

-(void)logCat{
    
    NSLog(@"cat");
}




@end
