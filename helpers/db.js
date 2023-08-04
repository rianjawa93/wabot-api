const mysql = require('mysql2/promise');
const createConnection = async () => {
	return await mysql.createConnection({
		host: 'localhost',
		user: 'root',
		password: '',
		database: 'wa_api'
	});
}

const getReply = async (keyword) => {
	const connection = await createConnection();
	const [rows] = await connection.execute('SELECT message FROM wa_replay WHERE keyword = ? AND exception != 1 ', [keyword]);

	if (rows.length > 0) return rows[0].message;
	return false;
}

const getMy = async (from) => {
	const connection = await createConnection();
	const [rows] = await connection.execute('SELECT message FROM v_wa_contact WHERE from_number = ?', [from]);

	if (rows.length > 0) return rows[0].message;
	return false;
}

const getMypwd = async (from) => {
	const connection = await createConnection();
	const [rows] = await connection.execute('SELECT password FROM wa_contact WHERE from_number = ?', [from]);

	if (rows.length > 0) return rows[0].password;
	return false;
}

const getInfo = async () => {
	const connection = await createConnection();
	const [rows] = await connection.execute('SELECT message FROM v_info');

	if (rows.length > 0) return rows[0].message;
	return false;
}

const getPilih = async () => {
	const connection = await createConnection();
	const [rows] = await connection.execute('SELECT message FROM v_wa_pilih');

	if (rows.length > 0) return rows[0].message;
	return false;
}

module.exports = {
	createConnection,
	getReply,
	getMy,
	getMypwd,
	getInfo,
	getPilih
}