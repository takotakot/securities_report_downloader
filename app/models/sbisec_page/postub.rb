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

  def go_last_page
    @browser.find_element(class: 'pager').find_element(css: '._arrow.-outer.-right').click
    self
  end

  def go_first_page
    @browser.find_element(class: 'pager').find_element(css: '._arrow.-outer.-left').click
    self
  end

  def go_next_page
    @browser.find_element(class: 'pager').find_element(css: '._arrow:not(.-outer).-right').click
    self
  end

  def go_prev_page
    @browser.find_element(class: 'pager').find_element(css: '._arrow:not(.-outer).-left').click
    self
  end

  def first_page?
    begin
      @browser.find_element(class: 'pager').find_element(css: '._arrow.-outer.-left')
      false
    rescue NoSuchElementError => exception
      true
    end
  end

  def last_page?
    begin
      @browser.find_element(class: 'pager').find_element(css: '._arrow.-outer.-right')
      false
    rescue NoSuchElementError => exception
      true
    end
  end

  def download_all_backward
    go_last_page unless last_page?
    while true
      download_backward_in_page
      break if first_page?
      go_prev_page
    end
  end

  def download_backward_in_page
    count = messages.count
    for i in 0...messages.count
      dl_record_with_check(messages.reverse[i])
    end
  end

  def scrape_report_record(system_id, message_element)
    # date, type, title, limit
    # p message_element.find_element(class: 'date').text
    # p message_element.find_element(class: 'type').text
    # p message_element.find_element(class: 'title').text
    # p message_element.find_element(class: 'limit').text

    # download new
    report_data = {
      system_id: system_id,
      issue_date: message_element.find_element(class: 'date').text,
      limit_date: message_element.find_element(class: 'limit').text,
    }

    type = message_element.find_element(class: 'type').text
    type_id = type_text2type_id(type)
    report_data[:report_type_id] = type_id

    title = message_element.find_element(class: 'title').text
    if type_id == ReportType::ID_運用報告書
      title_id = ReportTitle::ID_運用報告書
      report_data[:special_title] = special_title(title)
    else
      title_id = title_text2title_id(title)
      if title_id == ReportTitle::ID_UNDEFINED
        report_data[:special_title] = special_title(title)
      end
    end
    report_data[:report_title_id] = title_id

    report_data
  end

  def dl_record(system_id, message_element)
    report_data = scrape_report_record(system_id, message_element)

    # p report_data
    repo = Report.find_by(system_id: system_id)
    if repo.nil? || ! repo.downloaded
      repo = Report.create(report_data)
    end

    begin
      go_detail_page(system_id, message_element).detail_page_download_pdf.browser_back
      wait_download
      repo.set_file(system_id.to_s + '.PDF'.freeze)
      repo.save!
    rescue => exception
      raise exception
    end

    # TODO
    # repo.set_manifest
    repo.rename_file
    self
  end

  def wait_download
    sleep 2
  end

  def dl_record_with_check(message_element)
    system_id = message2system_id(message_element)
    repo = Report.find_by(system_id: system_id)

    if repo.nil? || ! repo.downloaded
      dl_record(system_id, message_element)
    end

    self
  end

  def message2system_id(message_element)
    /'(\d+)'/.match(message_element.find_element(class: 'title').find_element(tag_name: 'a').attribute('onClick')).to_a[1]
  end

  def type_text2type_id(type_text)
    type = ReportType::HASH_DATA.detect {|t| t[:name] == type_text}

    if type.nil?
      nil
    else
      type[:id]
    end
  end

  def title_text2title_id(title_text)
    title = ReportTitle::HASH_DATA.detect {|t|
      search = '「' + t[:name] + '」'
      ! title_text.index(search).nil?
    }

    unless title.nil?
      title[:id]
    else
      unless title_text.index('運用報告書'.freeze).nil?
        ReportTitle::ID_運用報告書
      else
        ReportTitle::ID_UNDEFINED
      end
    end
  end

  def special_title(title_text)
    # 「ブラックロック・スーパー・マネー・マーケット・ファンド（米ドル）」運用報告書
    # 2019年09月30日決算「ひふみプラス運用報告書」電子交付のお知らせ
    title_text.gsub(/電子交付のお知らせ/, '')
  end

  def messages
    @browser.find_element(class: 'message-list').find_elements(class: 'message')
  end

  # for test
  def messages_inner_html
    messages.each {|el| p el.attribute('innerHTML')}
  end

  def go_detail_page(system_id, message_element)
    message_element.find_element(class: 'title').find_element(tag_name: 'a').click
    self
  end

  def detail_page_download_pdf
    @browser.find_element(class: 'display-area').find_element(link_text: 'ダウンロード').click
    self
  end
end
