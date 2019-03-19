//
//  WYAArticleTableViewCell.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAArticleTableViewCell.h"
@interface WYAArticleTableViewCell()
@property (nonatomic, strong) UILabel * articleTitleLabel;
@property (nonatomic, strong) UIButton * forwardingButton;
@property (nonatomic, strong) UILabel * articleContentLabel;
@property (nonatomic, strong) UIImageView * articleImageView;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * forwardingNumLabel;
@property (nonatomic, strong) UILabel * readeNumLabel;
@property (nonatomic, strong) UIButton * bgButton;
@end

@implementation WYAArticleTableViewCell

#pragma mark ======= LifeCircle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.bgButton addSubview:self.articleTitleLabel];
        [self.bgButton addSubview:self.forwardingButton];
        [self.bgButton addSubview:self.articleContentLabel];
        [self.bgButton addSubview:self.articleImageView];
        [self.bgButton addSubview:self.timeLabel];
        [self.bgButton addSubview:self.forwardingNumLabel];
        [self.bgButton addSubview:self.readeNumLabel];

        [self.contentView addSubview:self.bgButton];
    }
    return self;
}

#pragma mark ======= Lazy
- (UILabel *)articleTitleLabel{
    if(!_articleTitleLabel){
        _articleTitleLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object;
       });
    }
    return _articleTitleLabel;
}

- (UIButton *)forwardingButton{
    if(!_forwardingButton){
        _forwardingButton = ({
            UIButton * object = [[UIButton alloc]init];
            object;
       });
    }
    return _forwardingButton;
}

- (UILabel *)articleContentLabel{
    if(!_articleContentLabel){
        _articleContentLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object;
        });
    }
    return _articleContentLabel;
}

- (UIImageView *)articleImageView{
    if(!_articleImageView){
        _articleImageView = ({
            UIImageView * object = [[UIImageView alloc]init];
            object;
       });
    }
    return _articleImageView;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object;
       });
    }
    return _timeLabel;
}


- (UILabel *)forwardingNumLabel{
    if(!_forwardingNumLabel){
        _forwardingNumLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object;
        });
    }
    return _forwardingNumLabel;
}



- (UILabel *)readeNumLabel{
    if(!_readeNumLabel){
        _readeNumLabel = ({
            UILabel * object = [[UILabel alloc]init];
            object;
       });
    }
    return _readeNumLabel;
}

- (UIButton *)bgButton{
    if(!_bgButton){
        _bgButton = ({
            UIButton * object = [[UIButton alloc]init];
            object;
       });
    }
    return _bgButton;
}


@end
