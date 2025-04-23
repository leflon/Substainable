import { Database } from 'bun:sqlite';
import bcrypt from "bcrypt";
import {v4} from "uuid";

const db = new Database('db.sqlite');
db.exec("PRAGMA journal_mode = WAL;");

const addUserQuery = db.query(`INSERT INTO User(id, email, password_hash) VALUES (?, ?, ?)`);
export function addUser(email, password) {
	const hash = bcrypt.hashSync(password, 10);
	const id = v4();
	addUserQuery.run(id, email, hash);
	return id;
}


const getUserByIdQuery = db.query(`SELECT * FROM User WHERE id = ?`);
export function getUser({id, email}) {
	return getUserByIdQuery.get(id);
}

const getUserByEmailQuery = db.query(`SELECT * FROM User WHERE email = ?`);
export function getUserByEmail(email) {
	return getUserByEmailQuery.get(email);
}