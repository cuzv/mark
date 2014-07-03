电子邮件基本概念：

**MUA（Mail User Agent）      接收邮件所使用的邮件客户端，使用IMAP或POP3协议与服务器通信**  
**MTA（Mail Transfer Agent） 通过SMTP发送、转发邮件**  
**MDA（Mail Deliver Agent）  将MTA接收到的邮件保存到磁盘或指定地方，通常会进行垃圾邮件及病毒扫描**  
**MRA（Mail Receive Agent） 负责实现IMAP与POP3协议，与MUA进行交互**  

**SMTP（Simple Mail Transfer Protocol）  传输发送邮件所使用的标准协议**  
**IMAP（Internet Message Access Protocol） 接收邮件使用的标准协议之一**  
**POP3（Post Office Protocol 3） 接收邮件使用的标准协议之一**  
 
常用的MUA有：outlook、thunderbird、Mac Mail、mutt  
常用的MTA服务有：sendmail、postfix  
常用的MDA有：procmail、dropmail  
常用的MRA有：dovecot  
