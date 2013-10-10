//
//  MAMCommentTableViewCell.m
//  Hacker News
//
//  Created by mmackh on 6/17/13.
//  Copyright (c) 2013 Maximilian Mackh. All rights reserved.
//

#import "MAMCommentTableViewCell.h"
#import "TTTAttributedLabel.h"

@implementation MAMCommentTableViewCell
{
    int _indent;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    for(NSLayoutConstraint *cellConstraint in self.constraints){
        [self removeConstraint:cellConstraint];
        id firstItem = cellConstraint.firstItem == self ? self.contentView : cellConstraint.firstItem;
        id seccondItem = cellConstraint.secondItem == self ? self.contentView : cellConstraint.secondItem;
        NSLayoutConstraint* contentViewConstraint =
        [NSLayoutConstraint constraintWithItem:firstItem
                                     attribute:cellConstraint.firstAttribute
                                     relatedBy:cellConstraint.relation
                                        toItem:seccondItem
                                     attribute:cellConstraint.secondAttribute
                                    multiplier:cellConstraint.multiplier
                                      constant:cellConstraint.constant];
        [self.contentView addConstraint:contentViewConstraint];
    }
    if ([MAMHNController isPad])
    {
        [self.comment setFont:[UIFont systemFontOfSize:18]];
    }
    [self.comment setDataDetectorTypes:NSTextCheckingTypeLink];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float indentPoints = self.indentationLevel * self.indentationWidth;
    self.contentView.frame =
    CGRectMake(
    indentPoints,
    self.contentView.frame.origin.y,
    self.contentView.frame.size.width - indentPoints,
    self.contentView.frame.size.height
    );
}

+ (CGFloat)heightForCellWithText:(NSString *)text constrainedToWidth:(float)width
{
    CGFloat height = 40;
    static UIFont *font = nil;
    if (!font)
    {
        font = [UIFont systemFontOfSize:([MAMHNController isPad]?18:16)];
    }
    CGRect fontRect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
    return height + fontRect.size.height;
}

@end
