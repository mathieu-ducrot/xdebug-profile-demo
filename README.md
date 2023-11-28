# xdebug-profile-demo

## Local install

Run the following command to install the project for the first time.

```shell
make up
# Once the containers have finished being initialized, you will see the following line "MySQL init process done. Ready for start up."
# Then open another terminal and run the following command to install the vendors.
make install
# Enter your user password to run the sudo commands require to set the missing directory/permissions
```

When you see "Install complete!" on the prompt from the terminal where you run the `make install`, go to http://localhost/ to see the project running.

Each request to http://localhost/ will generate an xdebug profile of the HomeController on the docker/xdebug_profile directory.

Don't forget to fix the owning permissions of the profile before running kcachegrind with the following command :

```bash
sudo chown {username}:{username} docker/xdebug_profile/cachegrind.out._*
```

## Run the project if already install

Simply run `make up` you don't need to redo the install command.

---

symfony-docker stack based on https://github.com/smartbooster/symfony-docker
