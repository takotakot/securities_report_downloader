class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :system_id
      t.references :report_type, null: false, foreign_key: true
      t.references :report_title, null: false, foreign_key: true
      t.string :special_title
      t.date :issue_date, null: false
      t.date :limit_date
      t.string :filename
      t.string :path

      t.timestamps
    end
    add_index :reports, :system_id
  end
end
