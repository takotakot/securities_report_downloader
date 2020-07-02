class SeleniumPage::Base
  # < ApplicationRecord
  attr_accessor :browser, :wait

  CHROME_OPTIONS = Selenium::WebDriver::Chrome::Options.new(args: [
  ].concat( Rails.env.development? ? [] : ['headless'] )
  ).freeze
  BROWSER_TIME_OUT = 20

  def initialize(browser)
    @browser = browser
    @wait = Selenium::WebDriver::Wait.new(timeout: BROWSER_TIME_OUT)
  end

  def close
    @browser.close
    self
  end

  def quit
    @browser.quit
    self
  end

  def wait(target)
    @wait.until { @browser.find_elements(target).present? && @browser.find_element(target).displayed? }
    self
  end

  def wait_css(css)
    wait.until { @browser.find_element(css).enabled? }
    self
  end

  def current_url
    @browser.current_url
  end

  def click(element)
    @browser.execute_script("arguments[0].click();", element)
    self
  end

  def click_css(css)
    click @browser.find_element(css)
  end

  def move_to(element)
    @browser.action.move_to(element).perform
    self
  end

  def browser_back
    @browser.navigate.back
    self
  end
end
