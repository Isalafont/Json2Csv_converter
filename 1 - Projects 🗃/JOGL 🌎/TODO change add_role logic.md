`controllers/concerns/api/utils.rb`

```ruby

module Api::Utils

 extend ActiveSupport::Concern

 included do
 after_action :add_owner_admin_member_role, only: [:create]
 after_action :remove_creator_edge_relation, only: [:destroy]
 before_action :recsys_has_seen, only: [:show]
 # before_action :is_reviewer, only: [:review]
 end
 # Add roles to an object creator
	
 def add_owner_admin_member_role(current_user, obj)
  add_owner_role(current_user, obj)
  add_admin_role(current_user, obj)
  add_member_role(current_user, obj)
 end
	
 private
	
 # TODO Refacto the role attribution logic
 def add_owner_role(current_user, obj)
  unless current_user.nil? || @obj.nil?
   current_user.add_role :owner, @obj
   current_user.add_edge(@obj, 'is_owner_of')
  end
 end

 def add_admin_role(current_user, obj)
  unless current_user.nil? || @obj.nil?
   current_user.add_role :admin, @obj
   current_user.add_edge(@obj, 'is_admin_of')
  end
 end
	
 def add_member_role(current_user, obj)
	unless current_user.nil? || @obj.nil?
	 current_user.add_role :member, @obj
	 current_user.add_edge(@obj, 'is_member_of')
	end
 end
	
 def remove_creator_edge_relation
  unless current\_user.nil? || @obj.nil?
   current_user.remove_edge(@obj, 'is_author_of')
   current_user.remove_edge(@obj, 'is_member_of')
   current_user.remove_edge(@obj, 'is_admin_of')
   current_user.remove_edge(@obj, 'is_owner_of')
  end
 end

````

To make it works, I have the same methods into `controlles>concerns>api>members.rb`

`challenges_controller.rb`

create method 

```ruby
def create
	render(json: { data: 'Forbidden' }, status: :forbidden) && return unless can_access

	@challenge = Challenge.new(challenge_params)
	if @challenge.save
		current_user.add_edge(@challenge, 'is_author_of')
		update_skills_interests
		render json: @challenge, status: :created
	else
	render json: { data: 'Something went wrong' }, status: :unprocessable_entity
	end
end
```



`controlleds>concerns>api>members.rb``

```ruby 

def add_role_owner_admin_member(current_user, obj)
 add_owner_role(current_user, obj)
 add_admin_role(current_user, obj)
 add_member_role(current_user, obj)
end

def add_owner_role(current_user, obj)
 current_user.add_role :owner, obj
 current_user.add_edge(obj, 'is_owner_of')
end

def admin_role(current_user, obj)
 current_user.add_role :admin, obj
 current_user.add_edge(obj, 'is_admin_of')
end

def member_role(current_user, obj)
 current_user.add_role :member, obj
 current_user.add_edge(obj, 'is_member_of')
end

```