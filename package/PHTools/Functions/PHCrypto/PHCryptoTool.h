//
//  PHCryptoTool.h
//  package
//
//  Created by penghui on 2020/5/10.
//  Copyright © 2020 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>


/**加密 类*/
NS_ASSUME_NONNULL_BEGIN

@interface PHCryptoTool : NSObject

@property (nonatomic,assign)CCAlgorithm algorithm;

/// 单例方法
+ (instancetype)shared;

/// 加密方法封装
/// @param string 要加密的 字符串
/// @param keyString key值
/// @param iv 向量
- (NSString *)encryptString:(NSString *)string keyString:(NSString *)keyString iv:(nullable NSData *)iv;

/// 解密方法封装
/// @param string 要加密的 字符串
/// @param keyString key值
/// @param iv 向量
- (NSString *)decryptString:(NSString *)string keyString:(NSString *)keyString iv:(nullable NSData *)iv;
@end

NS_ASSUME_NONNULL_END
