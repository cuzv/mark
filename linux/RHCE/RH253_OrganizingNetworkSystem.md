## Domain Name System  
- forward lookup  
- reverse lookup  
- by name domains  
- email routing info  

## Zone,Domains, & Delegation  
- a domain is a NDS scope  
- a zone is teh part of the domain  
- subdomains  

## Name Server Hierarchy  
- Master name server  
	- Contains the master copy of data for zone  
		- domain forward lookup zone file  
		- domain reverse lookup zone file  
		- named.ca  
		- localhost zone  
		- named local  
- Slave name server  
	- Provides a backup to the master name server  
	- All slave servers maintain synchronization with their master name server	  

## The DNS Server  
## Berkeley Internet Name Domain  
## Service Profile: DNS  
- type: 		system v  
- packages:	bind,bind-utils,bind-chroot  
- daemons:	named,rndc  
- script:	53(named) 953(rndc)  
- prots:	/var/named/chroot,/etc/named.conf,/var/named/*,/etc/rndc*
- related:	caching-nameserver,openssl  

## bind-chroot  
## Configuring BIND  
- `/var/named/chroot/etc/named.conf`  
- zones,options,acl,etc
## Global Options  

## Address Control Lists  
## Name Daemon Control Utility  
## Master and Slave Zones  
## Reverse Lookup Zones  
## Root Zone and Loopback Zone  
## Zone Files  
## Resource Records  
## SOA(Start of Authority)  
## NS(Name Sever)  
## Main Record Types  
## Example Zone File  
## Round Robin Load Sharing Throuth DNS  
## Delegating Subdomains  
## BIND Syntax Utilities  
## Caching-only Name Server  
## BIND Utilities  
## Advanced BIND Features  
## DHCP Overview  
## Service Profile: DHCP  
## Configuring a DHCP Server  
