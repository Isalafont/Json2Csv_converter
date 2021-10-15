# Backend MR Rules to Follow

1. include acceptance testing instructions 
==Template==
**acceptance test**

To test, reset your database with `bundle exec rails db:reset` then

visit the `api/space/1/needs` a needs should be display.

```
>> Affiliation.where(parent: Space.first, affiliate_type: 'Project').where.not(status: 'pending').pluck(:affiliate_id)
>> [1]
>> Affiliation.first.pending!
>> Affiliation.where(parent: Space.first, affiliate_type: 'Project').where.not(status: 'pending').pluck(:affiliate_id)
>> [0]
```

`http://localhost:3001/api/spaces/1/needs` should not display any needs.
2. code has updated yard docs  
3. code is structured according to our new format  
4. code passes all rubocop checks  
5. seed data is included whenever it will aid current testing or future development   
4. tests are present and complete whenever feasible

## Code Structure
### For Models 
```ruby
class Comment < ApplicationRecord  
  include RecsysHelpers  
  include RelationHelpers  
  include Utils
	
	belongs_to :post  
  belongs_to :user
	
	after_create :notif_new_comment 
	before_create :sanitize_content  
  before_update :sanitize_content
	
	validates :content, presence: true  
	
	notification_object  
  resourcify
	
	def public_method
	end
	
	private
	
	def private_method
	end
end
```

## Rspec
To test quickly after a ==git rebase== 
```shell
$ rspec spec/ --fail-fast
```

Once Git rebase passed always force to the push 
```shell
$ git push -f <remote> <name of the branch>
````

# Seedbank
```ruby
>> FactoryBot.build(:user).save  
>> Project.first.creator.add_role(:admin, Project.first)  
>> User.last.add_role(:admin, Challenge.first)  
>> Challenge.first.projects << Project.first  
>> ChallengesProject.first.pending!  
>> Notification.all  
>> ChallengesProject.first.accepted!  
>> Notification.last  
>> Challenge.first.projects.delete(Project.first)  
>> Notification.last
````

# Rubocop 
Run Rubocop
```shell

$ rubocop <name of the file>

```
- work on the file 
- run the test with  `rspec spec/ --fail-fast` 
- 
Once File is saved run 
```shell 
$ rubocop --fix-layout
````