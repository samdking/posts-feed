# README

This is a tiny proof-of-concept Rails app for displaying a JSON feed of posts. Each anonymous user can like a post, and receive likes other users contribute in real time.

## How to install

In this example, and for the sake of brevity, these instructions will be for a Mac operating system only.

This app was built using Ruby 2.7.6. My recommendation for managing Ruby versions is to use [RVM](https://rvm.io/). To install Ruby 2.7.6 on your machine, run the command:

```
$ rvm install 2.7.6
```

To install the app's dependencies, first ensure you have Bundler installed. Bundler manages an app's gems.

```
$ gem install bundler
```

Once Bundler has been installed, you can install all the app's gems using the command:

```
$ bundle install
```

Next, create the database. This app uses SQLite version 3, which comes packaged with Mac OS and provides a lightweight and convenient database for local development. To create the database and run the database migrations, run:

```
$ rails db:create
$ rails db:migrate
```

## Booting the app

To boot the app, run the following command to start the Rails server and package up the CSS:

```
$ bin/dev
```

## Running the test suite

To run the test suite, run the following command:

```
$ rails test
```

## Gem usage explanation

### Slim

Slim makes for terse views, where the equivilant HTML can cumbersome to write and heavy to consume.

### Tailwind

Tailwind is a brilliant utility-first CSS framework, designed to aid rapid developmemnt. It provides constraints, but in a logical way, rather than creatively restrictive.

### Httparty

Just a really nice utility for making robust HTTP requests.

### FactoryBot

A useful tool for creating objects in tests, for more readable and minimal testcases.

### Mocha

A nicer syntax for Minitest for creating stubs and mocks in tests.
