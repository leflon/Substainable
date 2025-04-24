import {redirect} from "@sveltejs/kit";
import {addUser, getUserByEmail} from "$lib/db.js";
import jwt from "jsonwebtoken";
import {JWT_MAX_DAYS, JWT_SECRET} from "$env/static/private";

export const POST = async ({request, cookies}) => {
	const data = await request.formData();

	const email = data.get('email');
	const password = data.get('password');

	if (!email || !password)
		return redirect(303,'/auth?register_error=missing_fields');

	const user = getUserByEmail(email);

	if (user)
		return redirect(303,'/auth?register_error=email_taken');

	const userId = addUser(email, password);

	const token = jwt.sign({userId}, JWT_SECRET, {
		expiresIn: JWT_MAX_DAYS + 'd'
	});

	cookies.set('auth', token, {
		maxAge: 60 * 60 * 24 * JWT_MAX_DAYS,
		httpOnly: true,
		sameSite: 'lax',
		secure: true,
		path: '/'
	});

	return redirect(303, '/');

}