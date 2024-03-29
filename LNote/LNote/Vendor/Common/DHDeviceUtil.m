//
//  DHDeviceUtil.m
//  Dash iOS
//
//  Created by HTC on 2017/5/3.
//  Copyright © 2017年 Kapeli. All rights reserved.
//

#import "DHDeviceUtil.h"

#import "sys/utsname.h"

@implementation DHDeviceUtil

+(NSString *)deviceModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"]) return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"]) return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"]) return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"]) return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"] || [deviceModel isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"] || [deviceModel isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"] || [deviceModel isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,2"] || [deviceModel isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"] || [deviceModel isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,4"] || [deviceModel isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,8"] || [deviceModel isEqualToString:@"iPhone11,9"]) return @"iPhone XR";
    
    
    // 2018 models
    if ([deviceModel isEqualToString:@"iPhone11,1"])    return @"iPhone XS (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,2"])    return @"iPhone XS (GSM)";
    if ([deviceModel isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,5"])    return @"iPhone XS Max (GSM, Dual Sim, China)";
    if ([deviceModel isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max (GSM)";
    if ([deviceModel isEqualToString:@"iPhone11,8"])    return @"iPhone XR (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone11,9"])    return @"iPhone XR (GSM)";
    
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([deviceModel isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,11"])      return @"iPad (5th Gen)";
    if ([deviceModel isEqualToString:@"iPad6,12"])      return @"iPad (5th Gen)";
    if ([deviceModel isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9 (2nd Gen)";
    if ([deviceModel isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9 (2nd Gen)";
    if ([deviceModel isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5";
    if ([deviceModel isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5";

    //Apple TV
    if ([deviceModel isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3 (2013)";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])   return @"Apple TV 4";
    if ([deviceModel isEqualToString:@"AppleTV6,2"])   return @"Apple TV 4K";
    
    //Apple Watch
    if ([deviceModel isEqualToString:@"Watch1,1"])     return @"Apple Watch (1st generation) (38mm)";
    if ([deviceModel isEqualToString:@"Watch1,2"])     return @"Apple Watch (1st generation) (42mm)";
    if ([deviceModel isEqualToString:@"Watch2,6"])     return @"Apple Watch Series 1 (38mm)";
    if ([deviceModel isEqualToString:@"Watch2,7"])     return @"Apple Watch Series 1 (42mm)";
    if ([deviceModel isEqualToString:@"Watch2,3"])     return @"Apple Watch Series 2 (38mm)";
    if ([deviceModel isEqualToString:@"Watch2,4"])     return @"Apple Watch Series 2 (42mm)";
    if ([deviceModel isEqualToString:@"Watch3,1"])     return @"Apple Watch Series 3 (38mm Cellular)";
    if ([deviceModel isEqualToString:@"Watch3,2"])     return @"Apple Watch Series 3 (42mm Cellular)";
    if ([deviceModel isEqualToString:@"Watch3,3"])     return @"Apple Watch Series 3 (38mm)";
    if ([deviceModel isEqualToString:@"Watch3,4"])     return @"Apple Watch Series 3 (42mm)";
    
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexStringHavaAlpha:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 8)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 8)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *aString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 6;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int a, r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float)a/255.0f)];
}

//设置圆形头像
+ (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
@end
