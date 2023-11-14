const mysql = require('mysql2');

const conection = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'demop',
  waitForConnections: true,
  connectionLimit: 10,
  maxIdle: 10, // max idle connections, the default value is the same as `connectionLimit`
  idleTimeout: 60000, 
  queueLimit: 0,
  enableKeepAlive: true,
  keepAliveInitialDelay: 0,
});
module.exports = conection;