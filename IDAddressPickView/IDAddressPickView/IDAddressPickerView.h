//
//  IDAddressPickerView.h
//  IDAddressPickView
//
//  Created by Island on 16/7/15.
//  Copyright © 2016年 Island. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDAddressPickerView;
@protocol IDAddressPickerViewDataSource <NSObject>
/**
 *  地址信息，指定格式的数组
 */
- (NSArray *)addressArray;
@end
@interface IDAddressPickerView : UIView
/** 代理 */
@property (nonatomic, weak) id<IDAddressPickerViewDataSource> dataSource;
/**
 *  所选中的 省市区 信息，分别对应于 key: province, city, area
 */
@property (nonatomic, strong) NSMutableDictionary *selectedAddress;
@end
