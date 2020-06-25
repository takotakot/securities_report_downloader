class SbisecPage::Postub < SbisecPage::Base

  # mock
  def post?
    true
  end

  # mock
  def trash?
    true
  end

  # mock
  def get_line_per_page
    20
  end

  # mock
  def set_line_per_page
  end

  # mock
  def go_last_page
    self
  end

  # mock
  def go_first_page
    self
  end

  # mock
  def first_page?
    true
  end

  # mock
  def last_page?
    true
  end

  # TODO
  def dl_record
  end

  def messages
    @browser.find_element(class: 'message-list').find_elements(class: 'message')
  end

  # for test
  def messages_inner_html
    messages.each {|el| p el.attribute('innerHTML')}
  end
end
