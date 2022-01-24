Tags : #seeds #rails 
Title :  Organising Seeds 
Date: 2022-01-12 - 15:15
Related to : [[2022-01-12 - Weekly meetings]] 
Gitlab / Github Issue: #
PR:  
MR: 
Time Estimated: start: {{date }} 15:15 - end {{ date }} -15:15

### Todo
Adding some seeds using Faker and Factory_bot
Trying to configure in Directories and in different files. 

Calling all the files 
### Research
Gem Seedbank
Gem pg_sync ? 
---
**One way to tidy up the seed files**
==💡To load Several seeds files from different directories== 

Give number File to load them and create them in the right order if needed. 
db/seeds/development/01_users.rb
db/seeds/development/02_lists.rb

`app/db/seeds`
```ruby
Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
	load seed
end
```

---
**Using Seedbank gem**

[Seedbank Gem Doc](https://github.com/james2m/seedbank)

This would generate the following Rake tasks

```
rake db:seed                    # Load the seed data from db/seeds.rb, db/seeds/*.seeds.rb and db/seeds/ENVIRONMENT/*.seeds.rb. ENVIRONMENT is the current environment in Rails.env.
rake db:seed:bar                # Load the seed data from db/seeds/bar.seeds.rb
rake db:seed:common             # Load the seed data from db/seeds.rb and db/seeds/*.seeds.rb.
rake db:seed:development        # Load the seed data from db/seeds.rb, db/seeds/*.seeds.rb and db/seeds/development/*.seeds.rb.
rake db:seed:development:users  # Load the seed data from db/seeds/development/users.seeds.rb
rake db:seed:original           # Load the seed data from db/seeds.rb
```

Therefore, assuming `RAILS_ENV` is not set or it is "development":

```
$ rake db:seed
```

will load the seeds in `db/seeds.rb`, `db/seeds/bar.seeds.rb`, `db/seeds/foo.seeds.rb` and `db/seeds/development/users.seeds.rb`. Whereas, setting the `RAILS_ENV` variable, like so:

```
$ RAILS_ENV=production rake db:seed
```

will load the seeds in `db/seeds.rb`, `db/seeds/bar.seeds.rb` and `db/seeds/foo.seeds.rb`.

### Reviews
