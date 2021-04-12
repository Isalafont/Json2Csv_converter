Tags : #Ruby 
Title: Enumerator
Subject: 
Associations: 
When: [[2021-04-10]]

In order to create Enum in Rails here's some advice : 

An enumerator is an interger in the db
It will be called as a string in the frontend part like 'active' , 'draft'

Migration file :
```ruby
def change
	add_column :orders, :order_status, :integer, default: 0
end