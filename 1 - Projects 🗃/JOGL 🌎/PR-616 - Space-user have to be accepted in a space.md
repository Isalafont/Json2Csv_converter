Tags : #Space #affiliations #complete 
Title : User have to be acceted by admins of a Space to join a space.
Date: 2021-04-22 - 13:55
Related to : [[2021-04-22 - Weekly meetings]]
Gitlab Issue: [Issue - 616- Space/User have to be accepted in a space](https://gitlab.com/JOGL/JOGL/-/issues/616)
MR: [MR-273](https://gitlab.com/JOGL/backend-v0.1/-/merge_requests/273)
Priority : ==Current Sprint High==

Time Estimated: start: [[2021-04-22]] 13:55 - end {{ date }} -13:55

### Todo
User have to be accepted when joining a space.
pending request and admin should validate or not the join request.
Same logic that for Private project. 
==So duplication Logic of Status `is_private` in the space model => Add condition in method join in member.== 

**Step**
- [x] Implement logique to join the space
- [x] Write test in `space_api_spec.rb`
- [x] Write notifications
- [ ] Test notifications

### Done Friday evening
- [x] Add field in Space table `is_private` boolean set to True
- [x] Add in spec file `it behaves like a private object with members`

- [x] Test are failing 6 errors 
missing `creator` filed in Space table (2 failures)
- [x] Still got a problem with notifications who are not sent

### Research

### Reviews
