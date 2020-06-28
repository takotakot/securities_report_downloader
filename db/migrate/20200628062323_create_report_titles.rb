class CreateReportTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :report_titles do |t|
      t.string :name, null: false

      t.datetime :created_at, null: false
    end
  end
end
