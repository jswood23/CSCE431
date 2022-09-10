# README

The MCHSO Info Organizer is a website containing both external pages for all internet traffic and internal pages for tracking membership.

## Running The Server

This project is developed and deployed using docker.\
After cloning the repository, run the following commands:

```
bundle install
bundle exec rake webpacker:install
rails server
```

## Running the Rails Console

To start the rails console, run the following command:

```
rails console -e development
```

## Testing the Rails App

To run the unit/integration tests, run the following command:

```
rails test
```
