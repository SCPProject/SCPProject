//
//  SCPArea.h
//  SCPProject
//
//  Created by 韩辉 on 15/9/4.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPArea : NSObject

/** 店铺的名字 */
@property(nonatomic, copy)NSString *nickname;
/** 店铺的照片 */
@property(nonatomic, copy)NSString *photo;
/** 宽 */
@property (nonatomic, assign) CGFloat width;
/** 高 */
@property (nonatomic, assign) CGFloat height;
/** userid */
@property (nonatomic, copy) NSString *userid;
/** 距离 */
@property(nonatomic, copy)NSString *distince;
/** 详细地址 */
@property(nonatomic, copy)NSString *address;

@end


//"userid": "13870",
//"nickname": "Syueshop",
//"photo": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0407\/20150407034019753.jpg",
//"lng": "113.340037",
//"lat": "23.123322",
//"distince": 3,
//"address": "\u5e7f\u5dde\u5e02\u5929\u6cb3\u533a\u730e\u5fb7\u82b1\u56ed\u5929\u7965\u697c1806",
//"source_thumb": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0407\/20150407034019753.jpg",
//"source_width": 640,
//"source_height": 240,
//"thumb": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0407\/20150407034019753.jpg",
//"width": 640,
//"height": 240,
//"relation": 2