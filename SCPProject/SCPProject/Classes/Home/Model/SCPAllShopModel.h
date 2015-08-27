//
//  SCPAllShopModel.h
//  SCPProject
//
//  Created by 刘蒲艳 on 15/8/25.
//  Copyright © 2015年 liupuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCPAllShopModel : NSObject
/** <#注释#> */
@property (nonatomic,assign) NSInteger relation;
/** <#注释#> */
@property (nonatomic,copy) NSString *userid;
/** <#注释#> */
@property (nonatomic,assign) NSInteger like;
/** <#注释#> */
@property (nonatomic,assign) NSInteger ID;
/**  */
@property (nonatomic,assign) NSInteger catid;
/** 图片 */
@property (nonatomic,copy) NSString *thumb;
/** 标题 */
@property (nonatomic,copy) NSString *title;
/** 描述 */
@property (nonatomic,copy) NSString *desc;
/** 发布时间 */
@property (nonatomic,copy) NSString *time;
/** samll 宽度 */
@property (nonatomic,assign) CGFloat width;
/** small 高度 */
@property (nonatomic,assign) CGFloat height;
/** 大图 */
@property (nonatomic,copy) NSString *source_thumb;
/** 大图宽度 */
@property (nonatomic,assign) CGFloat source_width;
/** 大图高度 */
@property (nonatomic,assign) CGFloat source_height;
/** 店铺昵称 */
@property (nonatomic,copy) NSString *nickname;
/** 关键字 */
@property (nonatomic,copy) NSArray *keywords;
/** <#注释#> */
@property (nonatomic,assign) NSInteger hot;
/** 原件 */
@property (nonatomic,copy) NSString *yprice;
/** 现价 */
@property (nonatomic,copy) NSString *price;
/** 折扣 */
@property (nonatomic,assign) CGFloat discount;
/** 点击头像 */
@property (nonatomic,copy) NSString *photo;
/** 库存数量 */
@property (nonatomic,assign) NSInteger stocknum;
/** <#注释#> */
@property (nonatomic,assign) NSInteger quality;
/** <#注释#> */
@property (nonatomic,copy) NSString *web_url;

//"relation": 2,
//"userid": "16290",
//"like": 0,
//"comment_num": 10,
//"id": 3097,
//"catid": 162,
//"thumb": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0817\/thumb_360_0_thumb_750_750_20150817120946307.jpg",
//"title": "Prada\u7b80\u7ea6\u8774\u8776\u7ed3\u88c5\u9970\u5973\u58eb\u5e73\u5e95\u4f11\u95f2\u5355\u978b",
//"desc": "Prada\u7b80\u7ea6\u8774\u8776\u7ed3\u88c5\u9970\u5973\u58eb\u5e73\u5e95\u4f11\u95f2\u5355\u978b",
//"time": "1\u5468\u524d",
//"width": 360,
//"height": 360,
//"source_thumb": "http:\/\/www.shepinxiu.com\/uploadfile\/2015\/0817\/thumb_750_750_20150817120946307.jpg",
//"source_width": 750,
//"source_height": 750,
//"nickname": "\u5c0f\u84dd\u4eba\u5168\u7403\u4ee3\u8d2d",
//"keywords": ["Prada", "\u751c\u7f8e"],
//"hot": 0,
//"yprice": "2,770",
//"price": "1,980",
//"discount": "7",
//"photo": "http:\/\/www.shepinxiu.com\/\/phpsso_server\/uploadfile\/avatar\/1\/7\/6766\/180x180.jpg?1436779769",
//"stocknum": 1,
//"quality": 0,
//"web_url": "http:\/\/m.shepinxiu.com\/index.php?stat=3&id=3097"

@end
