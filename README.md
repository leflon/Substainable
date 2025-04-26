# Sub'stainable
## Eco-friendly subscription manager

**Sub'stainable** is an eco-friendly tool that allows you to track each of your
subscriptions, giving you a clear idea of how much you pay each month, while 
offering you insights on your carbon footprint.

## Installation
This tool was made with **Svelte 5** (sveltekit) and **SQLite**, using the
**Bun** runtime

### Installing Bun
#### Linux & macOs
```bash 
curl -fsSL https://bun.sh/install | bash
```
#### Windows
```bash
powershell -c "irm bun.sh/install.ps1 | iex"
```

#### Cloning the repository
#### Using git
```bash
git clone https://github.com/leflon/TI616I-Project.git
```
#### Using the GitHub CLI
```bash
gh repo clone leflon/TI616I-Project
```
### Installing dependencies
```bash 
bun install
```
### Setting up the database
You can find database **schemas** and **base data** in `src/db`. Use these files
to populate your database: 

**WARNING: This will wipe all data from your Sub'stainable database. if you 
already hade one before running this command.**
```bash 
sqlite3 db.sqlite < src/sb/tables.sql
```
```bash 
sqlite3 db.sqlite < src/sb/providers.sql
```

### Setting env variables
This projects uses `jsonwebtoken` to keep track of auth sessions. This 
Related settings are set in environment variables. You can find these in `.
env.example`. Simply rename this file `.env` and fill in the values to make 
it work.

### Start the dev environment
You can start the dev envinroment
```bash
bun run dev
```
**Make you use this command. Using `vite dev` will use Node.js instead of 
Bun, which is not supported since our project relies on the `bun:sqlite` 
module.**

If you need to run `vite` commands, you can do it like so:  `bun --bun vite`,
ensuring that the `bun` runtime is used.


### Deployment
After installing the project, you can deploy it using any platform you like, as long as it supports Bun.

#### Building the app
```bash
bun run build
```
(Do not use `bun build`, it is an unrelated command)

#### Running the project
```bash
[PORT=your_prefered_port] bun build/index.js
```
You can also use a process manager like `pm2`.


## Authors
 - Adèle Chamoux
 - Mattéo Launay
 - Paul Leflon
 - Iriantsoa Rasoloarivalona