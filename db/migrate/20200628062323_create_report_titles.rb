class CreateReportTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :report_titles do |t|
      t.string :name

      t.timestamps
    end
  end
end
