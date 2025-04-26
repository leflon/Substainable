import {redirect} from "@sveltejs/kit";
import jwt from "jsonwebtoken";
import {JWT_MAX_DAYS, JWT_SECRET} from "$env/static/private";
import {getUserByEmail} from "$lib/db.js";
import bcrypt from "bcrypt";

export const POST = async ({request, cookies}) => {
	const data = await request.formData();
	const email = data.get('email');
	const password = data.get('password');

	if (!email || !password)
		return redirect(303,'/auth?login_error=missing_fields');

	const user = getUserByEmail(email);

	if (!user)
		return redirect(303,'/auth?login_error=invalid_credentials');

	const validPassword = bcrypt.compareSync(password, user.password_hash);

	if (!validPassword)
		return redirect(303,'/auth?login_error=invalid_credentials');

	const {id: userId} = user;
	const token = jwt.sign({userId}, JWT_SECRET, {
		expiresIn: JWT_MAX_DAYS + 'd'
	});

	cookies.set('auth', token, {
		maxAge: 60 * 60 * 24 * JWT_MAX_DAYS,
		httpOnly: true,
		sameSite: 'lax',
		secure: false,
		path: '/'
	});
	return redirect(303, '/');
}