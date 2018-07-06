# SCHOOL APPLICATION

* Database setup:

  Check  `config/database.yml` file, there you can find default username and password to access db.

  To everything works, you should create a new user:

  In terminal: `sudo su postgres`

  Then: `psql`

  Create user: `CREATE USER school_app WITH PASSWORD '12345678';`

  Grant all privileges: `ALTER USER school_app WITH SUPERUSER`

  `\q` and `exit` to exit

  Finally, run `rake db:setup` in your app directory.
