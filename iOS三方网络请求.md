xmbp:mark cuan$ ls
FunnyStuffOnGitHub.md     RegularExpression.md      lamp.md
GitBasicManual.md         TerminalCommand.md        pptpd6.sh
GitReferenceSummary.md    VPS搭建VPN.md             root@192.243.119.92
IOS知识点.md              centos搭建lamp.md         untitled.txt
MarkdownSyntax.md         iOSDevelopmentSites.md    面试和算法心得.md
README.md                 javascript学习资料.md
xmbp:mark cuan$ nano iOS三方网络请求.md






















  GNU nano 2.0.6                  File: iOS三方网络请求.md                                Modified  


*SDWebImage是基于ARC的*

依赖库：

        - ImageIO.framework
        - MapKit.framework

### 图片异步加载方法

        - (void)setImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeholder;
        - (void)setImageWithURL:(NSURL *)rul forState:(UIControlState)state;

### 清除图片缓存

    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory]; 









^G Get Help     ^O WriteOut     ^R Read File    ^Y Prev Page    ^K Cut Text     ^C Cur Pos
^X Exit         ^J Justify      ^W Where Is     ^V Next Page    ^U UnCut Text   ^T To Spell
