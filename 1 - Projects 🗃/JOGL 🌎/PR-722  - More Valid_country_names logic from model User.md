Tags : #TODO #jogl #maintenance #validations #inprogress 
Title : 
Date : [[2021-04-12-Weekly meetings]]
Gitlab Issue: [#722 - More Valid_country_names logic from model User](https://gitlab.com/JOGL/JOGL/-/issues/721)
PR:  
Time Estimated: Started 22021-04-13 11:00 

### Todo
Because it's causing validation error on password reset for example, when the user has a country that is not in the list (before we forced countries to be one from the list)
Currently here: `Jogl-Backend/app/model/user.rb`
![[Capture d’écran 2021-04-13 à 11.17.55.png]]

==Update Note== 
Logic was newly implemented in the frontend so we don't need it anymore in the backen
- [x] comment logic validation
- [] Test
- [] If tests pass, remove completely the logic by cleaning code

### Research
[Active Records Validations Rails](https://guides.rubyonrails.org/active_record_validations.html)
- **Skipping Validations**
![[skipping_validations.png]]]

### Reviews
