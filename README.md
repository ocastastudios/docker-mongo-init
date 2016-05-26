# Inititialize a Database

Docker image to run once to create a new database with a new user.

Environment variables:

    - SERVER
    - ADMIN_USER
    - ADMIN_PASSWORD
    - AUTH_DATABASE
    - NEW_DATABASE
    - NEW_USER
    - NEW_PASSWORD

E.g.

    docker run -e SERVER=mongodb -e ADMIN_USER=admin -e ADMIN_PASSWORD=mypass -e AUTH_DATABASE=admin -e NEW_DATABASE=newdb1 -e NEW_USER=newuser1 -e NEW_PASSWORD=password --link mongodb -d ocasta/mongo-init
