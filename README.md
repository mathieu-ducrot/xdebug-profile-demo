# xdebug-profile-demo

## Local install

Run the following command to install the project.

```shell
make up
# Once the containers have finished being initialized, you will see the following line "MySQL init process done. Ready for start up."
# Then open another terminal and run the following command to install the latest stable version of Symfony.
make install
# Enter your user password to run sudo commands
# Further on, the prompt will ask you "Do you want to include Docker configuration from recipes?", press n and enter to skip the recipe.
```

When you see "Install complete!" on the prompt from the terminal you run the `make install`, go to http://localhost/ to see the project running.

---

symfony-docker stack based on https://github.com/smartbooster/symfony-docker
