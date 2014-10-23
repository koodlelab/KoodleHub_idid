class User
  attr_accessor :name, :email

  def initialize(attributes)
    @name = attributes[:name]
    @email = attributes[:email]
  end

  def formmatedEmail
    "#{@name} <#{@email}>"
  end
end