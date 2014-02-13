# AWS::InstMD

AWS::InstMD exposes the instance metadata information through a Ruby API.

**As-is:** This project is not actively maintained or supported.
While updates may still be made and we welcome feedback, keep in mind we may not respond to pull requests or issues quickly.

**Let us know!** If you fork this, or if you use it, or if it helps in anyway, we'd love to hear from you! opensource@airbnb.com

## Why?

169.254.169.254 does not offer a simple view of the whole instance metadata,
and querying the whole tree can be a bit quirky.

We wanted to solve that problem once and for all, expose it in a straightforward
and maintainable way.

## Installation

Add this line to your application's Gemfile:

    gem 'aws-instmd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aws-instmd

## Usage

### Command-line utility

`awsinstmd` will dump the metadata in JSON.

### Ruby API

The Ruby gem should be easy to use (feedback is obviously welcome).

Documentation should be improved; in the meantime, here is a simple example:

    require 'aws/instmd'
    puts AWS::InstMD.meta_data.instance_id
    puts AWS::InstMD.meta_data.instance_type

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
