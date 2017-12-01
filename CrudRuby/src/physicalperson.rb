require_relative 'iperson'

class PhysicalPerson
  include(IPerson)

  attr_accessor :id
  attr_accessor :name
  attr_accessor :email
  attr_accessor :salary
  attr_accessor :birthday
  attr_accessor :gender
end