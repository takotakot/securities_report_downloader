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
    self
  end
end
