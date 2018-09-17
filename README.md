# CoolPayApp
CoolPay Application

Application to interact with a payment api (CoolPay)

Also includes a console interface to get around the application without having to directly use the command line 
and try and understand how all the classes fit together

To run:
   - ./coolpay.rb (This will run the application with the Console UI [N.B. not complete])
   - rspec (To Run Tests)

# Explaination
Much of app revolves around the `User` Class. I felt that this was the best way to approach this task since that is the central
component.

I initially started by trying to create my own HTTP wrapper class using Ruby's internal web framework, however this turned out to be
a bit fruitless as I was essentially re-making what has already been tried and tested.

From there it was a question of hitting all of the key areas and ensuring that they were effectively tested.

There are two other smaller classes. Namely: `Recipient` and `Payment`. Essentially wrapper classes that help to organise
the objects rather than having JSON flying around. They have no methods and just return their attributes. If this was to be in a
rails application it would make sense to use these as models and store them seperately.

I chose to go with a ruby app over a rails app as the speed improvements of not needing to hit a database would ultimately scale
much better and allow for much faster transactions. However, during the course of its natural progression it would make sense to back
this with a database.

I've chosen to use Yard as a documentation tool for the User as this maintains readability while also explaining what each method does.

# Testing
All requests have been stubbed and tested using RSpec.

# Rubocop
I tried to keep to the rubocop standards and used the `-a` tag to quickly get my app up to speed with conventions
