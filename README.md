# Inititialize a Database

Docker image to run once to create a new mongo database with a new user.

Environment variables:

    - HOST
    - ADMIN_USER
    - ADMIN_PASSWORD
    - AUTH_DATABASE
    - NEW_DATABASE
    - NEW_USER
    - NEW_PASSWORD

All except AUTH_DATABASE are mandatory which defaults to *admin*

E.g.

    docker run -e HOST=rs/mymongo-1:27017,mymongo-2:27017 -e ADMIN_USER=admin -e ADMIN_PASSWORD=mypass -e AUTH_DATABASE=rudolph -e NEW_DATABASE=newdb1 -e NEW_USER=newuser1 -e NEW_PASSWORD=password --link mongodb -d ocasta/mongo-init
