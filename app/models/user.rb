class User < ActiveRecord::Base
  require 'digest/sha1'
  after_initialize :init

  has_many :paris
  has_many :matchs, :through => :paris

  validates :login, :presence => true,
                    :uniqueness => true

  validates :nom, :presence => true
  validates :prenom, :presence => true

  validates :passwd, :presence => true,
                     :length => { :minimum => 3, :maximum => 254}
		    
  validates :mail, :presence => true,
                   :uniqueness => true,
                   :format => { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create },
                   :length => { :minimum => 3, :maximum => 254}			

  validates :points, :numericality => {:greater_than_or_equal_to => 0}


  def init
    self.points  ||= 0          #will set the default value only if it's nil 
    self.valide  ||= false
  end

  def passwd=(passwd)
    if !passwd.nil? && !passwd.empty?
      self[:passwd] = User.encrypt_password(passwd)
    else
      self[:passwd] = nil
    end
  end

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest(password).inspect
  end

  def self.present?(login, password)
    u = User.find_by_login(login)
    !u.nil? && u.passwd == User.encrypt_password(password)
  end

 def self.exist?(id)
   User.find_by_login(id) != nil
 end

end
