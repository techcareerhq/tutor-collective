class Tutor < ActiveRecord::Base
  attr_accessible :email, :name, :password_hash, :wepay_access_token, :wepay_account_id, :password
	validates :password, :presence => true
  validates :password, :length => { :in => 6..200}
  validates :name, :email, :presence => true
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :format => { :with => /@/, :message => " is invalid" }

  def password
    password_hash ? @password ||= BCrypt::Password.new(password_hash) : nil
  end
 
  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

	def self.authenticate(email, test_password)
	  tutor = Tutor.find_by_email(email)
	  if tutor && tutor.password == test_password
	    tutor
	  else
	    nil
	  end
	end

  # get the authorization url for this tutor. This url will let the tutor 
  # register or login to WePay to approve our app.

  # returns a url
  def wepay_authorization_url(redirect_uri)
    Myapp::Application::WEPAY.oauth2_authorize_url(redirect_uri, self.email, self.name)
  end

  # takes a code returned by wepay oauth2 authorization and makes an api call to generate oauth2 token for this tutor.
  def request_wepay_access_token(code, redirect_uri)
    response = Myapp::Application::WEPAY.oauth2_token(code, redirect_uri)
    if response['error']
      raise "Error - "+ response['error_description']
    elsif !response['access_token']
      raise "Error requesting access from WePay"
    else
      self.wepay_access_token = response['access_token']
      self.save
    end
  end

  def has_wepay_access_token?
    !self.wepay_access_token.nil?
  end

  # makes an api call to WePay to check if current access token for tutor is still valid
  def has_valid_wepay_access_token?
    if self.wepay_access_token.nil?
      return false
    end
    response = Myapp::Application::WEPAY.call("/user", self.wepay_access_token)
    response && response["user_id"] ? true : false
  end

  # takes a code returned by wepay oauth2 authorization and makes an api call to generate oauth2 token for this tutor.
  def request_wepay_access_token(code, redirect_uri)
    response = Myapp::Application::WEPAY.oauth2_token(code, redirect_uri)
    if response['error']
      raise "Error - "+ response['error_description']
    elsif !response['access_token']
      raise "Error requesting access from WePay"
    else
      self.wepay_access_token = response['access_token']
      self.save

    #create WePay account
      self.create_wepay_account
    end
  end


  def has_wepay_account?
    self.wepay_account_id != 0 && !self.wepay_account_id.nil?
  end

  # creates a WePay account for this tutor with the tutor's name
  def create_wepay_account
    if self.has_wepay_access_token? && !self.has_wepay_account?
      params = { :name => self.tutor, :description => "Tutor selling " + self.produce }     
      response = Myapp::Application::WEPAY.call("/account/create", self.wepay_access_token, params)

      if response["account_id"]
        self.wepay_account_id = response["account_id"]
        return self.save
      else
        raise "Error - " + response["error_description"]
      end

    end   
    raise "Error - cannot create WePay account"
  end
# creates a checkout object using WePay API for this tutor
  def create_checkout(redirect_uri)
    # calculate app_fee as 10% of produce price
    app_fee = 1

    params = { 
      :account_id => self.wepay_account_id, 

      ## CHANGE ##
      :short_description => "Some Description",
      :type => :GOODS,
      :amount => 10,      
      :app_fee => app_fee,
      :fee_payer => :payee,     
      :mode => :iframe,
      :redirect_uri => redirect_uri
    }
    response = Myapp::Application::WEPAY.call('/checkout/create', self.wepay_access_token, params)

    if !response
      raise "Error - no response from WePay"
    elsif response['error']
      raise "Error - " + response["error_description"]
    end

    return response
  end
end
