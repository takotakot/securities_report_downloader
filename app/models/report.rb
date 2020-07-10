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
    raise unless FileTest.exist?(given_filename)
    raise if FileTest.zero?(given_filename)
    # TODO: type
    self.filename= given_filename
  end

  def rename_file
    # move file to the place where desined in the manifest
    self
  end
end
