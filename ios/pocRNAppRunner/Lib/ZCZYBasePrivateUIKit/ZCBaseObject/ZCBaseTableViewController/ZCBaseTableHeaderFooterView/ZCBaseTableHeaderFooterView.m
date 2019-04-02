//
//  ZCBaseTableHeaderFooterView.m
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseTableHeaderFooterView.h"

@implementation ZCBaseTableHeaderFooterView

- (void)fillData:(id)data {
    if (!data) {
        return;
    }
}

+ (CGFloat)computeHeight:(id)data {
    return 0.001f;
}

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"HeaderFooterID"];
    [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}

+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView {
    if (tableView == nil) {
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    }
    NSString *classname = NSStringFromClass([self class]);
    NSString *identifer = [classname stringByAppendingString:@"nibHeaderFooterID"];
    UINib *nib = [UINib nibWithNibName:classname bundle:nil];
    [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifer];
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
}

+ (NSString *)getReuserIdentifer {
    
    NSString *className = NSStringFromClass([self class]);
    NSString *reuseID = [className stringByAppendingString:@"HeaderFooterID"];
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    if (nib) {
        reuseID = [className stringByAppendingString:@"nibHeaderFooterID"];
    }
    return reuseID;
}

@end
