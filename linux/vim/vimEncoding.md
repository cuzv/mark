## ÖÐÎÄÂÒÂë½â¾ö°ì·¨
```
set fileencodings=gb2312,gb18030,utf-8  
set termencoding=utf-8  
set encoding=prc  
```

¶þ£º  
```
edit-->lunch setting  
let &termencoding=&encoding  
set fileencodings=utf-8,gbk,gb2312  
```

Õâ¸öÎÊÌâÀ§ÈÅÎÒ¼¸ÌìÁË¡£ÍøÉÏ²éÁËÐí¾Ã£¬ÓÉÓÚËµµÃ²»µ½Î»£¬Ò»Ö±Ã»½â¾ö£¬½ñÌìÓÖÕÛÌÚÁËÒ»ÏÂ£¬ÖÕÓÚ¸ã¶¨¡£  

1¡¢ÏÂÔØ  
¿Éµ½http://www.vim.org/ÏÂÔØ×îÐÂµÄ7.2¡£  

2¡¢°²×°   
±àÒëÖ®Ç°£¬ÏÈÒªconfigure --help²é¿´Ò»ÏÂÅäÖÃÑ¡Ïî£¬   
--enable-multibyte      Include multibyte editing support.   
Ö§³Ö¶à×Ö½Ú±àÂë£¬ÕâÒ»æ??ºÜÖØÒª¡£·ñÔò£¬ºóÃæÈçºÎÅäÖÃÒ²ÊÇÍ÷È»¡£  
È»ºó£¬  
```
[root@localhost wbl]# vim --version | grep multi  
-mouse_jsbterm -mouse_netterm -mouse_sysmouse +mouse_xterm +multi_byte  
+multi_lang -mzscheme +netbeans_intg -osfiletype +path_extra -perl +postscript  
```
²éçœ????ÖÃÊÇ·ñÆð×÷ÓÃ¡£  

 3¡¢ÅäÖÃ  
±à¼­~/.vimrcÎÄ¼þ£¬¼ÓÉÏÈçÏÂ¼¸ÐÐ£º  
```
set fileencodings=gb2312,gb18030,utf-8  
set termencoding=utf-8   
set encoding=prc   
```
 ¼´¿É¸ã¶¨¡£


### ¸½(Vim±àÂëÏêÏ¸½éÉÜ)£º  

Vimå’????ÓÐµÄÁ÷ÐÐÎÄ±¾±à¼­Æ÷Ò»Ñù£¬Vim ¿ÉÒÔºÜºÃµÄ±à¼­¸÷ÖÖ×Ö·û±àÂëµÄÎÄä??£¬Õâµ±È»°üÀ¨ UCS-2¡¢UTF-8 µÈÁ÷ÐÐµÄ Unicode ±àÂë·½Ê½¡£
		
Vim æœ????¸ö¸ú×Ö·û±àÂë·½Ê½ÓÐ¹ØµÄÑ¡Ïî£¬encoding¡¢fileencoding¡¢fileencodings¡¢termencoding (ÕâÐ©Ñ¡Ïî¿ÉÄÜµÄÈ¡ÖµÇë²Î¿¼ Vim ÔÚÏß°ïÖú :help encoding-names)£¬ËüÃÇµÄÒâÒåÈçÏÂ:  
	
1. encoding: Vim ÄÚ²¿Ê¹ÓÃçš????·û±àÂë·½Ê½£¬°üÀ¨ Vim µÄ buffer (»º³åÇø)¡¢²Ëµ¥ÎÄ±¾¡¢ÏûÏ¢ÎÄæœ????¡£ÓÃ»§ÊÖ²áÉÏ½¨ÒéÖ»ÔÚ .vimrc ÖÐ¸Ä±äËüµÄÖµ£¬ÊÂÊµÉÏËÆºõÒ²Ö»ÓÐå?? .vimrc ÖÐ¸Ä±äËüµÄÖµ²ÅÓÐÒâÒå¡£
		
2. fileencoding: Vim ÖÐµ±Ç°±àè??µÄÎÄ¼þµÄ×Ö·û±àÂë·½Ê½£¬Vim ±£´æÎÄ¼þÊ±Ò²»á½«ÎÄ¼þ±£´æÎªÕâÖÖ×Ö·ûç??Âë·½Ê½ (²»¹ÜÊÇ·ñÐÂÎÄ¼þ¶¼Èç´Ë)¡£
	
3. fileencodings: Vim Æô¶¯Ê±ä??°´ÕÕËüËùÁÐ³öµÄ×Ö·û±àÂë·½Ê½ÖðÒ»Ì½²â¼´½«´ò¿ªµÄÎÄ¼þµÄ×Ö·û±àÂë·½å??£¬²¢ÇÒ½« fileencoding ÉèÖÃÎª×îÖÕÌ½²âµ½µÄ×Ö·û±àÂë·½Ê½¡£Òò´Ë×îå??½« Unicode ±àÂë·½Ê½·Åµ½Õâ¸öÁÐ±íµÄ×îÇ°Ãæ£¬½«À­¶¡ÓïÏµ±àÂë·½Ê½ latin1 ·Åµ½×îºóÃæ¡£
	
4. ermencoding: Vim Ëù¹¤×÷µÄÖÕ¶Ë (»òÕß Windows µÄ Console ´°¿Ú) µÄ×Ö·û±àÂë·½Ê½¡£Õâ¸öÑ¡ÏîÔÚ Windows ÏÂ¶ÔÎÒä»????ÓÃµÄ GUI Ä£Ê½µÄ gVim ÎÞÐ§£¬¶ø¶Ô Console Ä£Ê½µÄ Vim ¶øÑÔ¾Íæ˜??Windows ¿ØÖÆÌ¨µÄ´úÂëÒ³£¬²¢ÇÒÍ¨³£ÎÒÃÇ²»ÐèÒª¸Ä±äËü¡£
	
À´¿´¿´ Vim µÄ¶à×Ö·û±àÂë·½Ê½Ö§³ÖÊÇÈçºÎ¹¤×÷µÄ  
1. Vim Æô¶¯£¬¸ù¾Ý .vimrc ä??ÉèÖÃµÄ encoding µÄÖµÀ´ÉèÖÃ buffer¡¢²Ëµ¥ÎÄ±¾¡¢ÏûÏ¢ÎÄµÄ×Ö·û±àç ????Ê½¡£
	
2. ¶ÁÈ¡ÐèÒª±à¼­µÄÎÄ¼þ£¬¸ù¾Ý fileencodings ÖÐÁÐ³öµÄ×Öç¬????Âë·½Ê½ÖðÒ»Ì½²â¸ÃÎÄ¼þ±àÂë·½Ê½¡£²¢ÉèÖÃ fileencoding ÎªÌ½²âµ½ç??£¬¿´ÆðÀ´ÊÇÕýÈ·µÄ (×¢1) ×Ö·û±àÂë·½Ê½¡£
	
3.¶Ô±È fileencoding å’??encoding µÄÖµ£¬Èô²»Í¬Ôòµ÷ÓÃ iconv ½«ÎÄ¼þÄÚÈÝ×ª»»Îª encoding æ??ÃèÊöµÄ×Ö·û±àÂë·½Ê½£¬²¢ÇÒ°Ñ×ª»»ºóµÄÄÚÈÝ·Åµ½Îª´ËÎÄ¼þ¿ª±ÙµÄ buffer Àï£¬´ËÊ±ÎÒÃÇ¾Í¿ÉÒÔ¿ªÊ¼±à¼­Õâ¸öÎÄ¼þÁË¡£×¢Òâ£¬Íê³ÉÕâÒ»²½¶¯×÷éœ????µ÷ÓÃÍâ²¿µÄ iconv.dll (×¢2)£¬ÄãÐèÒª±£Ö¤Õâ¸öÎÄ¼þ´æÔÚÓÚ $VIMRUNTIME »òÕßÆäËûÁÐÔÚ PATH »·¾³±äÁ¿ÖÐµÄÄ¿Â¼Àï¡£
	
(4)±à¼­Íê³Éºó±£´ææ??¼þÊ±£¬ÔÙ´Î¶Ô±È fileencoding ºÍ encoding µÄÖµ¡£Èô²»Í¬£¬ÔÙ´Îµ÷ç?? iconv ½«¼´½«±£´æµÄ buffer ÖÐµÄÎÄ±¾×ª»»Îª fileencoding ËùÃèè¿????×Ö·û±àÂë·½Ê½£¬²¢±£´æµ½Ö¸¶¨µÄÎÄ¼þÖÐ¡£Í¬Ñù£¬ÕâÐèÒªµ÷ÓÃ iconv.dll

ÓÉÓÚ Unicode ÄÜ¹»°üº¬¼¸ºõËùÓÐµÄÓïÑÔµÄ×Ö·û£¬¶øÇÒ Unicode çš??UTF-8 ±àÂë·½Ê½ÓÖÊÇ·Ç³£¾ßÓÐÐÔ¼Û±ÈµÄ±àÂë·½Ê½ (¿Õ¼äÏûºÄ±È UCS-2 Ð¡)£¬Òò´Ë½¨Òé encoding µÄÖµÉèÖÃÎª utf-8¡£ÕâÃ´×öµÄÁíÒ»¸öÀíÓÉÊÇ encoding ÉèÖÃÎª utf-8 Ê±£¬Vim ×Ô¶¯Ì½²âÎÄ¼þµÄ±àÂë·½Ê½»á¸ü×¼È· (æˆ????Õâ¸öÀíÓÉ²ÅÊÇÖ÷ÒªµÄ ;) ¡£ÎÒÃÇÔÚÖÐÎÄ Windows Àï±à¼­µÄÎÄ¼þ£¬ä¸????¼æ¹ËÓëÆäËûÈí¼þµÄ¼æÈÝÐÔ£¬ÎÄ¼þ±àÂë»¹ÊÇÉèÖÃÎª GB2312/GBK ±È½Ïå??ÊÊ£¬Òò´Ë fileencoding ½¨ÒéÉèÖÃÎª chinese (chinese ÊÇ¸ö±ðÃû£¬å?? Unix Àï±íÊ¾ gb2312£¬ÔÚ Windows Àï±íÊ¾ cp936£¬Ò²¾ÍÊÇ GBK µÄä»????Ò³)¡£ 



