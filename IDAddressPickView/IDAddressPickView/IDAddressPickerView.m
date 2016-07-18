//
//  IDAddressPickerView.m
//  IDAddressPickView
//
//  Created by Island on 16/7/15.
//  Copyright © 2016年 Island. All rights reserved.
//

#import "IDAddressPickerView.h"

#define ProvinceKey @"Province"
#define CityKey @"CityKey"
#define AreaKey @"AreaKey"

@interface IDAddressPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
/** 地址选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 地址列表（三个层级：省市区） */
@property (nonatomic, strong) NSArray *addressArray;
/** 选中的省份 */
@property (nonatomic, assign) NSInteger provinceIndex;
/** 选中的城市 */
@property (nonatomic, assign) NSInteger cityIndex;
/** 选中的省份 */
@property (nonatomic, assign) NSInteger areaIndex;
@end

@implementation IDAddressPickerView

#pragma mark - initializer
- (instancetype)initWithFrame:(CGRect)frame {
    // 判断用户初始化时是否设置了 frame
    if (CGRectEqualToRect(frame, CGRectNull) || CGRectEqualToRect(frame, CGRectZero)) {
        // 只需要设置 height，x,y,width 不会产生影响
        frame = CGRectMake(0, 0, 0, 200);
    }
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
    }
    return self;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = 0;
    switch (component) {
        case 0:
            numberOfRowsInComponent = self.addressArray.count;
            break;
        case 1:
        {
            NSDictionary *province = self.addressArray[self.provinceIndex];
            numberOfRowsInComponent = [province[@"cities"] count];
        }
            break;
        case 2:
        {
            NSDictionary *province = self.addressArray[self.provinceIndex];
            NSDictionary *cities = province[@"cities"][self.cityIndex];
            numberOfRowsInComponent = [cities[@"areas"] count];
        }
            break;
    }
    return numberOfRowsInComponent;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleForRow = @"";
    switch (component) {
        case 0:
            titleForRow = self.addressArray[row][@"state"];
            break;
        case 1:
        {
            NSDictionary *province = self.addressArray[self.provinceIndex];
            titleForRow = province[@"cities"][row][@"city"];
        }
            break;
        case 2:
        {
            NSDictionary *province = self.addressArray[self.provinceIndex];
            NSDictionary *city = province[@"cities"][self.cityIndex];
            titleForRow = city[@"areas"][row];
        }
            break;
    }
    return titleForRow;
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            self.provinceIndex = row;
            self.cityIndex = 0;
            self.areaIndex = 0;
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            /**
             *  更新选中的 addresss，包括：市，区
             */
            NSDictionary *province = self.addressArray[self.provinceIndex];
            NSDictionary *city = province[@"cities"][self.cityIndex];
            self.selectedAddress[ProvinceKey] = self.addressArray[row][@"state"];
            if ([province[@"cities"] count] > 0) {
                self.selectedAddress[CityKey] = province[@"cities"][0][@"city"];
            } else {
                self.selectedAddress[CityKey] = @"";
            }
            if ([city[@"areas"] count] > 0) {
                self.selectedAddress[AreaKey] = city[@"areas"][0];
            } else {
                self.selectedAddress[AreaKey] = @"";
            }
        }
            break;
        case 1:
        {
            self.cityIndex = row;
            self.areaIndex = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            /**
             *  更新选中的 addresss，包括：区
             */
            NSDictionary *province = self.addressArray[self.provinceIndex];
            NSDictionary *city = province[@"cities"][self.cityIndex];
            self.selectedAddress[CityKey] = province[@"cities"][row][@"city"];
            if ([city[@"areas"] count] > 0) {
                self.selectedAddress[AreaKey] = city[@"areas"][0];
            } else {
                self.selectedAddress[AreaKey] = @"";
            }
        }
            break;
        case 2:
        {
            self.areaIndex = row;
            /**
             *  更新选中的 addresss
             */
            NSDictionary *province = self.addressArray[self.provinceIndex];
            NSDictionary *city = province[@"cities"][self.cityIndex];
            self.selectedAddress[AreaKey] = city[@"areas"][row];
        }
            break;
    }
}

#pragma mark - getter
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}
- (NSArray *)addressArray {
    if (_addressArray == nil) {
        if ([self.dataSource respondsToSelector:@selector(addressArray)]) {
            _addressArray = [self.dataSource addressArray];
        } else {
            _addressArray = [NSArray array];
        }
    }
    return _addressArray;
}
- (NSMutableDictionary *)selectedAddress {
    if (_selectedAddress == nil) {
        _selectedAddress = [NSMutableDictionary dictionary];
    }
    return _selectedAddress;
}
@end
