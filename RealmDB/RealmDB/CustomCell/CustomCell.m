//
//  CustomCell.m
//  RealmDB
//
//  Created by Van Khanh Vuong on 8/10/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

-(IBAction)btnDelete:(id)sender{
    [self.delegateDelete didTapDeleteCell:(NSString *)self.iddCustomCell];
}
-(IBAction)btnEdit:(id)sender{
    [self.delegateEdit didTapEditCell:(NSString *)self.iddCustomCell];
}

@end
