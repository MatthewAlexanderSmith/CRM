# Customer Relationship Manager (CRM) Assignment

The assignment is to implement a Customer Relationship Management (CRM) application.

Please use the below as a guide and not as an exact "how-to" to implement your solution. Use common sense and judgement where appropriate.

Be sure to read over the entire assignment first to get a general feeling and overview of what you have to do, before digging into each part.

## User Stories

Software developers use User Stories as a guide to know what to implement. They serve as a list of things that the customer thinks should be in an application. Below we have written out all of the user stories for the CRM. Use these as a to-do list or guide when implementing your solution.

#### Implement the Contact Class

* As a developer, the contact class should have five attributes: `id`, `first_name`, `last_name`, `email` and `note`.
* As a developer, when a user creates a contact, all attributes can be provided except for `id`.
* As a developer, when a user creates a new contact, the `id` will be set automatically by your class.
* As a developer, I am able to modify all attributes except for `id` at any point in the program at a later time.
* As a developer, the Contact class should maintain a collection of all of the contacts created.
* As a developer, the Contact class should have a method that returns all of the contacts.

#### Implement the CRM

* As a user, I am presented with a prompt to **add**, **modify**, **delete**, **display all**, **search by attribute**,  and **exit**.
* As a user, if **add** is selected, I am prompted to give my 'first name', 'last name', 'email' and 'note'.
* As a user, if **modify** is selected, I am prompted to enter an id for the contact to be modified.
* As a user, when an id is entered, I am prompted to type `yes` or `no` to confirm my selection.
* As a user, if `yes` is typed, I am prompted to change 'first name', 'last name', 'email' or 'note' by number. You shouldn't be able to change the 'id'.
* As a user, when an attribute is entered, I am prompted to enter a new value for the attribute.
* As a user, if `no` is entered, I am returned back to the main menu.
* As a user, if **delete** is selected, I am prompted to enter the 'id' of the contact to be deleted.
* As a user, if **display all** is selected, I am shown all of the contacts that exist with their 'id's.
* As a user, if **search by attribute** is selected, I am prompted to select an attribute by number, and enter a *value* for that attribute so that I can see all of the matching contacts.
* As a user, if **exit** is selected, I am exited out of the program and returned to the command line.

Below is a guide on how to get started, how to implement the first few user stories, and some examples of how to work with classes, objects, instance variables and other things you will need to be successful.

## Creating a Contact class

First, let's get to the crux of this app: How are we going to store all of the information of the contacts?

We could store it into an array, or even better a hash. Something like this:

```ruby
contacts = [
  {
    first_name: 'F. Ross',
    last_name: 'Johnson',
    email: 'rossjohnson@hotmail.com',
    note: 'Such a cool dude.'
  },
  {
    first_name: 'Adrian',
    last_name: 'Carton de Wiart',
    email: 'adrianwiart@gmail.com',
    note: 'Even cooler.'
  }
]
```

We can do better though. We could make a class called `Contact`.

What are classes and why do we use them? It's similar to the reason why we use methods – they let us organize our lines of code, otherwise our code would become a mess.

Imagine if we had dozens of methods floating around with no structure – classes let us organize these methods into categories.

Open up the provided `contact.rb` file. You'll see that it's got a bunch of empty methods waiting for you to implement them.

Go ahead and implement the `initialize` method in the `Contact` class:

*Note: Vertical dots indicate omitted code for brevity's sake.*

```ruby
class Contact
  .
  .
  .
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
  .
  .
  .
end
```

Now whenever we want to make a new contact, we could do something like this:

```ruby
contact = Contact.new('Adrian', 'Carton de Wiart', 'adianwiart@gmail.com', 'Even cooler.')
```

### Using Getters and Setters

What if after we've created a new contact, we want to find out what its email is, for example, or even modify it?

```ruby
contact = Contact.new(
  'Adrian',
  'Carton de Wiart',
  'adianwiart@gmail.com',
  'Even cooler.'
)
# How can I get contact's email?
# Then how can I change contact's note to 'Buy him a present.'?
```

What we are in need of are getters and setters inside of the `Contact` class. In this scenario we need to be able to get the email and set the note of a contact.

```ruby
class Contact
  .
  .
  .
  # a getter (*get* the value of an attribute)
  def email
    @email
  end

  # a setter (*set* the value of an attribute)
  def note=(note)
    @note = note
  end
  .
  .
  .
end

contact.email # => 'adianwiart@gmail.com'
contact.note = 'Buy him a present.'
```

We can easily add these kinds of methods in to our class by leveraging `attr_accessor`, `attr_reader`, or `attr_writer`.

These are special Ruby methods that will automatically create getters and setters for you.

* `attr_accessor` will give you both getters and setters, 
* `attr_reader` gives you just getters, and
* `attr_writer` gives you just setters. 

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note
  .
  .
  .
end
```

After you add `attr_reader` and `attr_accessor`, be sure to remove the `email` and `note=` methods if you actually implemented them in your class. As mentioned before, the getters and setters will be automatically created for you.
 
### Storing all new Contacts in a list

We need to store our newly created `Contact` objects somewhere. Since it will be a list of contacts, the best object type to use would be an `Array`, since it represents an ordered list of objects. We'll give the responsibility of keeping track of the list of contacts to **the `Contact` class itself** rather than to any individual contact. To do this, we'll use a **class variable**.

### Class variables

A class variable is a variable that's declared at the class level and shared across all objects of the same type. In our case, we'll setup a class variable to store the array of all the contacts we create. We'll also create a class variable to ensure that our contacts each have a unique identifier.

```ruby
class Contact
  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@id = 1
  .
  .
  .
end
```

These variables will be available to all `Contact` object instances.

### Add a method to create new Contacts

We have two similar but distinct pieces of functionality to provide. The first is to instantiate a new contact instance and the second is to create a new contact and save it in the list. We want to keep our methods focused and simple so we'll separate the functionality of instantiating an object from the functionality of adding it to our list with a new **class method**.

### Class methods

So far, all of the methods we've created were **instance methods**. Instance methods can only be called on a specific instance of an object, not the class itself (hence the name!). 

Class methods are called directly on the class name and are usually reserved for actions that operate on the whole set of objects of that type. Instantiating a new contact and storing it in the list of all contacts affects the collection of all contacts so it's a good use case for a class method. You define a class method by prefixing the name of the method with `self`.

Go ahead and implement the `self.create` method as follows:

```ruby
def self.create(first_name, last_name, email, note)
  new_contact = Contact.new(first_name, last_name, email, note)
  @@contacts << new_contact
  new_contact
end
```

Our Contact class has an initialize method that asks us to set the attributes for a contact instance. We now also need it to ensure that each contact has a unique identifier. We'll have to set this directly on the instance variable in the initialize method since we don't have access to set the id from outside the object (we used `attr_reader` for id, rather than `attr_accessor`).

```ruby
def initialize(first_name, last_name, email, note)
  .
  .
  .
  @id = @@id
  @@id += 1
end
```

### Other Methods

The implementation of the following methods are left up to you:

* `self.all`
* `self.get`
* `self.search_by_attribute`
* `self.delete_all`
* `full_name`
* `update`
* `delete`

### Testing the Contact Class

To help you implement the `Contact` class, we have written a set of simple tests that you can run against your code.

In the command line, execute the following:

```bash
ruby test/contact_test.rb 
```

This will run all the tests against your `Contact` class. At this point they will all fail spectacularly, but as you implement each of the missing methods, they should start to pass, one by one.

## Creating a CRM Class

Open up the provided `crm.rb` file, and again you'll see that it has a bunch of empty methods waiting for you to implement them.

### Creating the Menu

If you look at our user stories, you'll see we need to be able to prompt the user to select from a main menu. The code for that might look something like this:

```ruby
def main_menu
  while true
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end
end

def print_main_menu
  puts '[1] Add a new contact'
  puts '[2] Modify an existing contact'
  puts '[3] Delete a contact'
  puts '[4] Display all the contacts'
  puts '[5] Search by attribute'
  puts '[6] Exit'
  puts 'Enter a number: '
end
```

We have two methods, `print_main_menu` prints out the menu. `main_menu` calls `print_main_menu` and then stores the user input (a number) into a variable called `user_selected`. That variable then gets passed into a method we haven't defined yet called `call_option`.

What do you think `call_option` should do? Remember, `user_selected` is going to be a number. What we want to do in this method is call other methods based on the number. We've started off this method for you:

```ruby
def call_option(user_selected)
  case user_selected
  when 1 then add_new_contact
  when 2 then modify_existing_contact
  # Finish off the rest for 3 through 6
  # To be clear, the methods add_new_contact and modify_existing_contact
  # haven't been implemented yet
  end
end
```

*Question:* What should happen when option 6 is selected? Hint: Google 'How to exit a Ruby program'. 

### Menu Actions

You will need to implement several methods for the menu to call. 

  * `add_new_contact`
  * `modify_existing_contact`
  * `delete_contact`
  * `display_all_contacts`
  * `search_by_attribute`

The `add_new_contact` method might looks something like this:

```ruby
def add_new_contact
  print 'Enter First Name: '
  first_name = gets.chomp

  print 'Enter Last Name: '
  last_name = gets.chomp

  print 'Enter Email Address: '
  email = gets.chomp

  print 'Enter a Note: '
  note = gets.chomp

  Contact.create(first_name, last_name, email, note)
end
```

### Other Methods

Implementation of the following methods are you to you.

* `modify_existing_contact`
* `delete_contact`
* `display_all_contacts`
* `search_by_attribute`

You may find it helpful to implement an extra `display_contacts` method as well, as it can be used in other methods. 

### Requiring Files

Note that the `CRM` class needs to makes use of the `Contact` class, for example in the `add_new_contact` method. Many of the other methods in the `CRM` class will also make use of the `Contact` class.

Classes work together to make the entire program functional. We let classes use other classes by *importing* a file. The way this is done is using a method called `require_relative`, and basically what it does is get that file and stick it right in that line where the `require_relative` method was called.

Open up **`crm.rb`** and insert the following `require_relative` statement:

```ruby
require_relative 'contact'

class CRM
  .
  .
  .
end
```

Now, the `CRM` class will be able to make use of the `Contact` class.

### Using the CRM class

Now how do we call methods that are inside of classes? Like this:

```ruby
a_crm_app = CRM.new
a_crm_app.main_menu
```

If we wanted to call `print_main_menu` instead, that would look like:

```ruby
a_crm_app.print_main_menu
```

When we do:

```ruby
a_crm_app = CRM.new
```

We're creating a *new instance* of the class CRM, and we're saving that new instance into a variable called `a_crm_app`. This is just like having a blueprint of a House, and every time you build a house off the blueprint you will end up creating a new instance of a House.

Then we can call the methods inside of the class on the instance. `main_menu` and `print_main_menu` are methods inside of the class CRM, and we can call them on `a_crm_app`, which is an instance of the class. For example, `a_crm_app.main_menu`.

Now it shouldn't be too hard to figure out why these kinds of methods called **instance methods**: they are methods we call on instances.

### Passing in Arguments when Initializing

When we want to create a new instance of a class, we call a method named `new` (as in `CRM.new`). In some cases we want it so that arguments have to be passed in, for example the new instance you make has to be given a name. In other words, you want to see something like this: `CRM.new("My CRM App")`.

For this to be done we need to manipulate a method named `initialize` in the class.

```ruby
class CRM
  .
  .
  .
  def initialize(name)
    puts "Okay, this CRM has the name " + name
  end
  .
  .
  .
end
```

`initialize` and `new` are synonymous, so when you call `new`, you're calling `initialize`.

### Instance Variables versus Local Variables

This bridges us over into another great point for OOP: instance variables.

```ruby
class CRM
  .
  .
  .
  def initialize(name_being_passed_in)
    name = name_being_passed_in
  end

  # Can I access name here, outside of the method?
  # No, and this is because the variable only has a local scope.
  
  .
  .
  .
end
```

How could we make it so that the variable `name` would be available outside of the `initialize` method? We could make it an instance variable, and the way we do this is by prepending the symbol `@` in front of the name. Like this:

```ruby
class CRM
  .
  .
  .
  
  def initialize(name_being_passed_in)
    @name = name_being_passed_in
  end

  # Now I can access name here, outside of the method.
  # It's a Ruby thing, if a variable starts with the symbol @,
  # I can access it outside of the method it was defined in.
  
  .
  .
  .
end
```

And why would we want to do this?

Why of course, to do something like this, just like in the `Contact` class:

```ruby
class CRM

  def initialize(name)
    @name = name # this is how the variable naming is normally done BTW
  end

  def what_is_the_name_of_this_CRM_again
    "Oh master, how could you forget? It was " + @name
  end
  .
  .
  .
end
```

You don't have to implement the `what_is_the_name_of_this_CRM_again` method, it was just for fun to show you how the `@name` instance variable can be used.

### Using a class method

Implement the `self.run` method in `crm.rb`:

```ruby
class CRM

  def self.run(name)
    crm = CRM.new(name)
    crm.main_menu
  end
  .
  .
  .
end
```

You might have noticed the word `self` in front of the names of the methods. When this is the case, the method is not an instance method, it is a *class method*. Class methods are called differently from instance methods:

```ruby
contact = Contact.new(...) # instance method
CRM.run 'Bitmaker CRM' # class method
```

If `run` was an instance method, we would have had to call it like this:

```ruby
an_instance_of_crm = CRM.new('Bitmaker CRM')
an_instance_of_crm.run
```

What purpose do class methods serve and why would we want to use them? This is a great example of where Object Oriented Design comes into play. Instance methods should involve logic that only make sense being applied to *an instance* of something, for example setting the email of *a* user, while a class method involves logic that should be applied on the whole scale of the model, for example cleaning up the email addresses of all the users. So the first example would be `user.set_email(email)` and the second `User.clean_email_addresses`.

In this case, our `run` class method takes care of initializing a new CRM instance and running the main menu afterwards, so the only code we need to run outside the class is minimized.

So go ahead and stick the `CRM.run` call at the bottom of the `crm.rb` file.

```ruby
class CRM
  .
  .
  .
end

CRM.run 'Bitmaker CRM'
```

## Running the Program

Run the CRM program at the command line:

```bash
ruby crm.rb
```

If all goes well, you will be presented with the main menu, from where you can then manually try out your program.

## What We've Learned

* Writing classes and creating new instances of them
* Instance methods
* Manipulating the initialize method
* Instance variables (for example `@name`)
* Getters and setters
* Class variables
* Class methods
* How to "import" a file with `require_relative`

And that is our first practical look at OOP! Please feel free to take your application to the next level by adding your own functionality where you see fit. We'll be letting those of you that want to show off your applications do so when they are due.

## Tips & Tricks

To enhance the user experience of your program, you can use `puts "\e[H\e[2J"` to clear your terminal screen.

## Additional Resources

* [Stack Overflow: `attr_accessor`, `attr_reader`, `attr_writer`](http://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer)
* [Blog - User Stories](http://codesqueeze.com/the-easy-way-to-writing-good-user-stories/)
* [Object Oriented Design](http://en.wikipedia.org/wiki/Object-oriented_design)
* [Instance Method versus Class Method – Stack Overflow](http://stackoverflow.com/questions/11655593/ruby-on-rails-should-i-use-class-method-or-instance-method-and-why)