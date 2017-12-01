require_relative 'physicalperson'
require_relative 'controller'

class Crud

  public
  def self.insert_physicalperson(*args)
    pp = PhysicalPerson.new
    pp.name="#{args[0]}"
    pp.email="#{args[1]}"
    pp.salary="#{args[2]}"
    pp.birthday="#{args[3]}"
    pp.gender="#{args[4]}"
    ctr = Controller.new(pp)
    @result = ctr.insert_physicalperson
  end

  public
  def self.edit_physicalperson(*args)
    pp = PhysicalPerson.new
    pp.id="#{args[0]}"
    pp.name="#{args[1]}"
    pp.email="#{args[2]}"
    pp.salary="#{args[3]}"
    pp.birthday="#{args[4]}"
    pp.gender="#{args[5]}"
    ctr = Controller.new(pp)
    @result = ctr.edit_physicalperson
  end

  public
  def self.delete_physicalperson(id)
    pp = PhysicalPerson.new
    pp.id=id
    ctr = Controller.new(pp)
    @result = ctr.delete_physicalperson
  end

  public
  def self.get_physicalperson_by_name(name)
    pp = PhysicalPerson.new
    pp.name=name
    ctr = Controller.new(pp)
    @result = ctr.get_physicalperson_by_name
  end

  public
  def self.get_physicalperson_by_id(id)
    pp = PhysicalPerson.new
    pp.id=id
    ctr = Controller.new(pp)
    @result = ctr.get_physicalperson_by_id
  end

  public
  def self.check_email_registered(email)
    pp = PhysicalPerson.new
    pp.email=email
    ctr = Controller.new(pp)
    @result = ctr.check_email_registered
  end
end
