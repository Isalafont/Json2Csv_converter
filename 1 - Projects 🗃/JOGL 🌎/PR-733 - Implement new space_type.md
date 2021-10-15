Tags : #space #jogl #complete 
Title :  Implement New Space_type in Space model
Date : [[2021-04-12-Weekly meetings]]
Gitlab Issue: [#733 - Implement new field on spaces: space_type](https://gitlab.com/JOGL/JOGL/-/issues/733)
MR:  [#268 - add space_type as a enum in Space table](https://gitlab.com/JOGL/backend-v0.1/-/merge_requests/268) 
==Approuved and Merged==
Time Estimated: 2H

### Todo
- ==Add a new column in Space Table==
```ruby
$ rails generate migration AddSpaceTypeToSpaces space_type:integer
```
- Run the migration
```ruby
$ rails db:migrate
```
- Add validates fields with the following strings : 
	-   Digital Community
	-   Local Community
	-   NGO
	-   Not for profit organisation
	-   Startup
	-   Makerspace
	-   Community Lab
	-   Company
	-   Social Enterprise
	-   School
	-   Foundation
	-   Academic Lab
	-   Professional Network
	-   Public agency
	-   Public institution
	-   Incubator
	-   Living Lab
	-   Fund

Add enums to space_params and to space_serializer as attribute

### Research
==An Enum is an interger in the db. Forget about it, then I had to make a revert migration to change the string to integer.==

### Reviews

PR is waiting for reviewing
