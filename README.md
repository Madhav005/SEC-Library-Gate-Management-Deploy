# Library Deployment Guide

This project is containerized using Docker.

## Prerequisites
- Docker
- Docker Compose

## How to Start

To build and start the application:

```bash
docker-compose up --build -d
```

- The application will be available at: `http://localhost:8080`
- The database will be available on port `3306`.


## How to Stop

To stop the containers:

```bash
docker-compose down
```

## Database Management (Deploying `backup.sql`)

The `backup.sql` file is used to initialize the database.

**Scenario A: Fresh Installation (or Reset)**
If you are deploying on a new machine or want to **wipe everything** and start fresh with your `backup.sql`:

1.  Place your `backup.sql` in the folder.
2.  Run the following (WARNING: Deletes all existing data):
    ```bash
    docker-compose down -v
    docker-compose up --build -d
    ```
    *The `-v` flag removes the old database volume, forcing MySQL to re-import `backup.sql` on startup.*

**Scenario B: Update Existing Database (Keep Data)**
If the application is already running and you want to apply the schema from `backup.sql` without deleting existing data:

1.  Copy the new `backup.sql` to the folder.
2.  Run this command to import it manually:
    ```bash
    docker exec -i library_deploy-db-1 mysql -u root -proot library_db < backup.sql
    ```

## Database Management (Exporting Data)

If you want to **save** the current data from the running Docker container into a SQL file (to move it to another computer):

1.  Run this command:
    ```bash
    docker exec library_deploy-db-1 mysqldump -u root -proot library_db > my_data_backup.sql
    ```
2.  You will now have a file named `my_data_backup.sql` in your folder.
3.  You can take this file to the other computer, rename it to `backup.sql`, and use the "Fresh Installation" steps above to deploy it.
