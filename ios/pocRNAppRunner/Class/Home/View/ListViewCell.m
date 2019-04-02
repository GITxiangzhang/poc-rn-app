//
//  ListViewCell.m
//  PocDemo
//
//  Created by Kipling on 2019/3/26.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "ListViewCell.h"

@interface ListViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *decImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLb;

@end

@implementation ListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    
    self.decImageView.image = [UIImage imageNamed:dataDic[@"image"]];
    self.titleLb.text = dataDic[@"title"];
    self.subTitleLb.text = dataDic[@"subtitle"];
}

@end
