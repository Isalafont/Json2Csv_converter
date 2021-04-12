Tags : #Ruby #geoloc #TODO
Subject : GeoSearch mapbox implementation // Geocoder
Date : [[2021-04-09]]
Gitlab Issue: #687

## Directory where geocoder is places 
- [X] config/initializers/geocoder.rb
- [X] app/workers/geocoder_worker.rb
- [X] spec/workers/geocoder_coder_spec.rb
- [X] app/models/concerns/geocodable.rb
- Move away geocodable routes 
-> no routes 
- [X] Gemfile

- [X] Create a git meaningful first git message
----
#####  In User serializer Helper 

```ruby
geoloc : {
	lat: user.latitude,
	lng: user.longitude
	}
```

##### In Utilserializerhelper 

```ruby
def geoloc(obj = nil)
  obj = object if obj.nil?
  {
    lat: obj.latitude,
    lng: obj.longitude
  }
end
```

##### In user serializer 

```ruby
attribute :geoloc, unless: :scope?
```

##### In user serializer_with_private_fields

```ruby
attribute :geoloc, unless: :scope?
```

- [X] Users model and controllers 
- [X] Challenge model and controllers
