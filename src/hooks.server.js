import jwt from "jsonwebtoken";
import {JWT_SECRET} from "$env/static/private";
import {getUserById} from "$lib/db";

export const handle = async ({event, resolve}) => {
	const token = event.cookies.get('auth');
	if (!token) return await resolve(event);

	try {
		const data = jwt.verify(token, JWT_SECRET);
		const user = getUserById(data.userId);
		if (!user) {
			event.cookies.delete('token', {path: '/'});
			return await resolve(event);
		}
		delete user.password_hash;
		event.locals.user = user;
	} catch (e) {
		event.cookies.delete('token', {path: '/'});
	}
	return await resolve(event);
};