
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 3,
    host: 'mysql',
    user: 'ums',
    database: 'UMSdb',
    password: 'ums'
});


var default_client_cnf="[SERVER]\n\
CHANNEL_SERVER_URL=http://129.254.221.116:9001/ixs\n\
OVERLAY_SERVER_URL=http://129.254.221.116:9010/oms\n\
PAM_SERVER_IP=\n\
[USER]\n\
ID=peer1\n\
PEERID=635986603853242298\n";

var default_prep_cnf="[BUFFER_SIZE]\n\
300\n\
[MAX_AGENT_COUNT]\n\
2\n\
[MAX_PEER_COUNT]\n\
2\n\
[EMPTY_SECTION_SIZE]\n\
10\n\
[MAX_PARTNER_COUNT]\n\
10\n\
[MAX_RETRY_COUNT]\n\
5\n\
[DOWNLOAD_WINDOW_SIZE]\n\
200\n\
[MAX_SKIP_COUNT]\n\
3\n\
[ADD_PARTNER_COUNT]\n\
3\n\
[MAX_UPLOAD_BYTE]\n\
0\n\
[MAX_DOWNLOAD_BYTE]\n\
0";


// var default_client_cnf = "test client cnf\nshit";
// var default_prep_cnf = "test prep cnf\nfuck";

module.exports = function(app)
{

    ////////////////////////////////////////////////
    // 첫 페이지
    ////////////////////////////////////////////////
    // app.get('/', function(req, res) {
    //     res.render('index.html');
    // });

    ////////////////////////////////////////////////
    // 전체 목록 조회 
    ////////////////////////////////////////////////
    app.get('/', function(req, res) {
        pool.getConnection(function(err, connection) {
            var sqlForSelectList="SELECT user_id, client_cnf, prep_cnf from UMStbl";
            if(err) console.error("err : " + err);
            
            if(!err)
            connection.query(sqlForSelectList, function(err, rows) {
                if(err) console.error("err : " + err);

                res.render('index', {
                    title: "LIST of peers",
                    rows: rows
                });
                connection.release();
            });
        })

    });

    ////////////////////////////////////////////////
    // 유저 상태 조회
    ////////////////////////////////////////////////
    app.get('/user/:user_id', function(req, res) {

        var user_id = req.params.user_id;
        
        if(user_id)
        {
            pool.getConnection(function(err, connection) {
                var sqlForSelectList="SELECT user_id, client_cnf, prep_cnf from UMStbl where user_id ='" + req.params.user_id + "'";
                
                connection.query(sqlForSelectList, function(err, rows) {
                    if(err) console.error("err : " + err);

                    res.render('user', {
                        title: "User Info",
                        user_id : rows[0].user_id,
                        client_cnf : rows[0].client_cnf.replace(/<br\s*\/?>/mg,"\n"),
                        prep_cnf : rows[0].prep_cnf.replace(/<br\s*\/?>/mg,"\n")
                    });
                    connection.release();
                });
            });
        }
        else
        {
            res.render('user', {
                    title: "User Info",
                    user_id : user_id,
                    client_cnf : "empty",
                    prep_cnf : "empty"
            });
        }

    });

    app.get('/user/:user_id/config', function(req, res) {

        var user_id = req.params.user_id;     
        if(user_id)
        {
            pool.getConnection(function(err, connection) {
                var sqlForSelectList="SELECT client_cnf from UMStbl where user_id ='" + req.params.user_id + "'";
                
                connection.query(sqlForSelectList, function(err, rows) {
                    if(err) console.error("err : " + err);

                    res.render('config', {
                        client_cnf : rows[0].client_cnf.replace(/<br\s*\/?>/mg,"\n")
                    });
                    connection.release();
                });
            });
        }
    });
    app.get('/user/:user_id/prepagent', function(req, res) {

        var user_id = req.params.user_id;     
        if(user_id)
        {
            pool.getConnection(function(err, connection) {
                var sqlForSelectList="SELECT prep_cnf from UMStbl where user_id ='" + req.params.user_id + "'";
                
                connection.query(sqlForSelectList, function(err, rows) {
                    if(err) console.error("err : " + err);

                    res.render('prepagent', {
                        prep_cnf : rows[0].prep_cnf.replace(/<br\s*\/?>/mg,"\n")
                    });
                    connection.release();
                });
            });
        }
    });

    ////////////////////////////////////////////////
    // 신규 사용자 등록
    ////////////////////////////////////////////////
    app.post('/register', function(req, res) {
        var new_id=req.body.new_id;
        if(!new_id) {
            console.error("no information");
            return;
        }
        pool.getConnection(function(err, connection) {
            var sqlForSelectList="INSERT INTO UMStbl (user_id, client_cnf, prep_cnf) \
                                    VALUES ('"+new_id+"','" + default_client_cnf + "','" + default_prep_cnf + "')"; 
                                    

            if(err) console.error("err : " + err);
            
            if(!err)
            connection.query(sqlForSelectList, function(err, rows) {
                if(err) console.error("err : " + err);

                res.redirect('/');
                connection.release();
            });
        })       
    });

    ////////////////////////////////////////////////
    // 사용자 업데이트 
    ////////////////////////////////////////////////
    app.post('/update', function(req, res) {
        var user_id=req.body.user_id;
        var prep_cnf=req.body.prep_cnf;
        var client_cnf=req.body.client_cnf;

        prep_cnf = prep_cnf.replace(/\r?\n/g, '<br/>');
        client_cnf = client_cnf.replace(/\r?\n/g, '<br/>');

        // console.log(user_id);
        // console.log(prep_cnf);
        // console.log(client_cnf);

        pool.getConnection(function(err, connection) {
            var sqlForUpdate="UPDATE UMStbl SET client_cnf = '" + client_cnf + "', prep_cnf = '" + prep_cnf + "' \
                                    WHERE user_id = '" + user_id + "'";
                                 
            if(err) console.error("err : " + err);
            
            if(!err)
            connection.query(sqlForUpdate, function(err, rows) {
                if(err) console.error("err : " + err);

                res.redirect('/');
                connection.release();
            });
        })       
    });
    ////////////////////////////////////////////////
    // 유저 삭제
    ////////////////////////////////////////////////
    app.get('/delete/:user_id', function(req, res) {

        var user_id = req.params.user_id;
        
        if(user_id)
        {
            pool.getConnection(function(err, connection) {
                var sqlForSelectList="DELETE from UMStbl where user_id ='" + req.params.user_id + "'";
                
                connection.query(sqlForSelectList, function(err, rows) {
                    if(err) console.error("err : " + err);

                    res.redirect('/');
                    connection.release();
                });
            });
        }

    });


    app.get('/about', function(req, res) {
        res.render('about.html')
    });
}
