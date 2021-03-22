# Securities Report Downloader

## Features

証券会社で交付される「報告書」の一括ダウンロードを支援する。現時点で、SBI 証券にのみ対応している。

## Deployment

**Requirements:**

- **Ruby** 2.7.1, 3.0.0 is tested
- **Chrome** 83.0.4103.116 is tested
- **ChromeDriver** 83.0.4103.39 is tested

**Main technology:**

- **Ruby on Rails** 6.0.3.5 is used
- **Selenium::WebDriver::Chrome**

Currently only `RAILS_ENV=development` is tested.

1. git clone

2. bundle install

        $ cd securities_report_downloader
        $ bundle install --path vendor/bundle

3. Database creation
    ```
    bin/rails db:create
    ```

4. Database initialization
    ```
    bin/rails db:migrate && bin/rails db:seed
    ```

5. Save credentials like below:

        $ bin/rails credentials:edit

    ```
    sbisec:
      id: <<id here>>
      password: <<password here>>
    driver_path: <<chromedriver path>>  # /usr/local/bin/chromedriver
    download_path: <<rails dir for browser>>  # /home/test/sbisec_postub_downloader/
    ```

## Usage

1. Open rails console

        $ bin/rails c

2. Run commands

    ```
    # open browser
    browser = WebDriverUtil.new_browser
    # login and goto postub page
    page = SbisecPage::Base.new(browser).login_with(Rails.application.credentials.sbisec[:id], Rails.application.credentials.sbisec[:password]).go_postub
    # download
    page.download_all
    ```

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).
