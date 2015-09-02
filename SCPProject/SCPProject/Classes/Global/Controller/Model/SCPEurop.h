//
//  SCPEurop.h
//  SCPProject
//
//  Created by 韩辉 on 15/8/31.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPEurop : NSObject

/** 图片 */
@property(nonatomic, copy)NSString *thumb;
/** 宽 */
@property (nonatomic, assign) CGFloat width;
/** 高 */
@property (nonatomic, assign) CGFloat height;
/**  linkageid */
@property (nonatomic, copy) NSString *linkageid;

@end

//{
//    "data": [{
//        "linkageid": "3486",
//        "name": "\u610f\u5927\u5229",
//        "thumb": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0417\/20150417105449733.jpg",
//        "width": 640,
//        "height": 300
//    }],
//    "error": "200"
//}
