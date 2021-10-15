Tags : #graphQL #rails 
Title: GraphQL 
Subject: Training and migration from REST to GRAPHL with a Rails API
Associations: [[2021-04-12-Weekly meetings]]
When: 2021-04-15 - 14:17 
#### Mentor 
Sunny 

## Notes
Encounter some difficulties to make my first queries and mutations type. 
To make a request in GraphiQL to create user using bcrypt gem to authenticate, here's my solution: 
```ruby
mutation {
	createUser(
	name: "Renaud",
	authProvider: {
		credentials: {
			email: "reno@test.com",
			password: "password"
		}
	}
	)	{
		id
		name
		email
	}
}
````

==BUG== 
When adding a `def all_users` method in `QueryType` it creates an error. 
```shell
TypeError: Cannot read property 'types' of undefined
    at buildClientSchema (http://localhost:3000/assets/graphiql/rails/application.debug-302d2d018661e60251eb98c333754c95eb06ce1ff919c0505ec40aafde0d2554.js:34100:72)
    at http://localhost:3000/assets/graphiql/rails/application.debug-302d2d018661e60251eb98c333754c95eb06ce1ff919c0505ec40aafde0d2554.js:2793:55
```

I can't use Graphiql anymore 
==FIX== 


## Types

## Mutations
> Mutations are a way for the client to talk to the server whenever it needs an operation that isn’t just about fetching data.

`Mutation_type.rb` is a the placeholder for all GraphQL mutations. 

==Create a new mutation file for a each new method ?==

## Schema
---
#### Resources: 
[GraphQL Ruby Doc Tuto](https://graphql-ruby.org/getting_started)
[GraphQL Doc schema](https://graphql-config.com/schema)
[Learning](https://graphql.org/learn/)
==[Training Tuto](https://www.howtographql.com/graphql-ruby/2-queries/)==
#### Articles
[Using GraphQL, a Ruby on Rails introduction](https://medium.com/@UnicornAgency/you-should-be-using-graphql-a-ruby-introduction-9b1de3b001dd)
[Converting a Rails REST API to GraphQL](https://medium.com/@mikkanthrope/converting-a-rails-rest-api-to-graphql-516078e72efa)
[Moving existing API from REST to GraphQL](https://medium.com/open-graphql/moving-existing-api-from-rest-to-graphql-205bab22c184)
[Rails and GraphQL](https://mattboldt.com/2019/01/07/rails-and-graphql/)
---
### *Doc Research*
[Insomnia](https://insomnia.rest/)
==[Graphiql](https://github.com/graphql/graphiql) Used by [Kiss Kiss Bank Bank](https://www.kisskissbankbank.com/graphiql)==
[Graphql- playground](https://github.com/graphql/graphql-playground)
[GraphiQL Voyager](https://github.com/APIs-guru/graphql-voyager)(https://apis.guru/graphql-voyager/)
[Swagger to GraphQL](https://github.com/yarax/swagger-to-graphql)
[GraphDoc](https://2fd.github.io/graphdoc/)
[Article about 10 awesomes tools](https://nordicapis.com/10-awesome-tools-and-extensions-for-graphql-apis/)

