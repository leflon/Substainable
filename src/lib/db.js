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

const getProvidersQuery = db.query(`SELECT * FROM SubscriptionProvider WHERE is_custom = 0`);
export function getProviders() {
	return getProvidersQuery.all();
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

const getUserSubsQuery = db.query(`SELECT s.*, p.id as provider_id, p.name, p.carbon_footprint, p.is_custom, p.logo_url 
                                   FROM Subscription s 
		                                     JOIN SubscriptionProvider p ON s.provider_id = p.id 
																				 WHERE user_id = ?`);
export function getUserSubscriptions(userId) {
	return getUserSubsQuery.all(userId).map(row => ({...row, baseDate: new Date(row.baseDate)}));
}

const getSubQuery = db.query(`SELECT s.*, p.id as provider_id, p.name, p.carbon_footprint, p.is_custom, p.logo_url 
                                   FROM Subscription s 
		                                     JOIN SubscriptionProvider p ON s.provider_id = p.id 
																				 WHERE s.id = ?`);
export function getSubscriptionById(id) {
	return getSubQuery.get(id);
}

const deleteSubQuery = db.query(`DELETE FROM Subscription WHERE id = ?`);
export function deleteSubscription(id) {
	deleteSubQuery.run(id);
}


const getProjectsQuery = db.query(`SELECT * FROM EcoProject`);
export function getEcoProjects() {
	return getProjectsQuery.all();
}