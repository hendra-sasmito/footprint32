class AddReviewsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :reviews_count, :integer, :default => 0
    # User.reset_column_information
    # User.all.each do |p|
      # p.update_attribute :reviews_count, p.reviews.length
    # end
  end
end
