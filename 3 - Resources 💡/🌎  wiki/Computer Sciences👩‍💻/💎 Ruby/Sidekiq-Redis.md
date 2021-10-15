Tags : #rails #sidekiq #redis
Title: Testing Sidekiq 
Subject: Useful command to manipulate Sidekiq
Associations: [[PR-749 - Sidekiq Test Workers]]
When: 2021-04-20 - 13:59

# Testing Sidekiq
There's a some useful command to know to test Sidekiq and to see if the jobs are performing. 

## First create a worker
In this example, we have to type of worker to test different behaviour of Sidekiq. 
```ruby 
class TestWorker
    include Sidekiq::Worker
    sidekiq_options :queue => :default, :retry => 5

	def perform(type)
   case type when 'easy'
       sleep 5
       puts 'this is easy job 5 sec wait'
   when 'medium'
       sleep 20
       puts 'this is medium job 20 sec wait'
   when 'hard'
       sleep 30
       puts 'this is hard job 30 sec wait'
   when 'error'
       sleep 15
       puts 'there is a error, wait for 15sec'
       raise 'raised error'
   end
 end

#    def perform
#        puts 'Hello World'
#    end
end
```
### Start the Redis server in the terminal
```bash
$ Redis-server
````
### Start Sidekiq
```bash
$ bundle exec Sidekiq
````
### Start Rails console 
```bash
$ rails c
````
## Useful command to test Sidekiq
### Launch a job in the console
```bash
$ TestWorker.perform_async('easy')
````
### Know the size of a queue
```bash
$ Sidekiq::Queue.new('default').size
=> 0
```

Let's push a 10 hard jobs in the queue. 
```bash
2.6.2 :061 > 10.times {TestWorker.perform_async('hard')}  
 => 10   
2.6.2 :062 > Sidekiq::Queue.new('default').size  
 => 5
```

We can schedule a job in Sidekiq: 
```bash
2.6.2 :063 > TestWorker.perform_at(10.minutes.from_now, 'easy')  
=> “67fed0bd2bf3a6d67b7f68e4”  
2.6.2 :064 > Sidekiq::Queue.new('default').size  
=> 0
````
### Where to fin Scheduled Jobs? 
```bash
2.6.2 :067 > ss = Sidekiq::ScheduledSet.new  
=> #<Sidekiq::ScheduledSet:0x00007f96549d5bd8 [@name](http://twitter.com/name)=”schedule”, [@\_size](http://twitter.com/_size)=1>  
2.6.2 :068 > ss.size  
=> 1

# to remove all jobs  
ss.clear
````
### Dead Jobs
```bash
2.6.2 :082 > ds = Sidekiq::DeadSet.new  
 => #<Sidekiq::DeadSet:0x00007f965435c0e0 @name="dead", @_size=1>   
2.6.2 :083 > ds.size  
 => 1
 
# to remove all jobs  
ds.clear
```
![[sidekiq.png]]
==### Important console commands you must know==
### Stats:
```bash
stats = Sidekiq::Stats.new  
stats.processed # => 100  
stats.failed # => 3  
stats.queues # => { "default" => 1001, "email" => 50 }
```
Get the number of kobs enqueued in all queues (does NOT include retries and scheduled jobs)
```bash
stats.enqueued # => 5
````
#### Stats History:
All dates are UTC and history stats are cleared after 5 years. 
Get a history of failed/processed stats: 
```bash 
s = Sidekiq::Stats::History.new(2) # Indicates how many days of data you want starting from today (UTC)  
s.failed # => { "2019-07-05" => 120, "2019-07-04" => 234 }  
s.processed # => { "2019-07-05" => 1010, "2019-07-04" => 1500 }
````
Start from a different date: 
```bash
s = Sidekiq::Stats::History.new( 3, Date.parse("2019-07-03") )  
s.failed # => { "2019-07-03" => 10, "2019-07-02" => 24, "2019-07-01" => 4 }  
s.processed # => { "2019-07-03" => 124, "2019-07-02" => 345, "2019-07-01" => 355 }
````
### Queues:
Get all queue
```bash 
Sidekiq::Queue.all
````

Get a queue
```bash
Sidekiq::Queue.new # the "default" queue  
Sidekiq::Queue.new("queue_name")
````

Gets the number of jobs within a queue
```bash
Sidekiq::Queue.new.size # => 4
````

Deletes all jobs in a Queue, by removing the queue
```bash
Sidekiq::Queue.new.clear
````

Delete jobs within the queue `default` with a `jid` of `'abcdef1234567890'` or worker name is ` 'TestWorker'`

```bash
queue = Sidekiq::Queue.new("default")  
queue.each do |job|  
job.klass # => 'TestWorker'  
job.args # => ['easy']  
job.delete if job.jid == 'abcdef1234567890' || job.klass == 'TestWorker'  
end
```

### Cron Job
in Rails Console
```bash 
$ Sidekiq::Cron::Job.all
```
![[Capture d’écran 2021-04-20 à 14.51.37.png]]

---
# Redis
To test if some jobs are still in REDIS
open the terminal tab with
```bash
$ redis-cli
$ KEYS '*cron*'
````

![[Capture d’écran 2021-04-20 à 13.48.36 1.png]]

---
# Other useful ressource
- [Testing Sidekiq](https://github.com/mperham/sidekiq/wiki/Testing)
- [Testing Sidekiq Worker with Rspec](https://smartlogic.io/blog/how-to-test-a-sidekiq-worker/)
- [another article about testing sidekiq](https://sloboda-studio.com/blog/testing-sidekiq-jobs/)
- To read more about option that sidekiq provides: 
[Sidekiq repo](https://github.com/mperham/sidekiq/wiki/Advanced-Options)
- To understand **rack and rack middleware** take a quick read: 
[Understanding Rack and Rack Middelware](https://shashwat-creator.medium.com/rack-and-rack-middleware-f93513ac92a6)
- ==[Redis](https://redis.io/topics/quickstart)==