class SbisecPage::Base < SeleniumPage::Base

  LOGINPAGE_URL = 'https://site2.sbisec.co.jp/ETGate/'.freeze
  SWITCHNAVIMAIN_URL = 'https://m.sbisec.co.jp/switchnaviMain'.freeze
  JUMP_POSTUB_URL = 'https://m.sbisec.co.jp/edeliv/deisw070.jsp'.freeze

  # mock
  def login?
    begin
      @browser.find_element(id: 'logoutM')
    rescue => exception
      return false
    end

    true
  end

  def login_with(username, decrypt_password)
    return self if login?

    @browser.get LOGINPAGE_URL

    wait id: 'user_input'
    @browser.find_element(name: 'user_id').send_keys(username)
    @browser.find_element(name: 'user_password').send_keys(decrypt_password)
    @browser.find_element(name: 'ACT_login').click

    wait id: 'link02M'
    # @browser.get TOP_PAGE
    self
  end

  # def go_switchnaviMain
  #   @browser.find_element(id: 'link02M').find_element(link_text: '電子交付書面').click
  #   self
  # end

  # def switchnaviMain?
  #   if @browser.current_url != SWITCHNAVIMAIN_URL
  #     return false
  #   end

  #   begin
  #     @browser.find_element(class: 'headC01B')
  #   rescue => exception
  #     return false
  #   end

  #   true
  # end

  def go_postub
    @browser.get JUMP_POSTUB_URL
  end
end
