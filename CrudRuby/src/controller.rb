require_relative 'physicalperson'
require_relative 'connection'

class Controller

  public
  def initialize(pp)
    @pp = pp
    @conn = Connection::connect
  end

  protected
  def generateid
    begin
      query = 'SELECT MAX(ID)+1 FROM PERSON'
      @id = @conn.get_first_value query
    rescue Exception
      @id = 1
    end
  end

  def insertperson(id, name, email)
    begin
      query = 'INSERT INTO PERSON VALUES(?,?,?)'
      @conn.execute(query, id, name, email)
      @result = 1
    rescue Exception
      @result = -1
    end
  end

  def insertphysicalperson
    begin
      query = 'INSERT INTO PHYSICALPERSON VALUES(?,?,?,?,?)'
      @conn.execute(query, @pp.id, @pp.id, @pp.salary, @pp.birthday, @pp.gender)
      @result = 1
    rescue Exception
      @result = -1
    end
  end

  def editperson(id, name, email)
    begin
      query = 'UPDATE PERSON SET NAME = ?, EMAIL = ? WHERE ID = ?'
      @conn.execute(query, name, email, id)
      @result = 1
    rescue Exception
      @result = -1
    end
  end

  def editphysicalperson
    begin
      query = 'UPDATE PHYSICALPERSON SET SALARY = ?, BIRTHDAY = ?, GENDER = ? WHERE ID = ?'
      @conn.execute(query, @pp.salary, @pp.birthday, @pp.gender, @pp.id)
      @result = 1
    rescue Exception
      @result = -1
    end
  end

  def deleteperson(id)
    begin
      query = 'DELETE FROM PERSON WHERE ID = ?'
      @conn.execute(query, id)
      @result = 1
    rescue Exception => e
      puts e.message
      @result = -1
    end
  end

  def deletephysicalperson
    begin
      query = 'DELETE FROM PHYSICALPERSON WHERE ID = ?'
      @conn.execute(query, @pp.id)
      @result = 1
    rescue Exception => e
      puts e.message
      @result = -1
    end
  end

  public
  def insert_physicalperson
    begin
      id = self.generateid
      @conn.transaction
      if id > 0
        @pp.id = id
        if self.insertperson(@pp.id, @pp.name, @pp.email).equal? 1
          if self.insertphysicalperson.equal? 1
            @conn.commit
            return 1
          else
            @conn.rollback
            @result = -1
          end
        else
          @conn.rollback
          @result = -1
        end
      else
        @result = -1
      end
    end
  rescue Exception
    @result = -1
  end


  def edit_physicalperson
    begin
      @conn.transaction
      if self.editperson(@pp.id, @pp.name, @pp.email).equal? 1
        if self.editphysicalperson.equal? 1
          @conn.commit
          return 1
        else
          @conn = nil
          @result = -1
        end
      else
        @conn = nil
        @result = -1
      end
    rescue Exception
      @conn = nil
      @result = -1
    end
  end

  def delete_physicalperson
    begin
      @conn.transaction
      if self.deletephysicalperson.equal? 1
        if self.deleteperson(@pp.id).equal? 1
          @conn.commit
          return 1
        else
          @conn = nil
          @result = -1
        end
      else
        @conn = nil
        @result = -1
      end
    rescue Exception
      @conn = nil
      @result = -1
    end
  end

  def get_physicalperson_by_name
    begin
      query = 'SELECT * FROM PERSON INNER JOIN PHYSICALPERSON ON PERSON.ID = PHYSICALPERSON.PERSON_ID WHERE NAME LIKE ?'
      stm = @conn.prepare query
      stm.bind_param 1, @pp.name + '%'
      @conn = nil
      @result = stm.execute
    rescue Exception
      @result = nil
    end
  end

  def get_physicalperson_by_id
    begin
      query = 'SELECT * FROM PERSON INNER JOIN PHYSICALPERSON ON PERSON.ID = PHYSICALPERSON.PERSON_ID WHERE PERSON.ID = ?'
      stm = @conn.prepare query
      stm.bind_param 1, @pp.id
      @conn = nil
      @result = stm.execute
    rescue Exception
      @result = nil
    end
  end
end
