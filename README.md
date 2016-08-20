# MP2P-UMS

## UMS (User Management Server)
**DESC**

add/remove/update user information

**USAGE**
- run server application
``` 
$ node ums.js
```
- http://ip-address:7000
- http://ip-address:7000/user-name/config
- http://ip-address:7000/user-name/prepagent

## Remote control application

### rcc (client)
**DESC**

Sends control messages to multiple peers.
it can 
- force to copy updated binaries to designated folder
- startup all registered peer applications by use of network
- stop all registered peer applications
- list up all registered peers

**USAGE**
- run server application
``` 
$ node rcs.js [port]
```


### rcs (server)
**DESC**

just TCP server application for debugging

**USAGE**
- run server application
``` 
$ node rcs.js [port]
```
