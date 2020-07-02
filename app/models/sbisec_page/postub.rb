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
        title = ReportTitle::HASH_DATA.detect {|t|
          search = '「' + t[:name] + '」'
          ! title_text.index(search).nil?
        }
      else

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
