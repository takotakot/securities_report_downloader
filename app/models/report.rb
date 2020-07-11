class Report < ApplicationRecord
  belongs_to :report_type
  belongs_to :report_title

  attr_accessor :manifest

  def downloaded
    return false if filename.nil?
    return false if filename == ""
    true
  end

  def set_file(given_filename)
    raise unless check_file(given_filename)
    self.filename= given_filename
  end

  def check_file(given_filename)
    return false unless FileTest.exist?(given_filename)
    return false if FileTest.zero?(given_filename)
    # TODO: type
    true
  end

  def rename_file
    # move file to the place where desined in the manifest
    raise unless check_file(filename)

    extname = File.extname(filename)
    cur_dirname = File.dirname(filename)
    cur_basename_without_ext = File.basename(filename, extname)

    # TODO: manifest
    # TODO: change_manifest
    date = issue_date
    new_dir = date.year.to_s + File::Separator + format('%02d', date.month)
    FileUtils.mkdir_p(new_dir)
    new_baseename = system_id + '_' + report_title.for_filename + extname
    new_filename = new_dir + File::Separator + new_baseename

    begin
      File.rename(filename, new_filename)
      # TODO: database error
      self.filename= new_filename
      save!
    rescue => exception
      false
    end
  end
end
