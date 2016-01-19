class Contact

  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note
  #
  # def first_name=(str)
  #   @first_name = str
  # end


  @@contacts = []
  @@id = 1

  def initialize(id, first_name, last_name, options = {})
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = options[:email]
    @note = options[:note]
  end

  def self.create(first_name, last_name, options = {})
    # 1. Create a new contact
    # 2. Assign the new contact a unique id
    #Contact.create("Matthew", "Smith", {email: "msmithros@hotmail.com", note: "Awsomes"})
    #Entering values into the options hash does not require an "=" sign
    new_contact = Contact.new(@@id, first_name, last_name, options)
    # 3. Add the new contact to the list
    # The shovel pushes into the @@contacts array

    @@contacts << new_contact
    # 4. Increment the global id
    @@id += 1
    new_contact
  end


  def self.all
    #Why does this method return a list and the full array?
    #Is there a method that returns just the list?
    #Is there another way to do this?
    #p returns the value of a variable AND and object
    @@contacts
    #@@Contacts
  end

  def self.get(id)
    # Implement this method
    # 1. Find contact that has an id = 1
    @@contacts.find { |contact| contact.id == id }
  end

  def self.search_by_attribute(name, value)
    #Why didn't this work?
    #@@contacts.each {|x| puts name}
    @@contacts.select {|contact| contact.name == value}
    # case name
    # when "first_name" then @@contacts
  end


  def self.search_by_attribute(name, value)
    # object.send(method)calls the "method" method on the object
    # so you can pass in a string or symbol reprenting the method
    # you want to call(in this case the getter for the attribute in question)
    @@contacts.select {|contact| contact.send(name) == value}
  end

  def self.delete_all
    @@contacts = []
    @@id = 1
  end

  def full_name
    return "#{first_name} #{last_name}"
  end

  def update(attribute, value)
    # self.send((attribute.to_s + "=").to_sym, value)
    self.send("#{attribute}=", value)
    #puts "#{self.(first_name)}"
  end

  # def update(attribute, value)
  #   # self.select {|instance_var| instance_var.send(attribute) == value}
  #   self.send(attribute, value)
  #   puts "#{self.send(first_name)}"
  # end

  def delete
  #call the self.get method with the id of the current instance as the argument
  #we must use self.class.get to call this because it is a class method.
  #self.class => Contact....self.class.get(@id) => Contact.get(@id) where @id is the id of the current instance
  #@@contacts.delete deletes the contact that is returned by self.glass.get(@id)
    @@contacts.delete(self.class.get(@id))
  end
end
