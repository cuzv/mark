- `set | more`  
- `env`  
- `$FAV_CLOLOR=blue`  

- `HISTFILESIZE	`  
- `COLUMNS  `  
- `LINES  `  

- `echo $PS1`  
- \d		today`s date  
- \h		short hostname  
- \t		current time  
- \u 		user name  
- \w		current working directory  
- \!		the history number of current command  
- \$i		show $ if you are a non-privileded user and   
 			# if you are a privileged user  
- \l		the basename of the shells terminal device name  

- `alias`  
- `alias lf='ls -laF'`  

- `set -o`  
- `set -o noclobber`  
- `set -o vi`  

- `export FAV_COLOR`  
- `unset FAV_COLOR`  

- `echo $HOME`  
- `echo $LANG`  
- `echo $PWD`  
- `echo $TERM`  
- `echo $PATH`  

' " | & ; ( ) { } ~ * ? [ ] > >> < << 2> 2>>  

login shells:  
- `/etc/profile`  
	- `/etc/profile.d `  
- `~/.bash_profile`  
	- `~/etc/bashrc`  

non-login shells:  
- `~/.bashrc`  
	- `/etc/bashrc`  
		- `/etc/profile.d`  
