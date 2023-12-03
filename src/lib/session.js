import { writable, get } from 'svelte/store';
import { Surreal } from 'surrealdb.js';

export const db = new Surreal();

export const session = writable({
	email: '',
    first_name: '',
    last_name: ''
});

export async function usedb() {
    await db.connect('http://127.0.0.1:8000/rpc');
    await db.use({ namespace: 'test', database: 'test' });
    await db.wait();
}

export async function create_user(user, email, password, first_name, last_name) {
    try {
        // Connect to the databasex
        await usedb();

        // Create a new person with a random id
        const token = await db.signup({
            scope: 'account',
            namespace: 'test',
            database: 'test',

            user: user,
            email: email,
            pass: password,
            first_name: first_name,
            last_name: last_name,
        });

        localStorage.setItem('token_auth', token);

        const usuario = await db.info();
        session.update((old) => {
            old.email = usuario.email;
            old.first_name = usuario.first_name;
            old.last_name = usuario.last_name;
            return old;
        });

        console.log('Connected to SurrealDB with new user');
        console.log('User: ', usuario.email);

        return true;
    } catch (e) {
        console.error('ERROR', e);
        return false;
    }
}

export async function connect(email, password) {

    try {
        // Connect to the databasex
        await usedb();

        if (localStorage.getItem('token_auth') !== null) {
            await db.authenticate(localStorage.getItem('token_auth'));
            const usuario = await db.info();

            

            console.log('Connected to SurrealDB with token');
            console.log('User: ', usuario.email);

            session.update((old) => {
                old.email = usuario.email;
                old.first_name = usuario.first_name;
                old.last_name = usuario.last_name;
                return old;
            });

            return true;
        } else if (email == "" || password == "") {
            return false;
        } else {
            let token = await db.signin({
                scope: 'account',
                email: email,
                pass: password,
            });
            localStorage.setItem('token_auth', token);
    
            const usuario = await db.info();
            session.update((old) => {
                old.email = usuario.email;
                old.first_name = usuario.first_name;
                old.last_name = usuario.last_name;
                return old;
            });
    
            console.log('Connected to SurrealDB');
            console.log('User: ', usuario.email);
    
            return true;
        }        
    } catch (e) {
        console.error('ERROR', e);
        return false;
    }
}

async function crear() {
    try {

        // Create a new person with a random id
        const created = await db.create('person', {
            title: 'Founder & CEO',
            name: {
                first: 'Tobie',
                last: 'Morgan Hitchcock',
            },
            marketing: true,
            identifier: Math.random().toString(36).substr(2, 10),
        });

        // Update a person record with a specific id
        const updated = await db.merge('person:jaime', {
            marketing: true,
        });

        // Select all people records
        const people = await db.select('person');

        // Perform a custom advanced query
        const groups = await db.query(
            'SELECT marketing, count() FROM type::table($tb) GROUP BY marketing',
            {
                tb: 'person',
            }
        );
    } catch (e) {
        console.error('ERROR', e);
    }
}

export async function get_current_user() {
	// If logged in, don't make unneeded api calls
	// Retrieve session svelte store
	let session_store = get(session);
	if (session_store.user !== '' && document.cookie.includes('token_auth=')) {
		return true;
	} else if (session_store.user == '' && document.cookie.includes('token_auth')) {
		previously_logged_in();
		return false;
	}

	const response = await fetch('/api/user/');
	const data = await response.json();
	if (data.error == null) {
		session.update((old) => {
			old.user = data.name;
			return old;
		});
		return true;
	} else {
		previously_logged_in();
		return false;
	}
}
