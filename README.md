# qup - Queue Up

* <http://github.com/copiousfreetime/qup>

## DESCRIPTION

Qup is a generalized API for Message Queue and Publish/Subscribe messaging
patterns with the ability to plug in an appropriate messaging infrastructure
based upon your needs.

Qup ships with support for [Kestrel](https://github.com/robey/kestrel),
[Redis](http://redis.io), and a filesystem infrastructure based on
[Maildir](https://rubygems.org/gems/maildir). Additional Adapters will be
developed as needs arise. [Please submit an
Issue](https://github.com/copiousfreetime/qup/issues) to have a new Adapter
created. Pull requests gladly accepted.

## FEATURES

Qup provides an abstract implementation of two common messaging patterns.

### Basic Message Queue

Examples of a basic message queue are [Work/Task
Queues](http://www.rabbitmq.com/tutorials/tutorial-two-python.html), [JMS
Queue](http://docs.oracle.com/javaee/6/api/javax/jms/Queue.html), or [Amazon
SQS](http://aws.amazon.com/sqs/). This is a pattern where one or more Producers
puts Messages on a Queue and one or more Consumers received those Messages. Each
Message is delivered only 1 time to a Consumer.

### Publish/Subscribe

[Wikipedia Article on Pub/Sub
pattern](http://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern).

Qup implements a Topic based system, where Publishers send Messages on a Topic
and all Subscribers to that topic each receive their own copy of the message.

Qup assumes that the messaging systems it has adapters for provided durable and
acknowledgeable messaging.

### Durability

When message is sent to the messaging system by Qup, the message is persisted to
disk.

### Acknowledgeable Messages

When a Consumer receives a Message, and then processes it, Qup assumes that the
messaging infrastructure requires that the Message be positively acknowledged.
In other words, if the Consumer does not acknowledge the message then the
messages infrastructure will put the Message back onto the Queue.

## SYNOPSIS

### Basic Message Queue

    session  = Qup::Session.new( "maildir:///tmp/test-queue" )
    queue    = session.queue( 'basic-messaging' )
    producer = queue.producer

    consumer_1 = queue.consumer
    consumer_2 = queue.consumer

    producer.produce( 'message_1' )
    producer.produce( 'message_2' )

    message_1 = consumer_1.consume
    puts message_1.data                 # => 'message_1'
    consumer_1.acknowledge( message_1 )

    consumer_2.consume do |message_2|
      puts message_2.data               # => 'message_2'
    end  # auto acknowledged at the end of the block

### Publish/Subscribe

    session   = Qup::Session.new( "kestrel://messaging.example.com:22133" )
    topic     = session.topic( 'topic-messaging' )
    publisher = topic.publisher

    subscribers = []
    3.times do |n|
      subscribers << topic.subscriber( "subscriber-#{n}" )
    end

    publisher.publish( 'a fine message on a topic' )

    subscribers.each do |sub|
      sub.consume do |msg|
        puts msg.data                   # => 'a fine message on a topic'
      end                               # auto acknowledge an end of block
    end

## REQUIREMENTS

Depending on the backend messaging system you want to use, you'll need to
install additional gems. At the current moment, these are the supported
messaging backends.

* Qup::Adapter::Maildir - built in and uses the 'maildir' gem
* Qup::Adapter::Kestrel - uses the 'kjess' gem
* Qup::Adapter::Redis   - uses the 'redis' gem

## INSTALL

* gem install qup

## DEVELOPERS

After checking out the source, run:

    $ rake develop

This task will install any missing dependencies. You may then run:

    $ rake test

Other tasks are viewable with

    $ rake -T

### Kestrel

To run the Kestrel tests you will need:

* gem install kjess
* A Kestrel server running on <tt>localhost:22133</tt>

You can download Kestrel from <http://robey.github.com/kestrel/> and then run the
`scripts/devel.sh` command and you will have a default Kestrel server running on
`localhost:22133`. This will be enough to run the kestrel tests.

### Redis

To run the Redis tests you will need:

* `gem install redis`
* A Redis server running on `localhost:6479`

You can download redis using brew, macports or your favorite linux package
manager.

## LICENSE

(The ISC LICENSE)

Copyright (c) 2012,2013 Jeremy Hinegardner

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
