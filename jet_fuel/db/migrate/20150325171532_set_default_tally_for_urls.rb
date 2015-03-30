class SetDefaultTallyForUrls < ActiveRecord::Migration
  def change
    change_column :urls, :click_tally, :integer, default: 0
  end
end
