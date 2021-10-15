# To connect to the database and schema from the console 

```shell
> psql -h localhost -d jogl_development -U jogl
```

To see the schema databe 
```shell
> jogl_development=# \dt
```

*Request query*
```ruby
needs = Need.where(project_id: Affiliation.where(parent: @space, affiliate_type: "Project").where.not(status: 'pending').select(:affiliate_id))
```

Try : 
```ruby
Need.joins('inner join affiliations on affiliations.affiliate_id = needs.id').where(affiliations: {parent: @space, type: 'Need'})
```