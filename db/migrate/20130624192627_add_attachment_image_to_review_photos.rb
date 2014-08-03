class AddAttachmentImageToReviewPhotos < ActiveRecord::Migration
  def self.up
    change_table :review_photos do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :review_photos, :image
  end
end
