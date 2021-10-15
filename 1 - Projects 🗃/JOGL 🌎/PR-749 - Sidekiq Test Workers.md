Tags : #sidekiq #rails #bug #Ruby #Recsys #Cronjob

Title : Testing Sidekiq 
Date: 2021-04-15 - 10:31
Related to : [[2021-04-12-Weekly meetings]][[Sidekiq-Redis]]
Gitlab Issue: [749 - 🐛 Fix Sidekiq Scheduled Cron Job](https://gitlab.com/JOGL/JOGL/-/issues/749)
PR:  
MR: 
Time Estimated: start: [[2021-04-15]] 10:31 - end 10:31
[[2021-04-19]] 13:20- end 

### Todo
Sidekiq is not processing cron job anymore. Had to fix that bug or at least to find why ?
- [X] create a fake worker with a fake job to perform
- [X] Run command in terminal to test Sidekiq

```ruby
class TestWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :default, :retry => 5

# def perform(type)
# 	case type when 'easy'
# 		sleep 5
# 		puts 'this is easy job 5 sec wait'
# 	when 'medium'
# 		sleep 20
# 		puts 'this is medium job 20 sec wait'
# 	when 'hard'
# 		sleep 30
# 		puts 'this is hard job 30 sec wait'
# 	when 'error'
# 		sleep 15
# 		puts 'there is a error, wait for 15sec'
# 		raise 'raised error'
# 	end
# end

	def perform
		puts 'Hello World'
	end
end
```
#### Start Redis in the console
```bash
$ Redis-server
```
#### Start Sidekiq
```bash
$ bundle exec Sidekiq
```
#### Start the rails console
```bash
$ rails c
```

### Useful command to test Sidekiq
#### Launch a job
```bash
$ rails c
$ TestWorker.perform_async()
```

#### To now the Size of a queue



### Research
[All you need to know about Sidekiq](https://shashwat-creator.medium.com/all-you-need-to-know-about-sidekiq-a4b770a71f8f)

**[Rails cron job not keep working](https://stackoverflow.com/questions/48333488/rails-old-cron-job-keeps-running-cant-delete-it) To monitor Cron job in the Redis Server**
```bash
$ redis-cli
$ KEYS '*cron*' 	
```
![[Capture d’écran 2021-04-20 à 13.48.36.png]]

**Cron Job Monitor** 
Tools: [cronitor](https://cronitor.io/cron-job-monitoring?utm_source=crontabguru&utm_campaign=cron_failures)

### Reviews
