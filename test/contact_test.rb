require 'minitest/autorun'
require_relative '../contact'

class TestContact < Minitest::Test

  def setup
    @contact = Contact.create('Foo', 'Bar', {email:'foo@bar.com', note: 'some note'})
  end

  def teardown
    Contact.delete_all
  end

  def test_all
    assert_equal [@contact], Contact.all
  end

  def test_get
    assert_equal @contact, Contact.get(1)
  end

  def test_search_by_attribute
    assert_equal [@contact], Contact.search_by_attribute('first_name', 'Foo')
  end

  def test_delete_all
    Contact.delete_all
    assert_equal 0, Contact.all.size
  end

  def test_full_name
    assert_equal 'Foo Bar', @contact.full_name
  end

  def test_update
    @contact.update('note', 'some other note')
    assert_equal 'some other note', @contact.note
  end

  def test_delete
    @contact.delete
    assert [], Contact.all
  end

end
