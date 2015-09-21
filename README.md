# SidekiqRejector

[ ![Codeship Status for tzachi_fraiman/sidekiq_rejector](https://codeship.com/projects/27641140-90ca-0131-c50a-063de6e749ae/status?branch=master)](https://codeship.com/projects/16331)

[![Code Climate](https://codeclimate.com/github/TzachiF/sidekiq_rejector/badges/gpa.svg)](https://codeclimate.com/github/TzachiF/sidekiq_rejector)

[![Test Coverage](https://codeclimate.com/github/TzachiF/sidekiq_rejector/badges/coverage.svg)](https://codeclimate.com/github/TzachiF/sidekiq_rejector/coverage)

The simple way for rejecting jobs when code introduced with unwanted behavior(bug) and there is a must to stop handling this type of jobs until
a fix is issued. 

## Requirements

Only sidekiq 3 is supported.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-rejector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-rejector

## Usage

All that you need in case you want to exclude jobs is to configure two environment variables  

SidekiqRejectorEnabled = true  

SidekiqRejectorValues = 'comma separated string' with values of the method to stop (when called using delay) OR the worker name.  
 
There is also a utility class that will remove jobs directly from Redis. This is for a situation were a huge amount of jobs already queued and they may clog the background workers.

Inputs: queue_name - The target queue that you want to clear  
        string_identifier - The method name OR worker name, using this identifier the jobs are found.    
       
```ruby
SidekiqRejector::JobRemover.remove(queue_name, string_identifier)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contributors
- https://github.com/tzachif
