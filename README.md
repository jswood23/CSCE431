# README

## Introduction ##

The MCHSO Info Organizer is a website containing both external pages for all internet traffic and internal pages for tracking membership.

## Requirements ##

This code has been run and tested on:

* Ruby - ruby 3.0.2p107
* Rails - 6.1.6.1
* Ruby Gems - Listed in `Gemfile`
* (PostgreSQL - 13.3)
* (Yarn - 3.0.0)
* Bootstrap - 5.2.1


## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
* Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/jswood23/CSCE431.git`


## Testing the Rails App ##

To run the unit/integration tests, run the following command:

```
rails test
```

An RSpec test suite is available and can be ran using:

  `rspec spec/`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd CSCE431`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`

  `cd csce431/CSCE431`
  
## Installing the app and Running the Server ##

This project is developed and deployed using docker.\
After cloning the repository, run the following commands:

```
bundle install
bundle exec rake webpacker:install
```

Run the app
  `rails server`
  
The application can be seen using a browser and navigating to http://localhost:3000/


## Running the Rails Console ##

To start the rails console, run the following command:

```
rails console -e development
```

## Environmental Variables/Files ##

Below are environmental variables used:

Authentication
* Google Client ID
* Google Client Secret

Mailer
* Google app password


## Deployment ##

** Create a pull request and when the pull request is merged, it will be automatically deployed to Heroku


## CI/CD ##

** CI is implemented with rspec tests, brakeman, and rubocop through GitHub Actions.

** CD is implemented so that all branches will be deployed to Heroku when new changes are made to the development branch.


## Support ##

Admins looking for support should first look at the application help page.
Users looking for help seek out assistance from the customer.


## Links ##
The production website can be found at: https://mchso.herokuapp.com/home

The staging website can be found at: https://stage-dev-app-1-info-organizer.herokuapp.com/
