Tags : #doing #space #jogl #notifications #callback #rails #active-record
Title : Implement Notifications for Spaces
Date: 2021-04-20 - 15:41
Related to : [[2021-04-20 - Weekly meetings]]
Gitlab Issue: [Issue 781 - Send Notification when project get affiliated to a space](https://gitlab.com/JOGL/JOGL/-/issues/781)
PR: [PR-272 pending join request to an affiliate object](https://gitlab.com/JOGL/backend-v0.1/-/merge_requests/272)
MR: 
Time Estimated: start: [[2021-04-20]] 15:41 - end {{ date }} -15:41

**==Interogation==**
As we do not have an `has_many` relation between Projects and Spaces table, how to be sure to notify the rights admins ? 

-  Find a way to test in localhost in a proper way ? 
- Passed my user 5907 with a role of :space_creator and go to the page `space/create`
- Write some Test in `affiliations_api_spec.rb` => Tests failed for now, need to fix it
- 

### Todo
![[Capture d’écran 2021-04-20 à 15.46.43.png]]
A project can only join a Space when the affiliations get a status : accepted
- [x] Make a method to create notification if the status is accepted
- [x] Create method to fill the conditions about sending notification to joins space is member's project is not a member of the affiliated spaces  OR notify members already affiliated to the same space that a project join a Space
- [ ] `Notification_handler` dans config/initializers => must define a group for :admins_affiliate_parent (space) member for affiliation(space) 
and another group for :admins_affiliated (project) / members
- [ ] Write test in `affiliations_api_spec.rb`
- [ ] 
---
==Tips==
- To create a space =>  Add to user a role of ``space_creator``
```ruby
$ user.add_role(:space_creator)
$ user.has_role?(:space_creator)
# => true
```
then go to page : 
``localhost:3000/space/create``



### Research
[Run a callback only if an attribute has changed in rails](https://stackoverflow.com/questions/24314584/run-a-callback-only-if-an-attribute-has-changed-in-rails)
[API doc Rails- callback](https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html)

Observer classes respond to life cycle callbacks to implement trigger-like behaviour outside the original class.
[Active Record Observer](https://api.rubyonrails.org/v3.2.0/classes/ActiveRecord/Observer.html) ==(Officially removed from Rails 4.0)==

Increase performance Query N+1 with gem [bullet](https://github.com/flyerhzm/bullet)
research [medium article](https://medium.com/doctolib/understanding-and-fixing-n-1-query-30623109fe89#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc3MjA5MTA0Y2NkODkwYTVhZWRkNjczM2UwMjUyZjU0ZTg4MmYxM2MiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2MjAyMjQ0MTgsImF1ZCI6IjIxNjI5NjAzNTgzNC1rMWs2cWUwNjBzMnRwMmEyamFtNGxqZGNtczAwc3R0Zy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjExMTQ2NzAyMzIwNzM5NTM3MDI4MyIsImVtYWlsIjoiaXNhbGFmb250QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhenAiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJuYW1lIjoiSXNhYmVsbGUgTGFmb250IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdpLUtBMlB4RkwydUZzRUk2aFRpSGkzelN0eWU2YkVmdGc4eXNaNVRBPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IklzYWJlbGxlIiwiZmFtaWx5X25hbWUiOiJMYWZvbnQiLCJpYXQiOjE2MjAyMjQ3MTgsImV4cCI6MTYyMDIyODMxOCwianRpIjoiODE0NTA4ODllMWUxZjcwZjJmOTkyMmZhYzdlM2NjYjNmMDhiNzgwNSJ9.vb2UMMp_NppHPa_3JbGtDbmhv-qcQJ60mwJtbG_2f8LQgu_NObjmjfHPpeXCWFTaR4SHh5i3tMtaVZ7o2kwDhkn8voWQ-8UD8viw80jvTBFSKD96YnLQWlnRJF_QDWzxWA963G0aiaDb7k1pGK9G8DUTHOchhFmLHSIv7kglFn0oX4lnI_Iulx9CHKE4sWgqskfPr3Hk_Vm7tTBE2cfKzSrryjlGU4grUiIGxyfqz7Yx-wDgt_OPoxI9aV3fzD1-E0i1Eb3BETAC8V36ajAq3DfLH-jS4xQxYLjA80ORVF-AyVJX59er2geMg0OoiSioR9JSf5Y8c1fO-CpIdtykFw)


### Reviews

If we're user `.delete` to destroy an affiliation
the `before_destroy`  callback won't be called. 

```ruby
def remove_affiliation_to(parent)
 ::Affiliation.destroy_by(parent: parent, affiliate: self)
end
````
