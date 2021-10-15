Tags : #TODO #jogl #maintenance #validations #complete 
Title : 
Date : [[2021-04-12-Weekly meetings]]
Gitlab Issue: [#721- More Valid_country_names logic from model User](https://gitlab.com/JOGL/JOGL/-/issues/721)
PR:  [MR 271 - user lambda to raise exception for invalid country](https://gitlab.com/JOGL/backend-v0.1/-/merge_requests/271)
Time Estimated: Started [[2021-04-13]] 11:00 - Ended [[2021-04-14]] 18:00

### Todo
Because it's causing validation error on password reset for example, when the user has a country that is not in the list (before we forced countries to be one from the list)
Currently here: `Jogl-Backend/app/model/user.rb`
![[Capture d’écran 2021-04-13 à 11.17.55.png]]

Here's the Error Message sent by a User 
![[image (1).png]]

==Update Note== 
Logic was newly implemented in the frontend so we don't need it anymore in the backen
- [x] comment logic validation
- [X] Forget the rspec test !! 
- [X] If tests pass, clean code

### Issue 🤯
Had some trouble to test in Localhost environement because of the reset password

Have to check Rspec test because it won't pass into the pipeline to test it in dev environment 

**==It seems that the best way is to add a Proc or a lamba to give a condition and overpass the issue !==**

```ruby
validates :country,
			allow_nil: true,
			inclusion: {
			in: VALID_COUNTRY_NAMES
			},
			unless: -> { reset_password_token.present? }
```
**Resolve it by this test :**
```ruby 
it 'allows existing user to reset password' do
	user = build(:user, country: 'invalid', reset_password_token: 'some_value')
	expect(user.reset_password_token).to eq('some_value')
	expect(user).to be_valid
end
```

### Research
[Active Records Validations Rails](https://guides.rubyonrails.org/active_record_validations.html)
- **Skipping Validations**
![[skipping_validations.png]]]

[Conflict between Frontend and backend validations](https://medium.com/@ehayne00/front-end-validations-or-back-end-validations-80f66d4e1545)

Testing this in User_spec.rb but didn't work but not a good lead ! 
```ruby 
it ".reset_password!" do
	user = build(:user, country: 'Wonderland', password: 'password')
	new_password = user.encrypted_password
	user.reset_password(password, new_password)
	expect(user.new_password).to be_valid
end

it 'allows existing user with invalid country to reset password' do
	user = build(:user, country: 'Wonderland')
	# check to ensure mailer sends reset password email
	expext(ActionMailer::Base.deliveries.count(1)) do
	post user_password_path, user: {email: user.email}
	assert_redirected_to new_user_session_path
end
# Get the email, and get the reset password token from it
message = ActionMailer::Base.deliveries[0].to_s
rpt_index = message.index("reset_password_token")+"reset_password_token".length+1
reset_password_token = message[rpt_index...message.index(""", rpt_index)]

# reload the user and ensure user.reset_password_token is present

# NOTE: user.reset_password_token and the token pulled from the email
# are DIFFERENT

@user.reload
assert_not_nil user.reset_password_token

# Ensure that a bad token won't reset the password

put "userspassword", user: {

reset_password_token: "bad reset token",
password: "new-password",
password_confirmation: "new-password",
}

assert_match "error", response.body
assert_equal @user.encrypted_password, old_password

# Valid password update

put "userspassword", user: {
reset_password_token: reset_password_token,
password: "new-password",
password_confirmation: "new-password",
}

# After password update, signed in and redirected to root path
assert_redirected_to root_path

# Reload user and ensure that the password is updated.
user.reload
assert_not_equal(user.encrypted_password, old_password)
end
```

### ==Good to Know==

**To confirm a user when you're creating on in JOGL console** 

```ruby
user = User.create!(email: "test@example.com", password: "password")
user.confirmed_at = Date.new
user.confirmed?
# => true
```

### Reviews
Interesting conversation with a Rubyist 

>Le problème avec une validation dans le modèle, c’est que la validation va s’effectuer dès que tu vas faire un save ou un update sur le user. A l’étape du reset de password, mais aussi à n’importe quel autre call api...  
Du coup la meilleure chose c’est d’éviter de mettre la validation sur le modèle, mais de mettre la validation dans un contract qui est appelé dans le point d’API utilisé pour mettre à jour le country, étant donné que c’est uniquement à ce moment là que tu updates ce champs.

	> -   Si tu veux laisser ta validation dans ton modèle, le mieux c’est de cleaner ta base (passer à nil tous les `country`  non valides)
	-   Si tu ne veux pas toucher aux valeurs de ta BDD, il faut que tu mettes ta validation ailleurs que dans le modèle. Tu vas valider l’inclusion du country dans une liste uniquement au moment où tu vas updater cette colonne country sur le user, pas à chaque fois que tu fais un save sur le user (pour l’update d’un autre champs).