class AddReviewsCountToPlace < ActiveRecord::Migration
  def change
    add_column :places, :reviews_count, :integer, :default => 0
    # Place.reset_column_information
    # Place.all.each do |p|
      # p.update_attribute :reviews_count, p.reviews.length
    # end
  end
end
