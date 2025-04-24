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
export function getUserById(id) {
	return getUserByIdQuery.get(id);
}

const getUserByEmailQuery = db.query(`SELECT * FROM User WHERE email = ?`);
export function getUserByEmail(email) {
	return getUserByEmailQuery.get(email);
}


const addProviderQuery = db.query(`INSERT INTO SubscriptionProvider(id, name, is_custom, created_by, carbon_footprint) VALUES (?, ?, 1, ?, ?)`);
export function addProvider(name, carbonFootprint, userId) {
	const id = v4();
	addProviderQuery.run(id, name, userId, carbonFootprint);
	return id;
}


const addSubQuery = db.query(`INSERT INTO Subscription VALUES (?, ?, ?, ?, ?, ?, ?)`);
export function addSubscription(providerId, userId, price, baseDate, recurrenceUnit, recurence) {
	const id = v4();
	addSubQuery.run(id, providerId, userId, price, baseDate, recurrenceUnit, recurence);
	return id;
}

const getUserSubsQuery = db.query(`SELECT * FROM Subscription s 
		                                     JOIN SubscriptionProvider p ON s.provider_id = p.id 
																				 WHERE user_id = ?`);
export function getUserSubscriptions(userId) {
	return getUserSubsQuery.all(userId);
}

function editRow(table, id, edits) {
	let queryText = `UPDATE ${table} SET `;
	const queryArgs = [];
	for (const [k, v] of Object.entries(edits)) {
		queryText += `${k} = ?, `;
		queryArgs.push(v);
	}
	queryText = queryText.slice(0, -2);
	queryText += ` WHERE id = ?`;
	queryArgs.push(id);
}

export function editSubscription(id, edits) {
	editRow('Subscription', id, edits);
}

export function editProvider(id, edits) {
	editRow('SubscriptionProvider', id, edits);
}
