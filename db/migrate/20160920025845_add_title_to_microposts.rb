class AddTitleToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :post_title, :string
  end
end
