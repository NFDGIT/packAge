//
//  PHCryptoTool.m
//  package
//
//  Created by penghui on 2020/5/10.
//  Copyright © 2020 Admin. All rights reserved.
//

/**
 hash
     特点：不可逆，数据指纹
     运用：密码，MD5 + 盐，HMAC，时间戳，数字签名 （HASH + RSA）
 
 对称： DES, 3DES,AES
      明文（密钥）加密密文
      密文（密钥）解密明文
 
      加密方式：ecb & cbc （iv 加密算法都喜欢结合几何）
      演示：1，终端：OpenSSL 演示
           2，代码：CCCrypto 函数 （安全隐患，可以通过检测crypto 函数获取 加密参数，所以要在调用之前处理一下，使用异或 或者其他方法）
 */

/**
 * 终端测试指令
 *
 * DES(ECB)加密
 * $ echo -n hello | openssl enc -des-ecb -K 616263 -nosalt | base64
 * DES(ECB)解密
 * $ echo -n HQr0Oij2kbo= | base64 -D | openssl enc -des-ecb -K 616263 -nosalt -d
 *
 *
 *
 * DES(CBC)加密
 * $ echo -n hello | openssl enc -des-cbc -iv 0102030405060708 -K 616263 -nosalt | base64
 * DES(CBC)解密
 * ？？？
 *
 *
 * AES(ECB)加密
 * $ echo -n hello | openssl enc -aes-128-ecb  -K 616263 -nosalt | base64
 * AES(ECB)解密
 * $ echo -n d1QG4T2tivoi0Kiu3NEmZQ== | base64 -D | openssl enc -aes-128-ecb -K 616263 -nosalt -d
 *
 *
 * AES(CBC)加密
 * $ echo -n hello | openssl enc -aes-128-cbc -iv 0102030405060708  -K 616263 -nosalt | base64
 * AES(CBC)解密
 * ？？？
 *

 
 
 */


#import "PHCryptoTool.h"

@interface PHCryptoTool()
@property (nonatomic,assign)int keySize;
@property (nonatomic,assign)int blockSize;
@end

@implementation PHCryptoTool
/// 单例方法
+ (instancetype)shared {
    static PHCryptoTool * instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.algorithm = kCCAlgorithmAES;
    });
    return instance;
}
- (void)setAlgorithm:(CCAlgorithm)algorithm {
    _algorithm = algorithm;
    switch (algorithm) {
        case kCCAlgorithmAES:
            self.keySize = kCCKeySizeAES128;
            self.blockSize = kCCBlockSizeAES128;
            break;
        case kCCAlgorithmDES:
            self.keySize = kCCKeySizeDES;
            self.blockSize = kCCBlockSizeDES;
        default:
            break;
    }
    
}

/// 加密方法封装
/// @param string 要加密的 字符串
/// @param keyString key值
/// @param iv 向量
- (NSString *)encryptString:(NSString *)string keyString:(NSString *)keyString iv:(nullable NSData *)iv {
    int keySize = self.keySize;
    int blockSize = self.blockSize;
    
    // 1. 设置密钥
    NSData * keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t ckey[keySize];
    bzero(ckey, sizeof(ckey));
    [keyData getBytes:ckey length:sizeof(ckey)];
    
    // 2. 设置iv
    uint8_t cIv[blockSize];
    bzero(cIv, sizeof(cIv));
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:sizeof(cIv)];
        option = kCCOptionPKCS7Padding;
    }else{
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 3. 设置输出缓存区
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + sizeof(cIv);
    void * buffer = malloc(sizeof(cIv));
    
    // 4. 开始解密
    size_t decryptedSize = 0;
    
    /** CCCtypt 对称加码算法的核心函数 （加密/解密）
     参数：
     1、kCCEncrypt 加密/kCCDecrypt 解密
     2、加解密算法，默认的 AES/DES
     3、加解密方式的选项
        kCCOptionPKCS7Padding | kCCOptionECBMode ；// ECB加解密！
        kCCOptionPKCS7Padding ；//CBC 加解密！
     4、加解密密钥
     5、密钥长度
     6、iv 初始化向量，ECB 不需要指定
     7、加解密的数据
     8、加解密的数据长度
     9、缓冲区（地址）、存放密文
     10、缓冲区的大小
     11、加解密结果的额大小
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          self.algorithm,
                                          option,
                                          ckey,
                                          sizeof(ckey),
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    NSData * result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    }else{
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码：%d",cryptStatus);
    }
    NSString * resultString = [result base64EncodedStringWithOptions:0];
    return resultString;
}

/// 解密方法封装
/// @param string 要加密的 字符串
/// @param keyString key值
/// @param iv 向量
- (NSString *)decryptString:(NSString *)string keyString:(NSString *)keyString iv:(nullable NSData *)iv {
    int keySize = self.keySize;
    int blockSize = self.blockSize;
    
    // 1. 设置密钥
    NSData * keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t ckey[keySize];
    bzero(ckey, sizeof(ckey));
    [keyData getBytes:ckey length:sizeof(ckey)];
    
    // 2. 设置iv
    uint8_t cIv[blockSize];
    bzero(cIv, sizeof(cIv));
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:sizeof(cIv)];
        option = kCCOptionPKCS7Padding;
    }else{
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    }
    
    // 3. 设置输出缓存区
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + sizeof(cIv);
    void * buffer = malloc(sizeof(cIv));
    
    // 4. 开始解密
    size_t decryptedSize = 0;
    
    /** CCCtypt 对称加码算法的核心函数 （加密/解密）
     参数：
     1、kCCEncrypt 加密/kCCDecrypt 解密
     2、加解密算法，默认的 AES/DES
     3、加解密方式的选项
        kCCOptionPKCS7Padding | kCCOptionECBMode ；// ECB加解密！
        kCCOptionPKCS7Padding ；//CBC 加解密！
     4、加解密密钥
     5、密钥长度
     6、iv 初始化向量，ECB 不需要指定
     7、加解密的数据
     8、加解密的数据长度
     9、缓冲区（地址）、存放密文
     10、缓冲区的大小
     11、加解密结果的额大小
     */
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          self.algorithm,
                                          option,
                                          ckey,
                                          sizeof(ckey),
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    NSData * result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    }else{
        free(buffer);
        NSLog(@"[错误] 解密失败|状态编码：%d",cryptStatus);
    }
    NSString * resultString = [result base64EncodedStringWithOptions:0];
    return resultString;
    
}

@end
