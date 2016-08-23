var mysql = require('mysql');
var net = require('net');
var port = 7777;
var pool = mysql.createPool({
    connectionLimit: 3,
    host: 'uprep.etri.re.kr',
    port: 3307,
    user: 'ums',
    database: 'UMSdb',
    password: 'ums'
});

// if(!process.argv[2]) {
//     //console.error("[Usage] " + process.argv[0] + " " + process.argv[1] + " [port]");
//     console.error("[Usage] node rcc.js [start/stop/fcopy/list] \n");
//     process.exit(1);
// } 
// else {
//     if(process.argv[2]=='start' || process.argv[2] == 'stop' || process.argv[2] =='fcopy' || process.argv[2] == 'list') ;
//     else {
//         console.error("[Usage] node rcc.js [start/stop/fcopy/list] \n");
//         process.exit(1);
//     }
// }   

var stdin = process.openStdin();
var command = "";
stdin.addListener("data", function(d) {
    // note:  d is an object, and when converted to a string it will
    // end with a linefeed.  so we (rather crudely) account for that  
    // with toString() and then trim() 
    //console.log("you entered: [" + d.toString().trim() + "]");
        command = d.toString().trim();

        if(command == 'list')
        {
            list = getList();
        }
        else if(command == 'start')
        {
            list = getList(sendCommand, "START");
        }
        else if(command == 'fcopy')
        {
            list = getList(sendCommand, "FCOPY");
        }
        else if(command == 'stop')
        {
            list = getList(sendCommand, "STOP");
        }
        else if(command == 'kill')
        {
            list = getList(sendCommand, "KILL");
        }
        else if(command == 'full')
        {
            list = getList(sendCommand, "FULL");
        }
        else { console.log("command list : list, start, stop, fcopy, kill, full")}

  });

function getList(func, arg) {
    pool.getConnection(function(err, connection) {
        var sqlForSelectList="SELECT ip_address from UMStbl";
        if(err) console.error("err : " + err);
        
        if(!err)
        connection.query(sqlForSelectList, function(err, rows) {
            if(err) console.error("err : " + err);

            console.log(" - " + rows.length + " records");
            for(i=0;i<rows.length;i++) {
                if(!func) console.log("\t["+i+"] " + rows[i].ip_address);
                else {
                    func(rows[i].ip_address, arg);
                }
            }        
            console.log("Success!!"); 
            connection.release();
        });
        
    });
}

function sendCommand(ip_address, cmd) 
{
    
    var client = net.createConnection(port,ip_address);
    
    client.on('connect', function() {
        console.log("connected to " + ip_address + ":" + port);
        client.setEncoding('utf8');
        client.write(cmd);
        //client.destroy();
    });
    
        
 
    
}
