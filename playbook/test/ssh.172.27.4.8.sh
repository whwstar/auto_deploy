#!/usr/bin/expect -f eval spawn omm@ expect { -re yes/no { send yesr; } -re assword: { send omm123r; } timeout { exit } eof { exit } } interact
#!/usr/bin/expect -f
eval spawn  omm@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send omm123r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
#!/usr/bin/expect -f
eval spawn  omm@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send omm123r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
#!/usr/bin/expect -f
eval spawn  root@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send 123456r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
#!/usr/bin/expect -f
eval spawn  root@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send 123456r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
#!/usr/bin/expect -f
eval spawn  root@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send 123456r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
#!/usr/bin/expect -f
eval spawn  root@172.27.4.8
expect {
    -re yes/no {
         send yesr;
     } -re assword: {
         send 123456r;
     } timeout {
         exit
     } eof {
         exit
     }
 }
 
 interact
