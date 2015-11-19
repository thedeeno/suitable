Suitor-Dane
===========

An example application which SMS's a shortened link to the top post from a
given subreddit to a given number.

## Live Demo

http://limitless-meadow-5871.herokuapp.com/

## Architecture

The projected is segmented into 5 areas of concern

- acceptance
- app/backened
- app/frontend
- core
- cli

Each area has it's own unit tests. This segmentation makes it easier understand and stub the boundaries of each component so we're not constantly hitting external APIs or concerning ourselves with complex setup.

## Acceptance

This sub-project contains all end-to-end integration tests for suitor. It verifies both the browser app and cli. A few convenience scripts are provided to self document how to run these tests.

    # run these scripts to exercise the major interfaces
    ./script/verify_app
    ./script/verify_cli
    ./script/verify_all

## App

To boot the backend/frontend development environment run `(cd ./app && foreman start)`

### Backend

The ruby application responsible for serving the browser app and API. It's a simple sinatra application with 2 routes `GET /` and `POST /charm`. The `/charm` route handles `HTML` and `XHR` requests so the app can respond to both javascript and non-javascrip clients. It delegates to the `core` for message composition and dispatch but maintains logic for giving feedback when errors occur.

It also houses the `unicorn` config for use in production.

The server expects the following environment variables to be configured
and will complain on boot if they're missing:

  - `TWILIO_SID`
  - `TWILIO_TOKEN`
  - `FROM_PHONE`
  - `REDDIT_KIT_USER`
  - `REDDIT_KIT_PASS`

It will attempt to source variables defined in a `.env` file if
present.

#### Commands

    ./script/test_backend       # run rspec specs
    (cd ./app && foreman start) # start development environment
    (cd ./app/backend && bundle exec rackup config.ru -p 4567) # rackup

### Frontend

This is a grunt/bower based project that's responsible for compiling and testing frontend assets. It leverages a series of grunt tasks (configured in `./grunt`) to autocompile, distribute, and live-reload assets during active development. The output of this pipeline get's dumped into `./dist` which is symlinked to the backend's `public` directory for easy static serving.

Dependencies like `foundation`, `underscore`, `backbone` are managed via bower and auto-concatenated into assets with `vendor`prefixes. 

It uses karma for testing (though there aren't really tests yet).

#### Commands

    ./script/test_frontend             # run karma unit tests
    ./script/build                     # manually build assets
    (cd ./app/frontend && grunt watch) # auto recompile and live-reload assets

# Core

A gem that contains the core logic for suitor that's shared by both the CLI and Browser App. The most notable features are the service wrappers. Here we wrap each external service with a class to establish a clean boundary between the suitor core and its external dependencies. This makes unit testing and service swapping easier. For the most part, external services are mocked during unit tests of the core.

This library establishes a simple interface for higher-level projects to stub during unit testing. Because of this, the higher level projects don't know anything about the clients used for Reddit, Twilio, or Googl.

#### Commands

    ./script/test_core

# CLI

A gem for running suitor form the command line. 

Its usage is as follows:

    Usage:
        suitor [OPTIONS] PHONE_NUMBER

    Parameters:
        PHONE_NUMBER                  the phone number to charm

    Options:
        -s, --subreddit [SUBREDDIT]   The subreddit to use for source material
        -h, --help                    print help


It expects following environment variables to be configured and will complain otherwise:

  - `TWILIO_SID`
  - `TWILIO_TOKEN`
  - `FROM_PHONE`
  - `REDDIT_KIT_USER`
  - `REDDIT_KIT_PASS`
  
It will attempt to source variables defined in `.env` before checking.

#### Commands

    # run the cli
    (cd ./cli && bundle exec ./bin/suitor [PHONE])
    
    ./script/test_cli   # run unit tests
    ./script/verify_cli # run acceptance tests

# Continuous Integration

The following command will run all unit and acceptance tests and exit with 0 or 1 on PASS or FAIL respectively.

    ./script/ci

# Hacking

1. Clone the repository
2. Install dependencies with `./script/install_dependencies`. 
3. Setup a `.env` using the `.env.example` as guidance
4. Boot up the browser app development environment with the `app/Procfile`.
5. Verify everything is passing with `./script/verify_all`
