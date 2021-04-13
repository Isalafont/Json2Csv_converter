Tags : #Ruby #complete #article
Title: Enumerator
Subject: How to create Enumerator in a Rails 6.1 project
Type: Article
Associations: [[PR 733 - Implement new space_type]]
Ressources Documentations : 
- [Creating Easy, Readable Attributes with Active Record Enums](https://www.justinweiss.com/articles/creating-easy-readable-attributes-with-activerecord-enums/)
- [Ruby on Rails- How to Create Perfect Enum Easely!](https://medium.com/@moulayjam/ruby-on-rails-how-to-create-perfect-enum-easily-d8678e52488e)
- [Ruby doc](https://api.rubyonrails.org/v6.1.3.1/classes/ActiveRecord/Enum.html)
When: [[2021-04-12]] [[2021-04-12-Weekly meetings]]

# Enumerator
## Introduction
It is very useful, by example, you can use them to define the tye of status of an object as `pending`, `delivering`, `delivered`. 
==In the frondend, it will be a string but in the backend, it is stored in the db as an interger==.

### In order to create Enum in Rails here's some advice : 
Normally, in the database enum is an integer, and when reading this attribute from an object of a model, It is converted to a string.

Example: 
- Your rails project has an **Order** model
- This **Order** model has an attribute **order_status**
- There are 3 orders status: **pending**, **delivering**, **delivered**

#### How to stores and create Enum in the database:
First run a migration : add ordder_status column (datatype: integer) in **orders** database table

```ruby
$ rails g migration AddOrderStatusToOrders order_status:integer

```

Migration file :
```ruby
class AddOrderStatusToOrders < ActiveRecord::Migration[6.1]
	def change
		add_column :orders, :order_status, :integer, default: 0
	end
end
```

💡==Note==
Always set the default value to 0 (zero)

Then Add Enum in Order model : 
```ruby
class Order < ActiveRecord::Base
	enum order_status: [:pending, :delivering, :delivered]
end
```

Let's create and order in console: 
```ruby
$ order_one = Order.new
$ print order_one.order_status
# => output pending
```

**order_status** value in the database is 0, but when we read the attribute, we'll get the string value `pending`. 
Enum allows to save some space in the database. 

#### Declare Enum as Hash: 
So Enum, in a database correspond to : 
```ruby
0 --> pending
1 --> delivering
2 --> delivered
```

==**Keep in Mind**== 

When an Array is used, the implicit mapping from the values to db integers is derived from the order the values appear in the array.
==Once a value is added to the enum array, its position in the array must be maintained==, and the new values should only be added to the end of the array.
==To remove unused values, the explicit hash syntax should be used.==
**So use an Hash instead of Array: **
```ruby
class Order < ActiveRecord::Base
	enum order_status: { pending: 0, delivering: 1, delivered: 2 }
end
```

#### Playing with Enums :

```ruby
# order.update! order_status: 0
order.delivering!
order.delivering? 	# => true
order.order_status 	# => "delivering"

order.order_status = nil
order.order_status.nil?		# => true
order.order_status.status	# => nil
```

Scopes based on the allowed values of the enum field will be provided as well. With the above example:
```ruby
Order.delivering
Order.not_delivering
Order.delivered
Order.not_delivered
```
You can query them directly if the scopes don't fir your needs: 
```ruby
Order.where(order_status: [:delivering, :delivered])
Order.where.not(order_status: :pendind)
```
You can disabled by setting `:_scopes` to `false`
```ruby
class Order < ActiveRecord::Base
	enum order_status: { pending: 0, delivering: 1, delivered: 2 }, _scopes: false
end
```
You can set the default enum value by setting : `_default` , like: 
```ruby
class Order < ActiveRecord::Base
	enum order_status: { pending: 0, delivering: 1, delivered: 2 }, _default: "pending"
end

order = Order.new
order.order_status # => "pending"
```

==**Tips**==
Get hash of enum values: ==use plural form of enum==
```ruby
order_one = Order.find(5)
order_one.order_statuses # => output { pending: 0, delivering: 1, delivered: 3 }
```

### ==Pro Tips with rails 6.1==
You can user the : `_prefix_` or `_suffix` options in Rails 6.1 to define multiple enums with same values. If the passed value is `true`, the methods are prefixed/suffixed with the name of the enum. Its also possible to supply a custom value: 

```ruby
class Conversation < ActiveRecord::Base
  enum status: [:active, :archived], _suffix: true
  enum comments_status: [:active, :inactive], _prefix: :comments
end
```
With the above example, the bang and predicate methods along with the associated scopes are now prefixed and/or suffixed accordingly:
```ruby

conversation.active_status!
conversation.archived_status? # => false

conversation.comments_inactive!
conversation.comments_active? # => false
```