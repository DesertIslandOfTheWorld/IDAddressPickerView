//
//  ViewController.m
//  IDAddressPickView
//
//  Created by Island on 16/7/15.
//  Copyright © 2016年 Island. All rights reserved.
//

#import "ViewController.h"
#import "IDAddressPickerView.h"

@interface ViewController () <IDAddressPickerViewDataSource>
/** textField */
@property (nonatomic, strong) UITextField *textField;
/** addressPickerView */
@property (nonatomic, strong) IDAddressPickerView *addressPickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  添加 textField
     */
    [self.view addSubview:self.textField];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textField.frame = CGRectMake(0, 20, 100, 44);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.addressPickerView.selectedAddress);
}

#pragma mark - IDAddressPickerViewDataSource
- (NSArray *)addressArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSArray *addressInfo = [NSArray arrayWithContentsOfFile:path];
    return addressInfo;
}

#pragma mark - getter
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入";
        _textField.inputView = self.addressPickerView;
    }
    return _textField;
}
- (IDAddressPickerView *)addressPickerView {
    if (_addressPickerView == nil) {
        _addressPickerView = [[IDAddressPickerView alloc] init];
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}
@end
