Tags : #codeImprovement #complete  #rails 
Title : Refacto Test for invalid country exception
Date: 2021-04-15 - 11:00
Related to : [[2021-04-12-Weekly meetings]]
Gitlab Issue: [Issue 747 - Refacto Test of invalid Country exception](https://gitlab.com/JOGL/JOGL/-/issues/747)
PR:  
MR: [MR 271- ## User lambda to raise exception for invalid country](https://gitlab.com/JOGL/backend-v0.1/-/merge_requests/271)
Time Estimated: start: 11:00 - end 11:00

### Todo
Don't use the `to be_valid` matcher. When it fails it tells you nothing about the actual behavior under test.

A real problem is also that you're testing every single validation at once on your model so it really says a lot more about your factories/fixtures then your valiations.

Instead just setup the model with valid or invalid data (arrange) and call `#valid?` to trigger the validations (act) and then write expectations based on the [ActiveModel::Errors API](https://api.rubyonrails.org/v6.1.3/classes/ActiveModel/Errors.html) provided by rails (assert).

### Research
[Stackoverflow question](https://stackoverflow.com/questions/67094846/how-to-test-a-validation-with-conditional-in-a-model-rails/67096538#67096538)
[API Doc](https://api.rubyonrails.org/v6.1.3/classes/ActiveModel/Errors.html)
### Reviews
