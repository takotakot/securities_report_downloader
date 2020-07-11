module WebDriverUtil
  def self.new_browser
    browser = Selenium::WebDriver.for(:chrome, options: SeleniumPage::Base::CHROME_OPTIONS)
    browser.download_path= self.download_path unless self.download_path.nil?
    browser
  end

  def self.download_path
    if Rails.application.credentials.download_path.present?
      Rails.application.credentials.download_path
    else
      Dir.pwd
    end
  end
end
